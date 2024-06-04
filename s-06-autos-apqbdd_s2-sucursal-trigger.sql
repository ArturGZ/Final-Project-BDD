--@Autor:           J. Miguel Arroyo Quiroz, Arturo Perez Quintana
--@Fecha:           02/06/2024
--@Descripción:     Creación del Trigger Instead of Para la Vista Sucursal
--                  en el Nodo 4 APQBDD_S2

create or replace trigger t_dml_sucursal
instead of insert or update or delete on sucursal
declare
 	v_count number;
begin
	case 
		when inserting then
			--Inserción Remota Nodo 3
            if :new.clave like '00000%' then
				insert into sucursal_f1(sucursal_id,
					nombre, clave, sucursal_anexa_id, pais_id)
				values(:new.sucursal_id,:new.nombre,
					:new.clave,:new.sucursal_anexa_id,:new.pais_id);
            else
                select count(*) into v_count
			    from pais_f1
			    where pais_id =:new.pais_id;
			    --insercion Remota Nodo 1
			    if v_count > 0 then
				    insert into sucursal_f2(sucursal_id,
					    nombre, clave, sucursal_anexa_id, pais_id)
				    values(:new.sucursal_id,:new.nombre,
					    :new.clave,:new.sucursal_anexa_id,:new.pais_id);	
			    else 
				    select count(*) into v_count
				    from pais_f2
				    where pais_id =:new.pais_id;
                    --insercion remota Nodo 2
				    if v_count > 0 then
					    insert into sucursal_f3(sucursal_id,
						    nombre, clave, sucursal_anexa_id, pais_id)
					    values(:new.sucursal_id,:new.nombre,
    						:new.clave,:new.sucursal_anexa_id,:new.pais_id);
                    else
			 		    raise_application_error(-20020, 
                		    'Error de integridad para el campo pais_id : '
                		    ||  :new.pais_id
                		    || ' No se encontró el registro padre en fragmentos');   
			 	    end if;
			    end if;
            end if;

		when updating then
     		raise_application_error(-20030, 
                'Operación Update aún no soportada');

		when deleting then
			if :old.clave like '00000%' then
                delete from sucursal_f1 where sucursal_id = :old.sucursal_id;
			else
			--eliminación remota
				select count(*) into v_count
				from pais_f2
				where pais_id =:old.pais_id;
				if v_count > 0 then
					delete from sucursal_f3 where sucursal_id = :old.sucursal_id;
				--eliminación remota
				else 
					select count(*) into v_count
					from pais_f1
					where pais_id =:old.pais_id;
					if v_count > 0 then
						delete from sucursal_f2 where sucursal_id = :old.sucursal_id;
					else
						raise_application_error(-20020, 
							'Error de integridad para el campo pais_id : '
							||  :old.pais_id
							|| ' No se encontró el registro padre en fragmentos');   
					end if;
				end if;
			end if;
	end case;
end;
/