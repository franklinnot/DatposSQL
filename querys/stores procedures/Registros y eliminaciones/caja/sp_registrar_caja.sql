

CREATE OR ALTER PROCEDURE sp_registrar_caja
    @codigo NVARCHAR(24),
    @nombre NVARCHAR(128) = NULL,
    @id_sucursal BIGINT,
    @id_empresa BIGINT
AS
BEGIN
    SET NOCOUNT ON;
    
    DECLARE @nuevo_id INT;
    
    BEGIN TRY
        BEGIN TRANSACTION;
        
        INSERT INTO caja (codigo, nombre, estado, id_sucursal, id_empresa)
        VALUES (@codigo, @nombre, 1, @id_sucursal, @id_empresa);
        
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


EXEC sp_registrar_caja 
    @codigo = 'CJ1', 
    @nombre = 'Caja Principal',
    @id_sucursal = 1,
    @id_empresa = 1

SELECT * FROM caja;

