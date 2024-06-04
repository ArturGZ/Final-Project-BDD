--@Autor:	        Arturo Perez Quintana
--@Fecha Creación:	03/06/2024
--@Descripción:     Ejecucion conjunta de scripts ya funcionales (Main de main's)

clear screen
whenever sqlerror exit rollback;

@s-01-autos-main-usuario.sql

@s-02-autos-ligas.sql

@s-03-autos-main-ddl.sql

@s-04-autos-main-sinonimos.sql

@s-05-autos-main-vistas.sql

@s-06-autos-main-triggers.sql

@s-07-autos-main-soporte-blobs.sql

Prompt Listo al fin!

exit