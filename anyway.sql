
-- columnas de una tabla
SELECT '''' + COLUMN_NAME + '''' + ',' AS COLUMN_NAME
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'producto';

/*
Nuevo Producto
> products

codigo
nombre
Familia
imagen ~

tipo_producto 
    => Si es un bien 
        unidad_medida ~
        stock_minimo ~
        stock_maximo ~
        fecha_vencimiento ~
        alerta_stock ~
        alerta_vencimiento ~
    => Si es un servicio
        precio
id_empresa => inertia
----------------------
estado => 1



costo_unitario => 0
*/

