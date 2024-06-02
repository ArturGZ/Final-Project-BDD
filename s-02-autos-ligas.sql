--@Autor: Arturo Pérez Quintana
--@Fecha creación: 2/06/2024
--@Descripción: Creacion de ligas privadaspara hacia cada PDB.

--APQ_S1

prompt Creando ligas en apqbdd_s1 hacia el resto de PDBs
connect autos_bdd/autos_bdd@apqbdd_s1
create database link apqbdd_s2.fi.unam using 'APQBDD_S2';
create database link maqbdd_s1.fi.unam using 'MAQBDD_S1';
create database link maqbdd_s2.fi.unam using 'MAQBDD_S2';

--APQ_S2

prompt Creando ligas en apqbdd_s2 hacia el resto de PDBs
connect autos_bdd/autos_bdd@apqbdd_s2
create database link apqbdd_s1.fi.unam using 'APQBDD_S1';
create database link maqbdd_s1.fi.unam using 'MAQBDD_S1';
create database link maqbdd_s2.fi.unam using 'MAQBDD_S2';

--MAQ_S1

prompt Creando ligas en maqbdd_s1 hacia el resto de PDBs
connect autos_bdd/autos_bdd@maqbdd_s1
create database link apqbdd_s1.fi.unam using 'APQBDD_S1';
create database link apqbdd_s2.fi.unam using 'APQBDD_S2';
create database link maqbdd_s2.fi.unam using 'MAQBDD_S2';

--MAQ_S2

prompt Creando ligas en maqbdd_s2 hacia el resto de PDBs
connect autos_bdd/autos_bdd@maqbdd_s2
create database link apqbdd_s1.fi.unam using 'APQBDD_S1';
create database link apqbdd_s2.fi.unam using 'APQBDD_S2';
create database link maqbdd_s1.fi.unam using 'MAQBDD_S1';

prompt Listo!