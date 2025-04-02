

select * from tipo_operacion
select * from operacion;

-- columnas de una tabla
SELECT '''' + COLUMN_NAME + '''' AS COLUMN_NAME
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'operacion';

SELECT '''' + COLUMN_NAME + '''' AS COLUMN_NAME
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'detalle_operacion';

/*
Nueva Operación
ruta: operation/new

Parametros:

'id_tipo_operacion'

'serie' : el valor del campo serie del 'tipo de operación' seleccionado
Ejemplo:
{
    "id_tipo_operacion": 1,
    "serie": "OPV"
}

'numero': valor calculado a partir de cuantas operaciones hay de ese tipo de operación
Ejemplo:
Si el tipo de operación es 'OPV' y hay 10 operaciones de ese tipo, el valor del campo numero será 11. Agrupar
por id_empresa tambien y verificar que ese valor calculado no lo tenga otra operación.

'codigo' : Es la agrupacion de los campos 'serie' y 'numero'
Ejemplo:
Si el tipo de operación es 'OPV' y el numero es 11, el valor del campo codigo será 'OPV-11'.

'fecha_registro'
'fecha_actualizacion'
'estado' : 1 por defecto
'id_usuario'
'id_almacen_origen'
'id_almacen_destino'
'id_asociado': puede ser null
'id_empresa'

Detalle de la operación - Solo sugerirle aquellos productos cuyo estado 
sea diferente de 0 y cuya familia sea de tipo 'Bien':

'costo_unitario'
'cantidad'

tipo operacion
almacen origen
almacen destino
asociado
----
detalle:
cantidad y costo unitario

*/

select * from operacion;

