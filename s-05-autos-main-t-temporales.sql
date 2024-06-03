--@Autor: Arturo Pérez Quintana, J. Miguel Arroyo Quiroz
--@Fecha creación: 30/04/2024
--@Descripción: Creación de tablas temporales en cada nodo para funciones que manejan datos BLOB.

clear screen
whenever sqlerror exit rollback;

Prompt Inciando creacion de tablas temporales y funciones para BLOB
accept autos_bddpass char Prompt 'Proporcione el password de autos_bdd: ' hide

Prompt =========================================
Prompt Creando tablas temporales para Sitio 1 maqbdd_s1
Prompt =========================================
connect autos_bdd/&&autos_bddpass@maqbdd_s1
@s-05-autos-tablas-temporales.sql
@s-05-autos-funciones-blob.sql

Prompt =========================================
Prompt Creando tablas temporales para Sitio 2 maqbdd_s2
Prompt =========================================
connect autos_bdd/&&autos_bddpass@maqbdd_s2
@s-05-autos-tablas-temporales.sql
@s-05-autos-funciones-blob.sql

Prompt =========================================
Prompt Creando tablas temporales para Sitio 3 apqbdd_s1
Prompt =========================================
connect autos_bdd/&&autos_bddpass@apqbdd_s1
@s-05-autos-tablas-temporales.sql
@s-05-autos-funciones-blob.sql

Prompt =========================================
Prompt Creando tablas temporales para Sitio 4 apqbdd_s2
Prompt =========================================
connect autos_bdd/&&autos_bddpass@apqbdd_s2
@s-05-autos-tablas-temporales.sql
@s-05-autos-funciones-blob.sql

Prompt Listo!
disconnect