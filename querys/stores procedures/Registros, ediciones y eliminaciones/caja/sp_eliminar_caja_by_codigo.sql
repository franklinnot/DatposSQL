

CREATE OR ALTER PROCEDURE sp_eliminar_caja_by_codigo
    @codigo NVARCHAR(24),
    @id_empresa BIGINT
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY
        BEGIN TRANSACTION;

        DELETE FROM caja WHERE codigo = @codigo AND id_empresa = @id_empresa;

        IF @@ROWCOUNT > 0
        BEGIN
        COMMIT TRANSACTION;
        SELECT 'true' AS verificar;
    END
        ELSE
        BEGIN
        ROLLBACK TRANSACTION;
        SELECT 'false' AS verificar;
    END
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;
        SELECT 'false' AS verificar;
        THROW;
    END CATCH;
END;

GO


EXEC sp_eliminar_caja_by_codigo @codigo = 'CJ1', @id_empresa = 1;


SELECT *
FROM caja;