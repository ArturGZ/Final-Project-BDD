--@Autor:           J. Miguel Arroyo Quiroz, Arturo Perez Quintana
--@Fecha:           03/06/2024
--@Descripción:     Creación del Trigger Instead of Para la Vista Auto
--                  en el Nodo 3 APQBDD_S1

create or replace trigger t_dml_auto
instead of insert or update or delete on auto
declare
 	v_count number;
begin
	case 
		when inserting then
			select count(*) into v_count
			from sucursal_f2
			where sucursal_id =:new.sucursal_id;
			if v_count > 0 then
                --Insercion Nodo 1
				insert into auto_f2(auto_id, anio, num_serie, tipo, precio,
					fecha_status, sucursal_id, status_auto_id, modelo_id)
				values(:new.auto_id,:new.anio,:new.num_serie,:new.tipo,:new.precio,
					:new.fecha_status,:new.sucursal_id,:new.status_auto_id,:new.modelo_id);
			else 
				select count(*) into v_count
				from sucursal_f3
				where sucursal_id =:new.sucursal_id;
				if v_count > 0 then
                    --Insercion Nodo 2
					insert into auto_f3(auto_id, anio, num_serie, tipo, precio,
					    fecha_status, sucursal_id, status_auto_id, modelo_id)
					values(:new.auto_id,:new.anio,:new.num_serie,:new.tipo,:new.precio,
					    :new.fecha_status,:new.sucursal_id,:new.status_auto_id,:new.modelo_id);
				else
			 		raise_application_error(20020, 
                		'Error de integridad para el campo sucursal_id : '
                		||  :new.sucursal_id
                		|| ' No se encontró el registro padre en fragmentos');   
			 	end if;
			end if;
            --Inserción del blob (Tabla Temporal)
            insert into ts_auto_f1(auto_id, foto)
		    values(:new.auto_id, :new.foto);
		    --inserta en el sitio remoto a través de la tabla temporal
		    insert into auto_f1 
    			select * from ts_auto_f1
			    where auto_id = :new.auto_id;
		    delete from ts_auto_f1
    			where auto_id = :new.auto_id;  

		when updating then
     		raise_application_error(20030, 
                'Operación Update aún no soportada');

		when deleting then 
			select count(*) into v_count
			from sucursal_f2
			where sucursal_id =:old.sucursal_id;
			if v_count > 0 then
            	--Eliminación Nodo 1
                delete from auto_f2 where auto_id = :old.auto_id;
			else 
				select count(*) into v_count
				from sucursal_f3
				where sucursal_id =:old.sucursal_id;
				if v_count > 0 then
                    --Eliminación Nodo 2
					delete from auto_f3 where auto_id = :old.auto_id;
			 	else
			 		raise_application_error(20020, 
                		'Error de integridad para el campo sucursal_id : '
                		||  :old.sucursal_id
                		|| ' No se encontró el registro padre en fragmentos');   
			 	end if;
			end if;
            --Elimina el binario Nodo 4
            delete from auto_f1 where auto_id = :old.auto_id;
	end case;
end;
/