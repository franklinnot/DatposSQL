


CREATE OR ALTER PROCEDURE sp_get_almacen_by_codigo
    @codigo NVARCHAR(24),
    @id_empresa BIGINT
AS
BEGIN
    SET NOCOUNT ON;

    SELECT
        id_almacen,
        codigo,
        nombre,
        departamento,
        ciudad,
        direccion,
        estado,
        id_empresa
    FROM almacen
    WHERE codigo = @codigo AND id_empresa = @id_empresa;
END;

EXEC sp_get_almacen_by_codigo @codigo = 'SCR-TPR', @id_empresa = 1;

SELECT *
FROM almacen;
