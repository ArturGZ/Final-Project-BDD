--@Autor: Arturo Pérez Quintana, J. Miguel Arroyo Quiroz
--@Fecha creación: 3/06/2024
--@Descripción: Script principal - creación de triggers

clear screen
whenever sqlerror exit rollback;

Prompt Inciando creacion de sinonimos
accept autos_bddpass char Prompt 'Proporcione el password de autos_bdd: ' hide

prompt =====================================
prompt Creando triggers para maqbdd_s1
prompt =====================================
connect autos_bdd/&&autos_bddpass@maqbdd_s1
@s-06-autos-trigger-pais.sql -- comun
@s-06-autos-maqbdd_s1-sucursal-trigger.sql
@s-06-autos-maqbdd_s1-auto-trigger.sql
@s-06-autos-maqbdd_s1-auto-particular-trigger.sql
@s-06-autos-maqbdd_s1-auto-carga-trigger.sql
@s-06-autos-trigger-historico-status-auto.sql -- comun
@s-06-autos-trigger-cliente.sql -- comun
@s-06-autos-trigger-tarjeta-cliente.sql -- comun
@s-06-autos-maqbdd_s1-pago-auto-trigger.sql
--tablas replicadas
@s-06-autos-trigger-modelo.sql -- comun
@s-06-autos-trigger-marca.sql -- comun

prompt =====================================
prompt Creando triggers para maqbdd_s2
prompt =====================================
connect autos_bdd/&&autos_bddpass@maqbdd_s2
@s-06-autos-trigger-pais.sql -- comun
@s-06-autos-maqbdd_s2-sucursal-trigger.sql
@s-06-autos-maqbdd_s2-auto-trigger.sql
@s-06-autos-maqbdd_s2-auto-particular-trigger.sql
@s-06-autos-maqbdd_s2-auto-carga-trigger.sql
@s-06-autos-trigger-historico-status-auto.sql -- comun
@s-06-autos-trigger-cliente.sql -- comun
@s-06-autos-trigger-tarjeta-cliente.sql -- comun
@s-06-autos-maqbdd_s2-pago-auto-trigger.sql
--tablas replicadas
@s-06-autos-trigger-modelo.sql -- comun
@s-06-autos-trigger-marca.sql -- comun

prompt =====================================
prompt Creando triggers para apqbdd_s1
prompt =====================================
connect autos_bdd/&&autos_bddpass@apqbdd_s1
@s-06-autos-trigger-pais.sql -- comun
@s-06-autos-apqbdd_s1-sucursal-trigger.sql
@s-06-autos-apqbdd_s1-auto-trigger.sql
@s-06-autos-apqbdd_s1-auto-particular-trigger.sql
@s-06-autos-apqbdd_s1-auto-carga-trigger.sql
@s-06-autos-trigger-historico-status-auto.sql -- comun
@s-06-autos-trigger-cliente.sql -- comun
@s-06-autos-trigger-tarjeta-cliente.sql -- comun
@s-06-autos-apqbdd_s1-pago-auto-trigger.sql
--tablas replicadas
@s-06-autos-trigger-modelo.sql -- comun
@s-06-autos-trigger-marca.sql -- comun

prompt =====================================
prompt Creando triggers para apqbdd_s2
prompt =====================================
connect autos_bdd/&&autos_bddpass@apqbdd_s2
@s-06-autos-trigger-pais.sql -- comun
@s-06-autos-apqbdd_s2-sucursal-trigger.sql
@s-06-autos-apqbdd_s2-auto-trigger.sql
@s-06-autos-apqbdd_s2-auto-particular-trigger.sql
@s-06-autos-apqbdd_s2-auto-carga-trigger.sql
@s-06-autos-trigger-historico-status-auto.sql -- comun
@s-06-autos-trigger-cliente.sql -- comun
@s-06-autos-trigger-tarjeta-cliente.sql -- comun
@s-06-autos-apqbdd_s2-pago-auto-trigger.sql
--tablas replicadas
@s-06-autos-trigger-modelo.sql -- comun
@s-06-autos-trigger-marca.sql -- comun

prompt Listo!