


CREATE OR ALTER PROCEDURE sp_get_almacenes_by_id_empresa
    @id_empresa BIGINT
AS
BEGIN
    SET NOCOUNT ON;

    SELECT
        id_almacen,
        nombre,
        estado
    FROM almacen
    WHERE id_empresa = @id_empresa;
END;

EXEC sp_get_almacenes_by_id_empresa @id_empresa = 1;

SELECT *
FROM almacen;
