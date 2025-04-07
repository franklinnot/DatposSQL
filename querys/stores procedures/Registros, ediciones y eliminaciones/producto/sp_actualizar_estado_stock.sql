CREATE OR ALTER PROCEDURE sp_actualizar_estado_stock
    @id_producto BIGINT,
    @id_empresa BIGINT
AS
BEGIN
    SET NOCOUNT ON;

    -- Variables for product information
    DECLARE @es_bien BIT;
    DECLARE @stock_total FLOAT;
    DECLARE @stock_minimo FLOAT;
    DECLARE @stock_maximo FLOAT;
    DECLARE @estado_actual TINYINT;
    DECLARE @estado_stock_nuevo TINYINT;

    -- Check if product exists
    IF NOT EXISTS (SELECT 1
    FROM producto
    WHERE id_producto = @id_producto AND id_empresa = @id_empresa)
    BEGIN
        RAISERROR('El producto no existe para la empresa especificada', 16, 1);
        RETURN;
    END;

    -- Determine if the product is a "Bien" (physical good) or "Servicio" (service)
    SELECT @es_bien = CASE WHEN tp.nombre = 'Bien' THEN 1 ELSE 0 END
    FROM producto p
        INNER JOIN familia fp ON p.id_familia = fp.id_familia
        INNER JOIN tipo_producto tp ON fp.id_tipo_producto = tp.id_tipo_producto
    WHERE p.id_producto = @id_producto AND p.id_empresa = @id_empresa;

    -- If it's a service, we don't need to update stock status
    IF @es_bien = 0
        RETURN;

    -- Get current product state and stock limits
    SELECT @estado_actual = estado, @stock_minimo = stock_minimo, @stock_maximo = stock_maximo
    FROM producto
    WHERE id_producto = @id_producto AND id_empresa = @id_empresa;

    -- If product was manually disabled (estado = 0), don't change its status
    IF @estado_actual = 0
        RETURN;

    -- Sum stock from all active warehouses
    SELECT @stock_total = ISNULL(SUM(pa.stock), 0)
    FROM producto_almacen pa
        INNER JOIN almacen a ON pa.id_almacen = a.id_almacen AND pa.id_empresa = a.id_empresa
    WHERE pa.id_producto = @id_producto
        AND pa.id_empresa = @id_empresa
        AND a.estado = 1;

    -- Determine new stock status (estado_stock)
    IF @stock_total = 0
        SET @estado_stock_nuevo = 0; -- Sin stock
    ELSE IF @stock_total <= @stock_minimo
        SET @estado_stock_nuevo = 2; -- Stock bajo
    ELSE IF @stock_total < @stock_maximo
        SET @estado_stock_nuevo = 1; -- Stock normal
    ELSE
        SET @estado_stock_nuevo = 3;
    -- Sobre stock

    -- Update product status based on stock status
    UPDATE producto
    SET estado_stock = @estado_stock_nuevo,
        estado = CASE 
                    WHEN @estado_stock_nuevo = 0 AND estado = 1 THEN 2 -- Sin stock y estaba activo -> Inactivo por stock
                    WHEN @estado_stock_nuevo > 0 AND estado = 2 THEN 1 -- Con stock y estaba inactivo por stock -> Activo
                    ELSE estado -- Mantener estado actual
                 END
    WHERE id_producto = @id_producto AND id_empresa = @id_empresa;
END;