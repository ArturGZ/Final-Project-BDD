--@Autor: Arturo Pérez Quintana, J. Miguel Arroyo Quiroz
--@Fecha creación: 2/06/2024
--@Descripción: Creación de trigger para replicacion síncrona 
-- de tabla modelo.

create or replace trigger t_dml_modelo
    instead of insert or update or delete on modelo
declare
    v_count number;
    v_count2 number;
begin
    case
        when inserting then
            v_count := 0;
            insert into modelo_r1(modelo_id,clave,descripcion,activo,marca_id)
            values (:new.modelo_id,:new.clave,:new.descripcion,:new.activo,:new.marca_id);
            v_count := v_count + sql%rowcount;

            --replica 2
            insert into modelo_r2(modelo_id,clave,descripcion,activo,marca_id)
            values (:new.modelo_id,:new.clave,:new.descripcion,:new.activo,:new.marca_id);
            v_count := v_count + sql%rowcount;

            --replica 3
            insert into modelo_r3(modelo_id,clave,descripcion,activo,marca_id)
            values (:new.modelo_id,:new.clave,:new.descripcion,:new.activo,:new.marca_id);
                v_count := v_count + sql%rowcount;

            --replica 4
            insert into modelo_r4(modelo_id,clave,descripcion,activo,marca_id)
            values (:new.modelo_id,:new.clave,:new.descripcion,:new.activo,:new.marca_id);
            v_count := v_count + sql%rowcount;
            if v_count <> 4 then
                raise_application_error(-20040,
                    'Número incorrecto de registros insertados en tabla replicada: '
                    ||v_count);
            end if;

        when deleting then
            v_count := 0;
            --replica local
            delete from modelo_r1 where modelo_id = :old.modelo_id;
            v_count := v_count + sql%rowcount;
            
            --replica 2
            delete from modelo_r2 where modelo_id = :old.modelo_id;
            v_count := v_count + sql%rowcount;

            --replica 3
            delete from modelo_r3 where modelo_id = :old.modelo_id;
            v_count := v_count + sql%rowcount;

            --replica 4
            delete from modelo_r4 where modelo_id = :old.modelo_id;
            v_count := v_count + sql%rowcount;
            if v_count <> 4 then
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