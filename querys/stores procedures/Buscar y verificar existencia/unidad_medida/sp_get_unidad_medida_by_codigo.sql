


CREATE OR ALTER PROCEDURE sp_get_unidad_medida_by_codigo
    @codigo NVARCHAR(24),
    @id_empresa BIGINT
AS
BEGIN
    SET NOCOUNT ON;

    SELECT
        id_unidad_medida,
        codigo,
        nombre,
        estado,
        id_empresa
    FROM unidad_medida
    WHERE codigo = @codigo AND id_empresa = @id_empresa;
END;

EXEC sp_get_unidad_medida_by_codigo @codigo = 'SCR-TPR', @id_empresa = 1;

SELECT *
FROM unidad_medida;
