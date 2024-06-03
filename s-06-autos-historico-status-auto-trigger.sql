--@Autor:           J. Miguel Arroyo Quiroz, Arturo Perez Quintana
--@Fecha:           03/06/2024
--@Descripción:     Creación del Trigger Instead of Para la Vista Historico_Status_Auto

create or replace trigger t_dml_historico_status_auto
instead of insert or update or delete on historico_status_auto
declare
 
begin
	case 
		when inserting then
			if :new.fecha_status < to_date('01/01/2011','dd/mm/yyyy') then
				insert into historico_status_auto_f1(historico_status_id, 
                    fecha_status, status_auto_id, auto_id)
				values(:new.historico_status_id, :new.fecha_status, 
                    :new.status_auto_id, :new.auto_id);
			elsif :new.fecha_status >= to_date('01/01/2011','dd/mm/yyyy') then
				insert into historico_status_auto_f2(historico_status_id, 
                    fecha_status, status_auto_id, auto_id)
				values(:new.historico_status_id, :new.fecha_status, 
                    :new.status_auto_id, :new.auto_id);
			else
				raise_application_error(20010, 
					'Valor incorrecto para el campo fecha_status : '
        			|| :new.fecha_status);
			end if;
		
		when updating then
            raise_application_error(20030, 
				'Operación Update aún no soportada');

		when deleting then 
			if :old.fecha_status < to_date('01/01/2011','dd/mm/yyyy') then
				delete from historico_status_auto_f1 where pais_id = :old.pais_id;
			elsif :old.fecha_status >= to_date('01/01/2011','dd/mm/yyyy') then
				delete from historico_status_auto_f2 where pais_id  = :old.pais_id;
			else
				raise_application_error(20010, 
					'Valor incorrecto para el campo fecha_status : '
        			|| :old.fecha_status);
			end if;
	end case;
end;
/