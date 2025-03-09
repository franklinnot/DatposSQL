

CREATE OR ALTER PROCEDURE sp_existencia_sucursal_by_codigo
    @codigo NVARCHAR(128),
    @id_empresa BIGINT
AS
BEGIN
    SET NOCOUNT ON;
    IF EXISTS(SELECT 1 FROM sucursal WHERE LOWER(codigo) = LOWER(@codigo) AND id_empresa = @id_empresa)
    BEGIN
        SELECT 'true' AS 'existe'
    END
    ELSE
    BEGIN
        SELECT 'false' AS 'verificar'
    END
END;

EXEC sp_existencia_sucursal_by_codigo @codigo = 'TPR', @id_empresa = 1;

SELECT *
FROM sucursal;