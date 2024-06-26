--@Autor:           J. Miguel Arroyo Quiroz, Arturo Perez Quintana
--@Fecha:           03/06/2024
--@Descripción:     Creación del Trigger Instead of Para la Vista Auto Particular
--                  en el Nodo 2 MAQBDD_S2

create or replace trigger t_dml_auto_particular
instead of insert or update or delete on auto_particular
declare
 	v_count number;
begin
	case 
		when inserting then
			--verifica si hay correspondencia local para evitar acceso remoto
			select count(*) into v_count
			from auto_f3
			where auto_id =:new.auto_id;
			--insercion local
			if v_count > 0 then
				insert into auto_particular_f2(auto_id, num_cilindros, num_pasajeros, clase)
				values(:new.auto_id, :new.num_cilindros, :new.num_pasajeros, :new.clase);
			--insercion remota
			else 
				select count(*) into v_count
				from auto_f2
				where auto_id =:new.auto_id;
				if v_count > 0 then
					insert into auto_particular_f1(auto_id, num_cilindros, num_pasajeros, clase)
					values(:new.auto_id, :new.num_cilindros, :new.num_pasajeros, :new.clase);
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
            --verifica si hay correspondencia local para evitar acceso remoto
			select count(*) into v_count
			from auto_f3
			where auto_id =:old.auto_id;
			--eliminación local
			if v_count > 0 then
                delete from auto_particular_f2 where auto_id = :old.auto_id;
			--eliminación remota
			else 
				select count(*) into v_count
				from auto_f2
				where auto_id =:old.auto_id;
				if v_count > 0 then
					delete from auto_particular_f1 where auto_id = :old.auto_id;
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