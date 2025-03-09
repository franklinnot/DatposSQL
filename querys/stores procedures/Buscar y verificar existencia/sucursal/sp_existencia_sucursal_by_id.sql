

CREATE OR ALTER PROCEDURE sp_existencia_sucursal_by_id
    @id_sucursal BIGINT
AS
BEGIN
    SET NOCOUNT ON;
    IF EXISTS(SELECT 1 FROM sucursal WHERE id_sucursal = @id_sucursal)
    BEGIN
        SELECT 'true' AS 'existe'
    END
    ELSE
    BEGIN
        SELECT 'false' AS 'verificar'
    END
END;

EXEC sp_existencia_sucursal_by_id @id_sucursal = 60;

SELECT *
FROM sucursal;