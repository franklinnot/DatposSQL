


CREATE OR ALTER PROCEDURE sp_get_almacen_by_codigo
    @codigo NVARCHAR(128),
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
    WHERE LOWER(codigo) = LOWER(@codigo) AND id_empresa = @id_empresa;
END;

EXEC sp_get_almacen_by_codigo @codigo = 'SCR-TPR', @id_empresa = 1;

SELECT *
FROM almacen;
