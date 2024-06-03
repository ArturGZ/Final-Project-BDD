--@Autor:           J. Miguel Arroyo Quiroz, Arturo Perez Quintana
--@Fecha:           02/06/2024
--@Descripción:     Definición de Vistas Sin Columnas BLOB

whenever sqlerror exit rollback;

create or replace view pais as
    select pais_id,nombre,clave,region from pais_f1
    union all
    select pais_id,nombre,clave,region from pais_f2;

create or replace view sucursal as
    select sucursal_id,nombre,clave,sucursal_anexa_id,pais_id
    from sucursal_f1
    union all
    select sucursal_id,nombre,clave,sucursal_anexa_id,pais_id
    from sucursal_f2
    union all
    select sucursal_id,nombre,clave,sucursal_anexa_id,pais_id
    from sucursal_f3;

create or replace view auto_particular as
    select auto_id,num_cilindros,num_pasajeros,clase
    from auto_particular_f1
    union all
    select auto_id,num_cilindros,num_pasajeros,clase
    from auto_particular_f2;

create or replace view auto_carga as
    select auto_id,peso_maximo,volumen,tipo_combustible
    from auto_carga_f1
    union all
    select auto_id,peso_maximo,volumen,tipo_combustible
    from auto_carga_f2;

create or replace view historico_status as
    select historico_status_id,fecha_status,status_auto_id,auto_id
    from historico_status_auto_f1
    union all
    select historico_status_id,fecha_status,status_auto_id,auto_id
    from historico_status_auto_f2;

create or replace view cliente as
    select cliente_id,nombre,ap_paterno,ap_materno,num_identificacion,email
    from cliente_f1
    union all
    select cliente_id,nombre,ap_paterno,ap_materno,num_identificacion,email
    from cliente_f2
    union all
    select cliente_id,nombre,ap_paterno,ap_materno,num_identificacion,email
    from cliente_f3;

create or replace view tarjeta_cliente as
    select q1.cliente_id,q1.num_tarjeta,q2.anio_expira,q2.mes_expira,q1.codigo_seguridad,q2.tipo
    from (
        (select cliente_id,num_tarjeta,codigo_seguridad
        from tarjeta_cliente_f1) q1
        join
        (select cliente_id,anio_expira,mes_expira,tipo
        from tarjeta_cliente_f2) q2
        on q1.cliente_id=q2.cliente_id);

create or replace view marca as
    select marca_id,clave,descripcion,activo
    from marca_r1;

create or replace view modelo as
    select modelo_id,clave,descripcion,activo,marca_id
    from modelo_r1;