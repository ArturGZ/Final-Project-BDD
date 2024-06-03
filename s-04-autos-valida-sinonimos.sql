--@Autor: Arturo Pérez Quintana, J. Miguel Arroyo Quiroz
--@Fecha creación: 30/04/2024
--@Descripción: Validación de sinonimos.

Prompt == Validando sinonimos para PAIS
select
(select count(*) from pais_1) as pais_1,
(select count(*) from pais_2) as pais_2
from dual;

Prompt == Validando sinonimos para SUCURSAL
select
(select count(*) from sucursal_1) as sucursal_1,
(select count(*) from sucursal_2) as sucursal_2,
(select count(*) from sucursal_3) as sucursal_3
from dual;

Prompt == Validando sinonimos para AUTO
select
(select count(*) from auto_1) as auto_1,
(select count(*) from auto_2) as auto_2,
(select count(*) from auto_3) as auto_3
from dual;

Prompt == Validando sinonimos para CLIENTE
select
(select count(*) from cliente_1) as cliente_1,
(select count(*) from cliente_2) as cliente_2,
(select count(*) from cliente_3) as cliente_3
from dual;

Prompt == Validando sinonimos para PAGO_AUTO
select
(select count(*) from pago_auto_1) as pago_auto_1,
(select count(*) from pago_auto_2) as pago_auto_2,
(select count(*) from pago_auto_3) as pago_auto_3
from dual;

Prompt == Validando sinonimos para AUTO_CARGA
select
(select count(*) from auto_carga_1) as auto_carga_1,
(select count(*) from auto_carga_2) as auto_carga_2
from dual;

Prompt == Validando sinonimos para AUTO_PARTICULAR
select
(select count(*) from auto_particular_1) as auto_particular_1,
(select count(*) from auto_particular_2) as auto_particular_2
from dual;

Prompt == Validando sinonimos para TARJETA_CLIENTE
select
(select count(*) from tarjeta_cliente_1) as tarjeta_cliente_1,
(select count(*) from tarjeta_cliente_2) as tarjeta_cliente_2
from dual;

Prompt == Validando sinonimos para HISTORICO_STATUS_AUTO
select
(select count(*) from historico_status_auto_1) as historico_status_auto_1,
(select count(*) from historico_status_auto_2) as historico_status_auto_2
from dual;

Prompt == Validando sinonimos para MODELO
select
(select count(*) from modelo_r1) as modelo_1,
(select count(*) from modelo_r2) as modelo_2,
(select count(*) from modelo_r3) as modelo_3,
(select count(*) from modelo_r4) as modelo_4
from dual;

Prompt == Validando sinonimos para MARCA
select
(select count(*) from marca_r1) as marca_r1,
(select count(*) from marca_r2) as marca_r2,
(select count(*) from marca_r3) as marca_r3,
(select count(*) from marca_r4) as marca_r4
from dual;