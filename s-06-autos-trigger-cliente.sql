--@Autor:           J. Miguel Arroyo Quiroz, Arturo Perez Quintana
--@Fecha:           03/06/2024
--@Descripción:     Creación del Trigger Instead of Para la Vista Cliente

create or replace trigger t_dml_cliente
instead of insert or update or delete on cliente
declare

begin
	case 
		when inserting then
            --Inserción Nodo 2
			if substr(:new.ap_paterno,1,1) between 'A' and 'I' then
				insert into cliente_f1(cliente_id, nombre, ap_paterno, 
                    ap_materno, num_identificacion, email)
				values(:new.cliente_id, :new.nombre, :new.ap_paterno, 
                    :new.ap_materno, :new.num_identificacion, :new.email);
			elsif substr(:new.ap_paterno,1,1) between 'a' and 'i' then
				insert into cliente_f1(cliente_id, nombre, ap_paterno, 
                    ap_materno, num_identificacion, email)
				values(:new.cliente_id, :new.nombre, :new.ap_paterno, 
                    :new.ap_materno, :new.num_identificacion, :new.email);
            --Inserción Nodo 3
			elsif substr(:new.ap_paterno,1,1) between 'J' and 'Q' then
				insert into cliente_f2(cliente_id, nombre, ap_paterno, 
                    ap_materno, num_identificacion, email)
				values(:new.cliente_id, :new.nombre, :new.ap_paterno, 
                    :new.ap_materno, :new.num_identificacion, :new.email);
			elsif substr(:new.ap_paterno,1,1) between 'j' and 'q' then
				insert into cliente_f2(cliente_id, nombre, ap_paterno, 
                    ap_materno, num_identificacion, email)
				values(:new.cliente_id, :new.nombre, :new.ap_paterno, 
                    :new.ap_materno, :new.num_identificacion, :new.email);
            --Inserción Nodo 4
			elsif substr(:new.ap_paterno,1,1) between 'R' and 'Z' then
				insert into cliente_f3(cliente_id, nombre, ap_paterno, 
                    ap_materno, num_identificacion, email)
				values(:new.cliente_id, :new.nombre, :new.ap_paterno, 
                    :new.ap_materno, :new.num_identificacion, :new.email);
			elsif substr(:new.ap_paterno,1,1) between 'r' and 'z' then
				insert into cliente_f3(cliente_id, nombre, ap_paterno, 
                    ap_materno, num_identificacion, email)
				values(:new.cliente_id, :new.nombre, :new.ap_paterno, 
                    :new.ap_materno, :new.num_identificacion, :new.email);
			else
				raise_application_error(-20010, 
					'Valor incorrecto para el campo ap_paterno : '
        			|| :new.ap_paterno
                   	|| ' Solo se permiten valores entre la A y la Z ');
			end if;
		
		when updating then
            raise_application_error(-20030, 
				'Operación Update aún no soportada');

		when deleting then
            --Eliminación Nodo 2
			if substr(:old.ap_paterno,1,1) between 'A' and 'I' or substr(:old.ap_paterno,1,1) between 'a' and 'i' then
				delete from cliente_f1 where cliente_id = :old.cliente_id;
            --Eliminación Nodo 3
			elsif substr(:old.ap_paterno,1,1) between 'J' and 'Q' then
				delete from cliente_f2 where cliente_id  = :old.cliente_id;
			elsif substr(:old.ap_paterno,1,1) between 'j' and 'q' then
				delete from cliente_f2 where cliente_id  = :old.cliente_id;
            --Eliminación Nodo 4
            elsif substr(:old.ap_paterno,1,1) between 'R' and 'Z' then
				delete from cliente_f3 where cliente_id  = :old.cliente_id;
			elsif substr(:old.ap_paterno,1,1) between 'r' and 'z' then
				delete from cliente_f3 where cliente_id  = :old.cliente_id;
			else
				raise_application_error(-20010, 
					'Valor incorrecto para el campo ap_paterno : '
        			|| :old.ap_paterno
                   	|| ' Solo se permiten valores entre la A y la Z ');
			end if;
	end case;
end;
/