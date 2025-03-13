

CREATE OR ALTER PROCEDURE sp_existencia_acceso_by_id
    @id_acceso BIGINT
AS
BEGIN
    SET NOCOUNT ON;
    IF EXISTS(SELECT 1 FROM acceso WHERE id_acceso = @id_acceso)
    BEGIN
        SELECT 'true' AS 'verificar'
    END
    ELSE
    BEGIN
        SELECT 'false' AS 'verificar'
    END
END;

EXEC sp_existencia_acceso_by_id @id_acceso = 1;

SELECT *
FROM acceso;