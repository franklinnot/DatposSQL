


CREATE OR ALTER PROCEDURE sp_get_familia_by_codigo
    @codigo NVARCHAR(24),
    @id_empresa BIGINT
AS
BEGIN
    SET NOCOUNT ON;

    SELECT
        id_familia,
        codigo,
        nombre,
        color,
        estado,
        id_empresa
    FROM familia
    WHERE codigo = @codigo AND id_empresa = @id_empresa;
END;

EXEC sp_get_familia_by_codigo @codigo = 'CJ-TPR', @id_empresa = 1;

SELECT *
FROM familia;
