--@Autor: Arturo Pérez Quintana, J. Miguel Arroyo Quiroz
--@Fecha creación: 3/06/2024
--@Descripción: Script principal empleado para configurar el soporte
--              de datos BLOB en los 4 nodos.

clear screen 
whenever sqlerror exit rollback;

Prompt Inciando soporte para BLOBs
accept autos_bddpass char Prompt 'Proporcione el password de autos_bdd: ' hide

Prompt ================================================
Prompt Configurando soporte BLOB para Sitio 1 maqbdd_s1
Prompt ================================================
connect autos_bdd/&&autos_bddpass@maqbdd_s1
@s-07-autos-configuracion-soporte-blobs.sql

Prompt ================================================
Prompt Configurando soporte BLOB para Sitio 2 maqbdd_s2
Prompt ================================================
connect autos_bdd/&&autos_bddpass@maqbdd_s2
@s-07-autos-configuracion-soporte-blobs.sql

Prompt ================================================
Prompt Configurando soporte BLOB para Sitio 3 apqbdd_s1
Prompt ================================================
connect autos_bdd/&&autos_bddpass@apqbdd_s1
@s-07-autos-configuracion-soporte-blobs.sql

Prompt ================================================
Prompt Configurando soporte BLOB para Sitio 4 apqbdd_s2
Prompt ================================================
connect autos_bdd/&&autos_bddpass@apqbdd_s2
@s-07-autos-configuracion-soporte-blobs.sql

Prompt Listo!!
disconnect