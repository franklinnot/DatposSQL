

CREATE OR ALTER PROCEDURE sp_eliminar_almacen_by_id
    @id_almacen BIGINT
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY
        BEGIN TRANSACTION;

        DELETE FROM almacen WHERE id_almacen = @id_almacen;

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
EXEC sp_eliminar_almacen_by_id @id_almacen = 1;


SELECT * FROM almacen;