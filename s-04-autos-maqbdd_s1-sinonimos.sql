--@Autor: Arturo Pérez Quintana, J. Miguel Arroyo Quiroz
--@Fecha creación: 30/04/2024
--@Descripción: Creacion de sinonimos privados.


prompt Creando sinonimos para fragmentos de Sitio 1 maqbdd_s1 local

create or replace synonym pais_f1 for PAIS_F1_MAQ_S1;
create or replace synonym sucursal_f2 for SUCURSAL_F2_MAQ_S1;
create or replace synonym marca_r1 for MARCA_R_MAQ_S1;
create or replace synonym modelo_r1 for MODELO_R_MAQ_S1;
create or replace synonym auto_f2 for AUTO_F2_MAQ_S1;
create or replace synonym auto_carga_f1 for AUTO_CARGA_F1_MAQ_S1;
create or replace synonym auto_particular_f1 for AUTO_PARTICULAR_F1_MAQ_S1;


prompt Creando sinonimos de S1 para fragmentos de Sitio 2 maqbdd_s2 remoto

create or replace synonym pais_f2 for PAIS_F2_MAQ_S2@maqbdd_s2;
create or replace synonym sucursal_f3 for SUCURSAL_F3_MAQ_S2@maqbdd_s2;
create or replace synonym marca_r4 for MARCA_R_MAQ_S2@maqbdd_s2;
create or replace synonym modelo_r4 for MODELO_R_MAQ_S2@maqbdd_s2;
create or replace synonym auto_f3 for AUTO_F3_MAQ_S2@maqbdd_s2;
create or replace synonym auto_carga_f2 for AUTO_CARGA_F2_MAQ_S2@maqbdd_s2;
create or replace synonym auto_particular_f2 for AUTO_PARTICULAR_F2_MAQ_S2@maqbdd_s2;
create or replace synonym cliente_f1 for CLIENTE_F1_MAQ_S2@maqbdd_s2;
create or replace synonym pago_auto_f1 for PAGO_AUTO_F1_MAQ_S2@maqbdd_s2;
create or replace synonym tarjeta_cliente_f2 for TARJETA_CLIENTE_F2_MAQ_S2@maqbdd_s2;


prompt Creando sinonimos de S1 para fragmentos de Sitio 3 apqbdd_s1 remoto

create or replace synonym cliente_f2 for CLIENTE_F2_APQ_S1@apqbdd_s1;
create or replace synonym historico_status_auto_f2 for HISTORICO_STATUS_AUTO_F2_APQ_S1@apqbdd_s1;
create or replace synonym marca_r3 for MARCA_R_APQ_S1@apqbdd_s1;
create or replace synonym modelo_r3 for MODELO_R_APQ_S1@apqbdd_s1;
create or replace synonym pago_auto_f2 for PAGO_AUTO_F2_APQ_S1@apqbdd_s1;
create or replace synonym sucursal_f1 for SUCURSAL_F1_APQ_S1@apqbdd_s1;
create or replace synonym tarjeta_cliente_f1 for TARJETA_CLIENTE_F1_APQ_S1@apqbdd_s1;


prompt Creando sinonimos de S1 para fragmentos de Sitio 4 apqbdd_s2 remoto

create or replace synonym auto_f1 for AUTO_F1_APQ_S2@apqbdd_s2;
create or replace synonym cliente_f3 for CLIENTE_F3_APQ_S2@apqbdd_s2;
create or replace synonym historico_status_auto_f1 for HISTORICO_STATUS_AUTO_F1_APQ_S2@apqbdd_s2;
create or replace synonym marca_r2 for MARCA_R_APQ_S2@apqbdd_s2;
create or replace synonym modelo_r2 for MODELO_R_APQ_S2@apqbdd_s2;
create or replace synonym pago_auto_f3 for PAGO_AUTO_F3_APQ_S2@apqbdd_s2;



prompt >>> Listo S1!