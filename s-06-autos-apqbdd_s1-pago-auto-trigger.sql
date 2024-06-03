--@Autor: Arturo Pérez Quintana, J. Miguel Arroyo Quiroz
--@Fecha creación: 2/06/2024
--@Descripción: Creación de trigger para replicacion síncrona 
-- de tabla pago_auto.

create or replace trigger t_dml_pago_auto
    instead of insert or update or delete on pago_auto
declare
    v_count number;
    v_count2 number;
begin
    case
        when inserting then
            v_count := 0;
            --replica 1 con validacion de integridad
            select count(*) into v_count2
            from cliente_f1
            where cliente_id =:new.cliente_id
            and auto_id=:new.auto_id;
            if v_count2 > 0 then
                --inserta el binario, uso de tabla temporal
                insert into ti_pago_auto_f1(cliente_id,auto_id,
                    fecha_pago,importe,recibo_pago)
                values (:new.cliente_id,:new.auto_id,:new.fecha_pago,
                    :new.importe,:new.recibo_pago);
            
                --inserta en el sitio remoto a través de la tabla temporal
                insert into pago_auto_f1 
                    select * from ti_pago_auto_f1
                    where cliente_id =:new.cliente_id
                        and auto_id=:new.auto_id;
                delete from ti_pago_auto_f1
                    where cliente_id =:new.cliente_id
                        and auto_id=:new.auto_id;  

                v_count := v_count + sql%rowcount;
            else
                raise_application_error(20020, 
                    'Error de integridad para el campo cliente_id : '
                    || :new.cliente_id
                    || ' con el campo auto_id : ' 
                    || :new.auto_id
                    || ' No se encontró el registro padre en fragmentos');     
            end if;
            
            --replica 2
            select count(*) into v_count2
            from cliente_f2
            where cliente_id =:new.cliente_id
            and auto_id=:new.auto_id;
            if v_count2 > 0 then
                --inserta el binario de manera local
                insert into pago_auto_f2(cliente_id,auto_id,
                    fecha_pago,importe,recibo_pago)
                values (:new.cliente_id,:new.auto_id,:new.fecha_pago,
                    :new.importe,:new.recibo_pago);
                        
                v_count := v_count + sql%rowcount;
            else
                raise_application_error(20020, 
                    'Error de integridad para el campo cliente_id : '
                    || :new.cliente_id
                    || ' con el campo auto_id : ' 
                    || :new.auto_id
                    || ' No se encontró el registro padre en fragmentos');     
            end if;

            --replica 3
            select count(*) into v_count2
            from cliente_f3
            where cliente_id =:new.cliente_id
            and auto_id=:new.auto_id;
            if v_count2 > 0 then
                --inserta el binario, uso de tabla temporal
                insert into ti_pago_auto_f3(cliente_id,auto_id,
                    fecha_pago,importe,recibo_pago)
                values (:new.cliente_id,:new.auto_id,:new.fecha_pago,
                    :new.importe,:new.recibo_pago);
            
                --inserta en el sitio remoto a través de la tabla temporal
                insert into pago_auto_f3 
                    select * from ti_pago_auto_f3
                    where cliente_id =:new.cliente_id
                        and auto_id=:new.auto_id;
                delete from ti_pago_auto_f3
                    where cliente_id =:new.cliente_id
                        and auto_id=:new.auto_id;  
                        
                v_count := v_count + sql%rowcount;
            else
                raise_application_error(20020, 
                    'Error de integridad para el campo cliente_id : '
                    || :new.cliente_id
                    || ' con el campo auto_id : ' 
                    || :new.auto_id
                    || ' No se encontró el registro padre en fragmentos');     
            end if;
            if v_count <> 3 then
                raise_application_error(-20040,
                    'Número incorrecto de registros insertados en tabla : '
                    ||v_count);
            end if;
            

        when deleting then
            v_count := 0;
            --replica 1
            select count(*) into v_count2
            from cliente_f1
            where cliente_id =:new.cliente_id
            and auto_id=:new.auto_id;
            if v_count2 > 0 then
                delete from pago_auto_f1 where cliente_id =:old.cliente_id
                    and auto_id=:old.auto_id;;
                v_count := v_count + sql%rowcount;
            else
                raise_application_error(20020, 
                    'Error de integridad para el campo cliente_id : '
                    || :new.cliente_id
                    || ' con el campo auto_id : ' 
                    || :new.auto_id
                    || ' No se encontró el registro padre en fragmentos');     
            end if;
            
            --replica 2
            select count(*) into v_count2
            from cliente_f2
            where cliente_id =:new.cliente_id
            and auto_id=:new.auto_id;
            if v_count2 > 0 then
                delete from pago_auto_f2 where cliente_id =:old.cliente_id
                    and auto_id=:old.auto_id;;
                v_count := v_count + sql%rowcount;
            else
                raise_application_error(20020, 
                    'Error de integridad para el campo cliente_id : '
                    || :new.cliente_id
                    || ' con el campo auto_id : ' 
                    || :new.auto_id
                    || ' No se encontró el registro padre en fragmentos');     
            end if;

            --replica 3
            select count(*) into v_count2
            from cliente_f3
            where cliente_id =:new.cliente_id
            and auto_id=:new.auto_id;
            if v_count2 > 0 then
                delete from pago_auto_f3 where cliente_id =:old.cliente_id
                    and auto_id=:old.auto_id;;
                v_count := v_count + sql%rowcount;
            else
                raise_application_error(20020, 
                    'Error de integridad para el campo cliente_id : '
                    || :new.cliente_id
                    || ' con el campo auto_id : ' 
                    || :new.auto_id
                    || ' No se encontró el registro padre en fragmentos');     
            end if;

            if v_count <> 3 then
                raise_application_error(-20040,
                    'Número incorrecto de registros eliminados en tabla replicada: '
                    ||v_count);
            end if;

        when updating then
            raise_application_error(20030, 
                'Operacion update no soportada en este proyecto');
    end case;
end;
/
show errors