--@Autor:           J. Miguel Arroyo Quiroz, Arturo Perez Quintana
--@Fecha:           02/06/2024
--@Descripción:     Creación del Trigger Instead of Para la Vista Pais

create or replace trigger t_dml_pais
instead of insert or update or delete on pais
declare
 
begin
	case 
		when inserting then
			if :new.region = 'AME' then
				insert into pais_f1(pais_id, nombre, clave, region)
				values(:new.pais_id, :new.nombre, :new.clave, :new.region);
			elsif :new.region = 'EUR' then
				insert into pais_f2(pais_id, nombre, clave, region)
				values(:new.pais_id, :new.nombre, :new.clave, :new.region);
			else
				raise_application_error(-20010, 
					'Valor incorrecto para el campo region : '
        			|| :new.region
                   	|| ' Solo se permiten los valores AME y EUR ');
			end if;
		
		when updating then
            raise_application_error(-20030, 
				'Operación Update aún no soportada');

		when deleting then 
			if :old.region ='AME' then
				delete from pais_f1 where pais_id = :old.pais_id;
			elsif :old.region='EUR' then
				delete from pais_f2 where pais_id  = :old.pais_id;
			else
				raise_application_error(-20010, 
					'Valor incorrecto para el campo region : '
        			|| :old.region
                   	|| ' Solo se permiten los valores AME y EUR ');
			end if;
	end case;
end;
/