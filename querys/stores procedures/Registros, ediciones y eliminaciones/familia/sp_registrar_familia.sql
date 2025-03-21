

CREATE OR ALTER PROCEDURE sp_registrar_familia
    @codigo NVARCHAR(24),
    @nombre NVARCHAR(128),
    @descripcion NVARCHAR(255) = NULL,
    @color CHAR(7) = NULL,
    @id_tipo_producto BIGINT,
    @id_empresa BIGINT
AS
BEGIN
    SET NOCOUNT ON;
    
    DECLARE @nuevo_id INT;
    
    BEGIN TRY
        BEGIN TRANSACTION;
        
        -- Validar si el codigo de la familia ya existe
        IF EXISTS (SELECT 1
        FROM familia
        WHERE codigo = @codigo and id_empresa = @id_empresa)
        BEGIN
            ROLLBACK TRANSACTION;
            -- Evitar duplicados
            RETURN;
        END;

        INSERT INTO familia (codigo, nombre, descripcion, color, estado, id_tipo_producto, id_empresa)
        VALUES (@codigo, @nombre, @descripcion, @color, 1, @id_tipo_producto, @id_empresa);
        
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


EXEC sp_registrar_familia 
    @codigo = 'CJ1', 
    @nombre = 'familia Principal',
    @id_tipo_producto = 1,
    @id_empresa = 1

SELECT * FROM familia;

