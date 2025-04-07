

CREATE OR ALTER PROCEDURE sp_registrar_unidad_medida
    @nombre NVARCHAR(255),
    @codigo NVARCHAR(24),
    @descripcion NVARCHAR(255) = NULL,
    @id_empresa BIGINT
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @nuevo_id BIGINT;

    BEGIN TRY
        BEGIN TRANSACTION;

        -- Validar si la unidad de medidad ya existe por codigo
        IF EXISTS (SELECT 1
        FROM unidad_medida
        WHERE codigo = @codigo)
        BEGIN
            ROLLBACK TRANSACTION;
            -- Evitar duplicados
            RETURN;
        END;


        -- Insertar 
        INSERT INTO unidad_medida
        (codigo, nombre, descripcion, estado, id_empresa)
        VALUES
        (@codigo, @nombre, @descripcion, '1', @id_empresa);
        
        SET @nuevo_id = SCOPE_IDENTITY();

        COMMIT TRANSACTION;

        -- Retornar el ID del nuevo usuario
        SELECT @nuevo_id AS nuevo_id;
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;
        THROW;
    END CATCH;
END;


GO


EXEC sp_registrar_unidad_medida
@codigo = 'KG', @nombre = 'Kilogramito', @id_empresa = 1;


SELECT * FROM unidad_medida;

