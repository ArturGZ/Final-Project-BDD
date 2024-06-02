--@Autor:           J. Miguel Arroyo Quiroz
--@Fecha:           02/06/2024
--@Descripción:     Código DDL Para El Nodo 1 MAQBDD_S1 PF BDD

whenever sqlerror exit rollback;

Prompt Inciando Creacion de Fragmentos en Cada PDB
accept autos_bddpass char prompt 'Proporcione el password de autos_bdd: ' hide

Prompt Creando fragmentos para maqbdd_s1
connect autos_bdd/&&autos_bddpass@maqbdd_s1
@s-03-autos-maqbdd_s1-ddl.sql

Prompt Creando fragmentos para maqbdd_s2
connect autos_bdd/&&autos_bddpass@maqbdd_s2
@s-03-autos-maqbdd_s2-ddl.sql

Prompt Creando fragmentos para apqbdd_s1
connect autos_bdd/&&autos_bddpass@apqbdd_s1
@s-03-autos-apqbdd_s1-ddl.sql

Prompt Creando fragmentos para apqbdd_s2
connect autos_bdd/&&autos_bddpass@apqbdd_s2
@s-03-autos-apqbdd_s2-ddl.sql

Prompt Listo!!
disconnect