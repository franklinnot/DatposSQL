

CREATE OR ALTER PROCEDURE sp_registrar_asociado
    @nombre NVARCHAR(255),
    @tipo_asociado CHAR(1),
    @ruc CHAR(11) = NULL,
    @dni CHAR(8) = NULL,
    @email NVARCHAR(255) = NULL,
    @telefono NVARCHAR(32) = NULL,
    @id_empresa BIGINT
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @nuevo_id BIGINT;

    BEGIN TRY
        BEGIN TRANSACTION;
        
        -- Verificar que @ruc no sea NULL antes de la validación
        IF @ruc IS NOT NULL
        BEGIN
            -- Validar si la serie ya existe
            IF EXISTS (
                SELECT 1
            FROM asociado
            WHERE ruc = @ruc
                AND tipo_asociado = @tipo_asociado
                AND id_empresa = @id_empresa
            )
            BEGIN
                ROLLBACK TRANSACTION;
                -- Evitar duplicados
                RETURN;
            END;
        END;

        -- Verificar que @dni no sea NULL antes de la validación
        IF @dni IS NOT NULL
        BEGIN
            -- Validar si el DNI ya existe
            IF EXISTS (
                SELECT 1
            FROM asociado
            WHERE dni = @dni
                AND tipo_asociado = @tipo_asociado
                AND id_empresa = @id_empresa
            )
            BEGIN
                ROLLBACK TRANSACTION;
                -- Evitar duplicados
                RETURN;
            END;
        END;


        INSERT INTO asociado
        (nombre, tipo_asociado, ruc, dni, email, telefono, estado, id_empresa)
        VALUES
        (@nombre, @tipo_asociado, @ruc, @dni, @email, @telefono, 1, @id_empresa);
        
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


EXEC sp_registrar_asociado 
    @nombre = 'IBM',
    @tipo_asociado = 1,
    @id_empresa = 1

SELECT *
FROM asociado;

