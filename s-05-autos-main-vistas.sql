--@Autor:           J. Miguel Arroyo Quiroz, Arturo Perez Quintana
--@Fecha:           02/06/2024
--@Descripción:     Creación de Vistas para cada PDB

clear screen 
whenever sqlerror exit rollback;

Prompt Inciando creacion de sinonimos
accept autos_bddpass char Prompt 'Proporcione el password de autos_bdd: ' hide

Prompt =========================================
Prompt Creando sinonimos para Sitio 1 maqbdd_s1
Prompt =========================================
connect autos_bdd/&&autos_bddpass@maqbdd_s1
prompt Creando vistas que no requieren manejo de BLOBs
@s-05-autos-vistas.sql

prompt Creando tablas temporales
@s-05-autos-tablas-temporales.sql

prompt Creando objetos para manejo de BLOBs
@s-05-autos-funciones-blob.sql

prompt Creando vistas con soporte para BLOBs
@s-05-autos-maqbdd_s1-vistas-blob.sql

Prompt =========================================
Prompt Creando sinonimos para Sitio 2 maqbdd_s2
Prompt =========================================
connect autos_bdd/&&autos_bddpass@maqbdd_s2
prompt Creando vistas que no requieren manejo de BLOBs
@s-05-autos-vistas.sql

prompt Creando tablas temporales
@s-05-autos-tablas-temporales.sql

prompt Creando objetos para manejo de BLOBs
@s-05-autos-funciones-blob.sql

prompt Creando vistas con soporte para BLOBs
@s-05-autos-maqbdd_s2-vistas-blob.sql

Prompt =========================================
Prompt Creando sinonimos para Sitio 3 apqbdd_s1
Prompt =========================================
connect autos_bdd/&&autos_bddpass@apqbdd_s1
prompt Creando vistas que no requieren manejo de BLOBs
@s-05-autos-vistas.sql

prompt Creando tablas temporales
@s-05-autos-tablas-temporales.sql

prompt Creando objetos para manejo de BLOBs
@s-05-autos-funciones-blob.sql

prompt Creando vistas con soporte para BLOBs
@s-05-autos-apqbdd_s1-vistas-blob.sql

Prompt =========================================
Prompt Creando sinonimos para Sitio 4 apqbdd_s2
Prompt =========================================
connect autos_bdd/&&autos_bddpass@apqbdd_s2
prompt Creando vistas que no requieren manejo de BLOBs
@s-05-autos-vistas.sql

prompt Creando tablas temporales
@s-05-autos-tablas-temporales.sql

prompt Creando objetos para manejo de BLOBs
@s-05-autos-funciones-blob.sql

prompt Creando vistas con soporte para BLOBs
@s-05-autos-apqbdd_s2-vistas-blob.sql

Prompt Listo!!
disconnect