--@Autor: Arturo Pérez Quintana, J. Miguel Arroyo Quiroz
--@Fecha creación: 3/06/2024
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
            --inserción 1 con validacion de integridad con cliente y auto
            select count(*) into v_count
            from cliente_f1
            where cliente_id =:new.cliente_id;
            select count(*) into v_count2
            from auto_f1
            where auto_id=:new.auto_id;
            if v_count>0 and v_count2>0 then
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

            else
                --insercion 2 con validacion de integridad con cliente y auto
                select count(*) into v_count
                from cliente_f2
                where cliente_id =:new.cliente_id;
                select count(*) into v_count2
                from auto_f1
                where auto_id=:new.auto_id;
                if v_count>0 and v_count2>0 then
                    --inserta el binario, uso de tabla temporal
                    insert into ti_pago_auto_f2(cliente_id,auto_id,
                        fecha_pago,importe,recibo_pago)
                    values (:new.cliente_id,:new.auto_id,:new.fecha_pago,
                        :new.importe,:new.recibo_pago);
                
                    --inserta en el sitio remoto a través de la tabla temporal
                    insert into pago_auto_f2
                        select * from ti_pago_auto_f2
                        where cliente_id =:new.cliente_id
                            and auto_id=:new.auto_id;
                    delete from ti_pago_auto_f2
                        where cliente_id =:new.cliente_id
                            and auto_id=:new.auto_id;
                else
                    --insercion 3 con validacion de integridad con cliente y auto
                    select count(*) into v_count
                    from cliente_f3
                    where cliente_id =:new.cliente_id;
                    select count(*) into v_count2
                    from auto_f1
                    where auto_id=:new.auto_id;
                    if v_count>0 and v_count2>0 then
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
                    else
                        raise_application_error(-20020, 
                            'Error de integridad para el campo cliente_id : '
                            || :new.cliente_id
                            || ' con el campo auto_id : ' 
                            || :new.auto_id
                            || ' No se encontró el registro padre en fragmentos'); 
                    end if;
                end if;
            end if;
            
            

        when deleting then
            --Eliminando en fragmento 1
            select count(*) into v_count
            from cliente_f1
            where cliente_id =:new.cliente_id;
            select count(*) into v_count2
            from auto_f1
            where auto_id=:new.auto_id;
            if v_count>0 and v_count2>0 then
                delete from pago_auto_f1 where cliente_id =:old.cliente_id
                    and auto_id=:old.auto_id;
            else
                --Eliminando en fragmento 2
                select count(*) into v_count
                from cliente_f2
                where cliente_id =:new.cliente_id;
                select count(*) into v_count2
                from auto_f1
                where auto_id=:new.auto_id;
                if v_count>0 and v_count2>0 then
                    delete from pago_auto_f2 where cliente_id =:old.cliente_id
                        and auto_id=:old.auto_id;
                else
                    --Eliminando en fragmento 3
                    select count(*) into v_count
                    from cliente_f3
                    where cliente_id =:new.cliente_id;
                    select count(*) into v_count2
                    from auto_f1
                    where auto_id=:new.auto_id;
                    if v_count>0 and v_count2>0 then
                        delete from pago_auto_f3 where cliente_id =:old.cliente_id
                            and auto_id=:old.auto_id;
                    else 
                        raise_application_error(-20020, 
                            'Error de integridad para el campo cliente_id : '
                            || :new.cliente_id
                            || ' con el campo auto_id : ' 
                            || :new.auto_id
                            || ' No se encontró el registro padre en fragmentos'); 
                    end if;
                end if;
            end if;
            

        when updating then
            raise_application_error(-20030, 
                'Operacion update no soportada en este proyecto');
    end case;
end;
/
show errors