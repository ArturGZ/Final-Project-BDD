--@Autor: Arturo Pérez Quintana, J. Miguel Arroyo Quiroz
--@Fecha creación: 30/04/2024
--@Descripción: Creacion de sinonimos privados en su sitio correspondiente.

Prompt Inciando creacion de sinonimos
accept autos_bddpass char prompt 'Proporcione el password de autos_bdd: ' hide

clear screen
whenever sqlerror exit rollback;

prompt =========================================
prompt Creando sinonimos para Sitio 1 maqbdd_s1
prompt =========================================
connect autos_bdd/&&autos_bddpass@maqbdd_s1
@s-04-autos-maqbdd_s1-sinonimos.sql
@s-04-autos-valida-sinonimos.sql

prompt =========================================
prompt Creando sinonimos para Sitio 2 maqbdd_s2
prompt =========================================
connect autos_bdd/&&autos_bddpass@maqbdd_s2
@s-04-autos-maqbdd_s2-sinonimos.sql
@s-04-autos-valida-sinonimos.sql

prompt =========================================
prompt Creando sinonimos para Sitio 3 apqbdd_s1
prompt =========================================
connect autos_bdd/&&autos_bddpass@apqbdd_s1
@s-04-autos-apqbdd_s1-sinonimos.sql
@s-04-autos-valida-sinonimos.sql

prompt =========================================
prompt Creando sinonimos para Sitio 4 apqbdd_s2
prompt =========================================
connect autos_bdd/&&autos_bddpass@apqbdd_s2
@s-04-autos-apqbdd_s2-sinonimos.sql
@s-04-autos-valida-sinonimos.sql

prompt Listo!
disconnect