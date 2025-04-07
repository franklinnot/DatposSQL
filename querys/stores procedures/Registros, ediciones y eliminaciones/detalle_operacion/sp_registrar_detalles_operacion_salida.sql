-- Asegúrate de que el tipo de datos esté creado en el sistema
-- CREATE TYPE ud_detalles_operacion AS TABLE (
--     id_producto BIGINT,
--     costo_unitario FLOAT NULL,
--     cantidad FLOAT
--  );

CREATE OR ALTER PROCEDURE sp_registrar_detalles_operacion_salida
    @id_operacion BIGINT,
    @id_empresa BIGINT,
    @id_almacen_origen BIGINT,
    @detalles ud_detalles_operacion READONLY
AS
BEGIN
    SET NOCOUNT ON;

    -- Verificar que todos los productos existan en el almacén origen, 
    -- tengan estado válido (!=0) y stock suficiente
    DECLARE @productos_invalidos TABLE (
        id_producto BIGINT,
        mensaje NVARCHAR(255)
    );

    -- Insertar productos que no existen en el almacén o tienen estado inválido
    INSERT INTO @productos_invalidos
        (id_producto, mensaje)
    SELECT d.id_producto,
        CASE 
            WHEN p.id_producto IS NULL THEN 'Producto no existe'
            WHEN p.estado = 0 THEN 'Producto inhabilitado'
            WHEN pa.id_producto IS NULL THEN 'Producto no existe en el almacén origen'
            WHEN pa.stock < d.cantidad THEN 'Stock insuficiente'
            ELSE NULL
        END
    FROM @detalles d
        LEFT JOIN producto p ON p.id_producto = d.id_producto AND p.id_empresa = @id_empresa
        LEFT JOIN producto_almacen pa ON pa.id_producto = d.id_producto
            AND pa.id_almacen = @id_almacen_origen
            AND pa.id_empresa = @id_empresa
    WHERE p.id_producto IS NULL
        OR p.estado = 0
        OR pa.id_producto IS NULL
        OR pa.stock < d.cantidad;

    -- Si hay productos inválidos, lanzar error
    IF EXISTS (SELECT 1
    FROM @productos_invalidos)
    BEGIN
        DECLARE @error_message NVARCHAR(MAX) = 'No se puede realizar la operación debido a los siguientes problemas: ';

        SELECT @error_message = @error_message + CHAR(13) + 
               'Producto ID: ' + CAST(id_producto AS NVARCHAR) + ' - ' + mensaje
        FROM @productos_invalidos;

        RAISERROR(@error_message, 16, 1);
        RETURN;
    END;

    -- Insertar en detalle_operacion 
    INSERT INTO detalle_operacion
        (costo_unitario, cantidad, id_producto, id_operacion, id_empresa)
    SELECT d.costo_unitario, d.cantidad, d.id_producto, @id_operacion, @id_empresa
    FROM @detalles d;

    -- Actualizar producto_almacen reduciendo el stock
    UPDATE pa
    SET pa.stock = pa.stock - d.cantidad
    FROM producto_almacen pa
        INNER JOIN @detalles d ON pa.id_producto = d.id_producto
    WHERE pa.id_almacen = @id_almacen_origen
        AND pa.id_empresa = @id_empresa;
END;