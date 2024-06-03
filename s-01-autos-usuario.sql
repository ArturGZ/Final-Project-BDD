--@Autor:	        J. Miguel Arroyo Quiroz, Arturo Perez Quintana
--@Fecha Creación:	02/06/2024
--@Descripción:     Eliminación y Creación del Usuario Para PF BDD

Prompt Verificando la existencia del usuario autos_bdd
declare
    v_count number;
    v_username varchar2(20) := 'AUTOS_BDD';
begin
    select count(*) into v_count from all_users where username=v_username;
    if v_count >0 then
        execute immediate 'drop user '||v_username||' cascade';
    else
        dbms_output.put_line('El usuario '||v_username||' no existe');
    end if;
end;
/

Prompt Creando el usuario autos_bdd
create user autos_bdd identified by autos_bdd quota unlimited on users;

Prompt Otorgando permisos al usuario autos_bdd
grant create session, create table, create sequence, create procedure, create view, 
    create synonym, create type, create database link, create trigger to autos_bdd;