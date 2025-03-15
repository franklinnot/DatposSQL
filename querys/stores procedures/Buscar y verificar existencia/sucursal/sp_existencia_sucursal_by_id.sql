

CREATE OR ALTER PROCEDURE sp_existencia_sucursal_by_id
    @id_sucursal BIGINT,
    @id_empresa BIGINT
AS
BEGIN
    SET NOCOUNT ON;
    IF EXISTS(SELECT 1 FROM sucursal WHERE id_sucursal = @id_sucursal and id_empresa = @id_empresa)
    BEGIN
        SELECT 'true' AS 'verificar'
    END
    ELSE
    BEGIN
        SELECT 'false' AS 'verificar'
    END
END;

EXEC sp_existencia_sucursal_by_id @id_sucursal = 60, @id_empresa = 1;

SELECT *
FROM sucursal;