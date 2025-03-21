


CREATE OR ALTER PROCEDURE sp_get_familias_by_id_empresa
    @id_empresa BIGINT
AS
BEGIN
    SET NOCOUNT ON;

    SELECT
        id_familia,
        codigo,
        nombre,
        descripcion,
        color,
        estado,
        id_tipo_producto,
        id_empresa
    FROM familia
    WHERE id_empresa = @id_empresa;
END;

EXEC sp_get_familias_by_id_empresa @id_empresa = 1;

SELECT *
FROM familia;
