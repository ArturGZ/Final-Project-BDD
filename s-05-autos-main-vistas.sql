--@Autor:           J. Miguel Arroyo Quiroz, Arturo Perez Quintana
--@Fecha:           02/06/2024
--@Descripción:     Creación de Vistas Sin Columnas BLOB en cada PDB

whenever sqlerror exit rollback;

Prompt Inciando creacion de sinonimos
accept autos_bddpass char Prompt 'Proporcione el password de autos_bdd: ' hide

Prompt =========================================
Prompt Creando sinonimos para Sitio 1 maqbdd_s1
Prompt =========================================
connect autos_bdd/&&autos_bddpass@maqbdd_s1
@s-05-autos-vistas.sql

Prompt =========================================
Prompt Creando sinonimos para Sitio 2 maqbdd_s2
Prompt =========================================
connect autos_bdd/&&autos_bddpass@maqbdd_s2
@s-05-autos-vistas.sql

Prompt =========================================
Prompt Creando sinonimos para Sitio 3 apqbdd_s1
Prompt =========================================
connect autos_bdd/&&autos_bddpass@apqbdd_s1
@s-05-autos-vistas.sql

Prompt =========================================
Prompt Creando sinonimos para Sitio 4 apqbdd_s2
Prompt =========================================
connect autos_bdd/&&autos_bddpass@apqbdd_s2
@s-05-autos-vistas.sql

Prompt Listo!!
disconnect