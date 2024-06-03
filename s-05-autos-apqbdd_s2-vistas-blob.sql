--@Autor: Arturo Pérez Quintana, J. Miguel Arroyo Quiroz
--@Fecha creación: 2/06/2024
--@Descripción: Creación de vistas que contienen datos BLOB en apqbdd_s2.

-- Prompt creando vistas que requieren acceso remoto
Prompt Creando vista auto desde S4
--AUTO
create or replace view auto as
    select q1.auto_id, a1.foto,
        q1.anio,q1.num_serie,q1.tipo,q1.precio,q1.fecha_status,q1.sucursal_id,
        q1.status_auto_id,q1.modelo_id
    from auto_f1 a1 
    join
    (
        select auto_id,anio,num_serie,tipo,precio,fecha_status,sucursal_id,
            status_auto_id,modelo_id
        from auto_f2
        union all
        select auto_id,anio,num_serie,tipo,precio,fecha_status,sucursal_id,
            status_auto_id,modelo_id
        from auto_f3
    ) q1
    on a1.auto_id=q1.auto_id;

Prompt Creando vista pago_auto desde S4
--PAGO_AUTO
create or replace view pago_auto as
    select cliente_id,auto_id,fecha_pago,importe,
    get_remote_r_pago_f1_by_id(cliente_id,auto_id) as recibo_pago
    from pago_auto_f1
    union all
    select cliente_id,auto_id,fecha_pago,importe,
    get_remote_r_pago_f2_by_id(cliente_id,auto_id) as recibo_pago
    from pago_auto_f2
    union all
    select cliente_id,auto_id,fecha_pago,importe,recibo_pago
    from pago_auto_f3;
