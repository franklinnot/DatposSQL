

CREATE OR ALTER PROCEDURE sp_existencia_familia_by_id
    @id_familia BIGINT,
    @id_empresa BIGINT
AS
BEGIN
    SET NOCOUNT ON;
    IF EXISTS(SELECT 1 FROM familia WHERE id_familia = @id_familia AND id_empresa = @id_empresa)
    BEGIN
        SELECT 'true' AS 'verificar'
    END
    ELSE
    BEGIN
        SELECT 'false' AS 'verificar'
    END
END;

EXEC sp_existencia_familia_by_id @id_familia = 1, @id_empresa = 1;

SELECT *
FROM familia;