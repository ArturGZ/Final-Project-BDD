--@Autor: Arturo Pérez Quintana, J. Miguel Arroyo Quiroz
--@Fecha creación: 2/06/2024
--@Descripción: Creación de trigger para replicacion síncrona 
-- de tabla tarjeta_cliente.

create or replace trigger t_dml_tarjeta_cliente
    instead of insert or update or delete on tarjeta_cliente
declare
    v_count number;
begin
    case
        when inserting then
            v_count := 0;
            --replica 1
            insert into tarjeta_cliente_f1(cliente_id,num_tarjeta,codigo_seguridad)
            values (:new.cliente_id,:new.num_tarjeta,:new.codigo_seguridad);
            v_count := v_count + sql%rowcount;
            --replica 2
            insert into tarjeta_cliente_f2(cliente_id,anio_expira,mes_expira,tipo)
            values (:new.cliente_id,:new.anio_expira,:new.mes_expira,:new.tipo);
            v_count := v_count + sql%rowcount;
            if v_count <> 2 then
                raise_application_error(-20040,
                    'Número incorrecto de registros insertados en tabla replicada: '
                    ||v_count);
            end if;

        when deleting then
            v_count := 0;
            --replica 1
            delete from tarjeta_cliente_f1 where cliente_id = :old.cliente_id;
            v_count := v_count + sql%rowcount;
            --replica 2
            delete from tarjeta_cliente_f2 where cliente_id = :old.cliente_id;
            v_count := v_count + sql%rowcount;
            if v_count <> 2 then
                raise_application_error(-20040,
                    'Número incorrecto de registros eliminados en tabla replicada: '
                    ||v_count);
        end if;

        when updating then
            raise_application_error(-20030, 
                'Operacion update no soportada en este proyecto');
    end case;
end;
/
show errors