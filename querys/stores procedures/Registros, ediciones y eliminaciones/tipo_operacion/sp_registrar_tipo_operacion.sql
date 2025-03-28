

CREATE OR ALTER PROCEDURE sp_registrar_tipo_operacion
    @nombre NVARCHAR(128),
    @serie NVARCHAR(128),
    @tipo_movimiento CHAR(1),
    @descripcion NVARCHAR(255) = NULL,
    @id_empresa BIGINT
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @nuevo_id INT;

    BEGIN TRY
        BEGIN TRANSACTION;
        
        -- Validar si la serie de ya existe
        IF EXISTS (SELECT 1
        FROM tipo_operacion
        WHERE serie = @serie and id_empresa = @id_empresa)
        BEGIN
            ROLLBACK TRANSACTION;
            -- Evitar duplicados
            RETURN;
        END;

        INSERT INTO tipo_operacion
        (nombre, serie, tipo_movimiento, descripcion, estado, id_empresa)
        VALUES
        (@nombre, @serie, @tipo_movimiento, @descripcion, 1, @id_empresa);
        
        SET @nuevo_id = SCOPE_IDENTITY();
        
        COMMIT TRANSACTION;
        
        SELECT @nuevo_id AS nuevo_id;
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;
        THROW;
    END CATCH;
END;

GO


EXEC sp_registrar_tipo_operacion 
    @serie = 'CJ1', 
    @nombre = 'Ingreso por Compra',
    @tipo_movimiento = 1,
    @id_empresa = 1

SELECT *
FROM tipo_operacion;

