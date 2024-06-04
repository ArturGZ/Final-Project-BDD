--@Autor: Arturo Pérez Quintana, J. Miguel Arroyo Quiroz
--@Fecha creación: 3/06/2024
--@Descripción: Archivo de carga inicial para poblado manual de datos


clear screen 
whenever sqlerror exit rollback;

Prompt Inciando creacion de Vistas
accept autos_bddpass char Prompt 'Proporcione el password de autos_bdd: ' hide

Prompt ==========================================
Prompt Cargando catalogos replicados en maqbdd_s1
Prompt ==========================================
connect autos_bdd/&&autos_bddpass@maqbdd_s1
delete from status_auto;
@carga-inicial/status_auto.sql

Prompt ==========================================
Prompt Cargando catalogos replicados en maqbdd_s2
Prompt ==========================================
connect autos_bdd/&&autos_bddpass@maqbdd_s2
delete from status_auto;
@carga-inicial/status_auto.sql

Prompt ==========================================
Prompt Cargando catalogos replicados en apqbdd_s1
Prompt ==========================================
connect autos_bdd/&&autos_bddpass@apqbdd_s1
delete from status_auto;
@carga-inicial/status_auto.sql

Prompt ==========================================
Prompt Cargando catalogos replicados en apqbdd_s2
Prompt ==========================================
connect autos_bdd/&&autos_bddpass@apqbdd_s2
delete from status_auto;
@carga-inicial/status_auto.sql


Prompt Haciendo Commit de todos los datos !
commit;

Prompt Listo!

exit