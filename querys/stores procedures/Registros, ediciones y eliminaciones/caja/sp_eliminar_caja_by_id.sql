

CREATE OR ALTER PROCEDURE sp_eliminar_caja_by_id
    @id_caja BIGINT
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY
        BEGIN TRANSACTION;

        DELETE FROM caja WHERE id_caja = @id_caja;

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

-- Ejecución de pruebas
EXEC sp_eliminar_caja_by_id @id_caja = 1;


SELECT * FROM caja;