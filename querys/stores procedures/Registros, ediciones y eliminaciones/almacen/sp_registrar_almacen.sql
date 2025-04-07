

CREATE OR ALTER PROCEDURE sp_registrar_almacen
    @codigo NVARCHAR(24),
    @nombre NVARCHAR(128),
    @departamento NVARCHAR(64) = NULL,
    @ciudad NVARCHAR(64) = NULL,
    @direccion NVARCHAR(255) = NULL,
    @id_empresa BIGINT
AS
BEGIN
    SET NOCOUNT ON;
    
    DECLARE @nuevo_id BIGINT;
    
    BEGIN TRY
        BEGIN TRANSACTION;
        
        -- Validar si el codigo ya existe
        IF EXISTS (SELECT 1
        FROM almacen
        WHERE codigo = @codigo and id_empresa = @id_empresa)
        BEGIN
            ROLLBACK TRANSACTION;
            -- Evitar duplicados
            RETURN;
        END;

        INSERT INTO almacen (codigo, nombre, departamento, ciudad, direccion, estado, id_empresa)
        VALUES (@codigo, @nombre, @departamento, @ciudad, @direccion, 1, @id_empresa);
        
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


EXEC sp_registrar_almacen 
    @codigo = 'A009', 
    @nombre = 'Almacén Mancora', 
    @departamento = 'Piura', 
    @ciudad = 'Mancora', 
    @direccion = 'Calle 966',
    @id_empresa = 1


