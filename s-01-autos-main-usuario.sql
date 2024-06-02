--@Autor:	        J. Miguel Arroyo Quiroz, Arturo Perez Quintana
--@Fecha Creación:	02/06/2024
--@Descripción:     Creación de Usuario en los 4 Nodos

whenever sqlerror exit rollback;
set serveroutput on

Prompt Inciando creacion/eliminacion de usuarios
accept syspass char prompt 'Proporcione el password de sys: ' hide

Prompt Creando usuario en maqbdd_s1
connect sys/&&syspass@maqbdd_s1 as sysdba
@s-01-autos-usuario.sql

Prompt Creando usuario en maqbdd_s2
connect sys/&&syspass@maqbdd_s2 as sysdba
@s-01-autos-usuario.sql

Prompt Creando usuario en apqbdd_s1
connect sys/&&syspass@apqbdd_s1 as sysdba
@s-01-autos-usuario.sql

Prompt Creando usuario en apqbdd_s2
connect sys/&&syspass@apqbdd_s2 as sysdba
@s-01-autos-usuario.sql

Prompt Listo!!
disconnect