--@Autor: Arturo Pérez Quintana, J. Miguel Arroyo Quiroz
--@Fecha creación: 30/04/2024
--@Descripción: Creación de funciones para manejo datos BLOB empleando estrategia 2.


Prompt Creando funcion para auto_f1
create or replace function get_remote_foto_f1_by_id(p_auto_id in number)
    return blob is
    pragma autonomous_transaction;
    v_temp_foto blob;
begin
    --asegura que no haya registros en la tabla temporal
    delete from ts_auto_f1;
    --inserta los datos obtenidos del fragmento remoto a la tabla temporal.
    insert into ts_auto_f1(auto_id,foto) select auto_id,foto
        from auto_f1 where auto_id = p_auto_id;
    --obtiene el registro de la tabla temporal y lo regresa como blob
    select foto into v_temp_foto
    from ts_auto_f1
    where auto_id = p_auto_id;
    --elimina los registros de la tabla temporal una vez que han sido obtenidos.
    delete from ts_auto_f1;
    commit;
    return v_temp_foto;
exception
    when others then
        rollback;
        raise;
end;
/
show errors


Prompt Creando funciones estrategia 2 para pago_auto_f1
create or replace function get_remote_r_pago_f1_by_id(
    p_cliente_id in number, p_auto_id in number) return blob is
    pragma autonomous_transaction;
    v_temp_pdf blob;
begin
    --asegura que no haya registros en la tabla temporal
    delete from ts_pago_auto_f1;
    --inserta los datos obtenidos del fragmento remoto a la tabla temporal.
    insert into ts_pago_auto_f1(cliente_id,auto_id,recibo_pago) select cliente_id,auto_id,recibo_pago
        from pago_auto_f1 where auto_id = p_auto_id and cliente_id = p_cliente_id;
    --obtiene el registro de la tabla temporal y lo regresa como blob
    select recibo_pago into v_temp_pdf
    from ts_pago_auto_f1
    where cliente_id = p_cliente_id and auto_id=p_auto_id;
    --elimina los registros de la tabla temporal una vez que han sido obtenidos.
    delete from ts_pago_auto_f1;
    commit;
    return v_temp_pdf;
exception
    when others then
        rollback;
        raise;
end;
/
show errors


Prompt Creando funciones estrategia 2 para pago_auto_f2
create or replace function get_remote_r_pago_f2_by_id(
p_cliente_id in number, p_auto_id in number) return blob is
    pragma autonomous_transaction;
    v_temp_pdf blob;
begin
    --asegura que no haya registros en la tabla temporal
    delete from ts_pago_auto_f2;
    --inserta los datos obtenidos del fragmento remoto a la tabla temporal.
    insert into ts_pago_auto_f2(cliente_id,auto_id,recibo_pago) select cliente_id,auto_id,recibo_pago
        from pago_auto_f2 where auto_id = p_auto_id and cliente_id = p_cliente_id;
    --obtiene el registro de la tabla temporal y lo regresa como blob
    select recibo_pago into v_temp_pdf
    from ts_pago_auto_f2
    where cliente_id = p_cliente_id and auto_id=p_auto_id;
    --elimina los registros de la tabla temporal una vez que han sido obtenidos.
    delete from ts_pago_auto_f2;
    commit;
    return v_temp_pdf;
commit;
return v_temp_pdf;
exception
    when others then
        rollback;
        raise;
end;
/
show errors


Prompt Creando funciones estrategia 2 para pago_auto_f3
create or replace function get_remote_r_pago_f3_by_id(
p_cliente_id in number, p_auto_id in number) return blob is
    pragma autonomous_transaction;
    v_temp_pdf blob;
begin
    --asegura que no haya registros en la tabla temporal
    delete from ts_pago_auto_f3;
    --inserta los datos obtenidos del fragmento remoto a la tabla temporal.
    insert into ts_pago_auto_f3(cliente_id,auto_id,recibo_pago) select cliente_id,auto_id,recibo_pago
        from pago_auto_f3 where auto_id = p_auto_id and cliente_id = p_cliente_id;
    --obtiene el registro de la tabla temporal y lo regresa como blob
    select recibo_pago into v_temp_pdf
    from ts_pago_auto_f3
    where cliente_id = p_cliente_id and auto_id=p_auto_id;
    --elimina los registros de la tabla temporal una vez que han sido obtenidos.
    delete from ts_pago_auto_f3;
    commit;
    return v_temp_pdf;
commit;
return v_temp_pdf;
exception
    when others then
        rollback;
        raise;
end;
/
show errors