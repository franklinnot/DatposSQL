


CREATE OR ALTER PROCEDURE sp_get_caja_by_codigo
    @codigo NVARCHAR(24),
    @id_empresa BIGINT
AS
BEGIN
    SET NOCOUNT ON;

    SELECT
        id_caja,
        codigo,
        nombre,
        estado,
        id_sucursal,
        id_empresa
    FROM caja
    WHERE codigo = @codigo AND id_empresa = @id_empresa;
END;

EXEC sp_get_caja_by_codigo @codigo = 'CJ-TPR', @id_empresa = 1;

SELECT *
FROM caja;
