--@Autor: Arturo Pérez Quintana, J. Miguel Arroyo Quiroz
--@Fecha creación: 30/04/2024
--@Descripción: Creación de tablas temporales para funciones que manejan datos BLOB.

Prompt Eliminando tablas temporales en caso de existir
declare
    cursor cur_tablas is
        select table_name
        from user_tables
        where table_name in ('TI_AUTO_F1','TS_AUTO_F1')
        or table_name in ('TI_PAGO_AUTO_F1','TI_PAGO_AUTO_F2','TS_PAGO_AUTO_F1',
            'TS_PAGO_AUTO_F2');
begin
    for r in cur_tablas loop
        execute immediate 'drop table ' || r.table_name;
    end loop;
end;
/


Prompt Tablas temporales para la tabla AUTO
--Para operaciones INSERT
create global temporary table ti_auto_f1(
    auto_id number(10,0) constraint ti_auto_f1_pk primary key,
    foto blob not null
) on commit preserve rows;

--Para operaciones SELECT
create global temporary table ts_auto_f1(
    auto_id number(10,0) constraint ts_auto_f1_pk primary key,
    foto blob not null
) on commit preserve rows;



Prompt tablas temporales para la tabla PAGO_AUTO_1
--Para operaciones INSERT
create global temporary table ti_pago_auto_f1(
    cliente_id number(10,0),
    auto_id number(10,0),
    fecha_pago date not null,
    importe number(8,2) not null,
    recibo_pago blob not null,
    constraint ti_pago_auto_f1_pk primary key (cliente_id,auto_id)
) on commit preserve rows;

--Para operaciones SELECT
create global temporary table ts_pago_auto_f1(
    cliente_id number(10,0),
    auto_id number(10,0),
    recibo_pago blob not null,
    constraint ts_pago_auto_f1_pk primary key (cliente_id,auto_id)
) on commit preserve rows;


Prompt tablas temporales para la tabla PAGO_AUTO_2
--Para operaciones INSERT
create global temporary table ti_pago_auto_f2(
    cliente_id number(10,0),
    auto_id number(10,0),
    fecha_pago date not null,
    importe number(8,2) not null,
    recibo_pago blob not null,
    constraint ti_pago_auto_f2_pk primary key (cliente_id,auto_id)
) on commit preserve rows;

--Para operaciones SELECT
create global temporary table ts_pago_auto_f2(
    cliente_id number(10,0),
    auto_id number(10,0),
    recibo_pago blob not null,
    constraint ts_pago_auto_f2_pk primary key (cliente_id,auto_id)
) on commit preserve rows;