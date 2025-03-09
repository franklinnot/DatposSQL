

CREATE OR ALTER PROCEDURE sp_existencia_empresa_by_id
    @id_empresa BIGINT
AS
BEGIN
    SET NOCOUNT ON;
    IF EXISTS(SELECT 1 FROM empresa WHERE id_empresa = @id_empresa)
    BEGIN
        SELECT 'true' AS 'verificar'
    END
    ELSE
    BEGIN
        SELECT 'false' AS 'verificar'
    END
END;

EXEC sp_existencia_empresa_by_id @id_empresa = 1;

SELECT *
FROM empresa;
