
CREATE OR ALTER PROCEDURE sp_registrar_producto
    @codigo NVARCHAR(128),
    @nombre NVARCHAR(128),
    @imagen NVARCHAR(MAX) = NULL,
    @stock_minimo INTEGER = NULL,
    @stock_maximo INTEGER = NULL,
    @fecha_vencimiento DATE = NULL,
    @alerta_stock CHAR(1) = NULL,
    @alerta_vencimiento CHAR(1) = NULL,
    @tiene_igv CHAR(1),
    @isc FLOAT,
    @id_familia BIGINT,
    @id_unidad_medida BIGINT,
    @id_empresa BIGINT,
    @variantes NVARCHAR(MAX) = NULL
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @nuevo_id INT;

    BEGIN TRY
        BEGIN TRANSACTION;
        
        -- Validar si el código del producto ya existe
        IF EXISTS (SELECT 1
    FROM producto
    WHERE codigo = @codigo AND id_empresa = @id_empresa)
        BEGIN
        ROLLBACK TRANSACTION;
        RETURN;
    END;

        INSERT INTO producto
        (codigo, nombre, imagen,
        stock_minimo, stock_maximo,
        fecha_vencimiento,
        alerta_stock, alerta_vencimiento,
        tiene_igv, isc,
        estado, id_familia,
        id_unidad_medida, id_empresa)
    VALUES
        (
            @codigo, @nombre, @imagen,
            @stock_minimo, @stock_maximo,
            @fecha_vencimiento,
            @alerta_stock, @alerta_vencimiento,
            @tiene_igv, @isc,
            1, @id_familia,
            @id_unidad_medida, @id_empresa
        );
        
        SET @nuevo_id = SCOPE_IDENTITY();
        
        -- Insertar variantes y detalles
        IF @variantes IS NOT NULL
        BEGIN
        EXEC sp_registrar_variantes @variantes = @variantes, @id_producto = @nuevo_id, @id_empresa = @id_empresa;
    END
        
        COMMIT TRANSACTION;
        
        SELECT @nuevo_id AS nuevo_id;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;
        THROW;
    END CATCH;
END;
GO


------------------------------------

EXEC sp_registrar_producto 
    @codigo = 'CJ1', 
    @nombre = 'producto Principal',
    @tiene_igv = 1,
    @isc = 0,
    @id_familia = 1,
    @id_unidad_medida = 1,
    @id_empresa = 1

SELECT * FROM producto;

