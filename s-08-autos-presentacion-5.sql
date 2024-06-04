--@Autor: Arturo Pérez Quintana, J. Miguel Arroyo Quiroz
--@Fecha creación: 4/06/2024
--@Descripción: Validando transparencia de operaciones DELETE

clear screen 
set serveroutput on

Prompt Inciando validacion de operación DELETE
accept v_pdb char Prompt '==>Proporcione nombre de PDB que almacenará el prodedimiento: '
accept v_autos_bddpass char Prompt 'Proporcione el password de autos_bdd: ' hide

connect autos_bdd/&&v_autos_bddpass@&&v_pdb

create or replace procedure sp_elimina_datos is
begin
    dbms_output.put_line('Eliminando datos');

    delete from tarjeta_cliente;
    delete from pago_auto;
    delete from cliente;
    delete from auto_particular;
    delete from auto_carga;
    delete from historico_status_auto;
    delete from auto;
    update sucursal_f1 set sucursal_anexa_id =null;
    update sucursal_f2 set sucursal_anexa_id =null;
    update sucursal_f3 set sucursal_anexa_id =null;
    delete from sucursal;
    delete from pais;
    delete from modelo;
    delete from marca;

    dbms_output.put_line('Haciendo commit !');
    commit;
exception
    when others then
    dbms_output.put_line('Errores encontrados al eliminar datos');
    dbms_output.put_line('Hanciendo rollback');
    raise;
    rollback;
end;
/

-- El procedimiento lo ejecuta s-08-autos-presentacion-6.plb

-- Prompt Iniciando validacion en &&v_pdb

-- EXECUTE sp_elimina_datos