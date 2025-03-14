

CREATE OR ALTER PROCEDURE sp_existencia_caja_by_codigo
    @codigo NVARCHAR(24),
    @id_empresa BIGINT
AS
BEGIN
    SET NOCOUNT ON;
    IF EXISTS(SELECT 1 FROM caja WHERE LOWER(codigo) = LOWER(@codigo) AND id_empresa = @id_empresa)
    BEGIN
        SELECT 'true' AS 'verificar'
    END
    ELSE
    BEGIN
        SELECT 'false' AS 'verificar'
    END
END;

EXEC sp_existencia_caja_by_codigo @codigo = 'CJ-TPR', @id_empresa = 1;

SELECT *
FROM caja;
