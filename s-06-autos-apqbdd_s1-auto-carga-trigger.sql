--@Autor:           J. Miguel Arroyo Quiroz, Arturo Perez Quintana
--@Fecha:           03/06/2024
--@Descripción:     Creación del Trigger Instead of Para la Vista Auto Carga
--                  en el Nodo 3 APQBDD_S1

create or replace trigger t_dml_auto_carga
instead of insert or update or delete on auto_carga
declare
 	v_count number;
begin
	case 
		when inserting then
			select count(*) into v_count
			from auto_f2
			where auto_id =:new.auto_id;
			--Insercion Nodo 1
			if v_count > 0 then
				insert into auto_carga_f1(auto_id, peso_maximo, volumen, tipo_combustible)
				values(:new.auto_id, :new.peso_maximo, :new.volumen, :new.tipo_combustible);
			--Insercion Nodo 2
			else 
				select count(*) into v_count
				from auto_f3
				where auto_id =:new.auto_id;
				if v_count > 0 then
					insert into auto_carga_f2(auto_id, peso_maximo, volumen, tipo_combustible)
					values(:new.auto_id, :new.peso_maximo, :new.volumen, :new.tipo_combustible);
				else
			 		raise_application_error(-20020, 
                		'Error de integridad para el campo auto_id : '
                		||  :new.auto_id
                		|| ' No se encontró el registro padre en fragmentos');   
			 	end if;
			end if;

		when updating then
     		raise_application_error(-20030, 
                'Operación Update aún no soportada');

		when deleting then 
			select count(*) into v_count
			from auto_f2
			where auto_id =:old.auto_id;
			--Eliminación Nodo 1
			if v_count > 0 then
                delete from auto_carga_f1 where auto_id = :old.auto_id;
			--Eliminación Nodo 2
			else 
				select count(*) into v_count
				from auto_f3
				where auto_id =:old.auto_id;
				if v_count > 0 then
					delete from auto_carga_f2 where auto_id = :old.auto_id;
			 	else
			 		raise_application_error(-20020, 
                		'Error de integridad para el campo auto_id : '
                		||  :old.auto_id
                		|| ' No se encontró el registro padre en fragmentos');   
			 	end if;
			end if;
	end case;
end;
/