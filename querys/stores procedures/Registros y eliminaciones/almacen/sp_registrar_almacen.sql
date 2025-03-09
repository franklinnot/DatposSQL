

CREATE OR ALTER PROCEDURE sp_registrar_almacen
    @codigo NVARCHAR(128),
    @nombre NVARCHAR(255),
    @departamento NVARCHAR(128) = NULL,
    @ciudad NVARCHAR(128) = NULL,
    @direccion NVARCHAR(255) = NULL,
    @id_empresa BIGINT
AS
BEGIN
    SET NOCOUNT ON;
    
    DECLARE @nuevo_id INT;
    
    BEGIN TRY
        BEGIN TRANSACTION;
        
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


