


CREATE OR ALTER PROCEDURE sp_get_exclusive_almacenes_by_id_empresa
    @id_empresa BIGINT
AS
BEGIN
    SET NOCOUNT ON;

    SELECT
        a.id_almacen,
        a.codigo,
        a.nombre,
        a.departamento,
        a.ciudad,
        a.direccion,
        a.estado,
        a.id_empresa
    FROM almacen a
        LEFT JOIN sucursal s ON a.id_almacen = s.id_almacen
    WHERE a.id_empresa = @id_empresa
    AND s.id_almacen IS NULL;
END;


EXEC sp_get_exclusive_almacenes_by_id_empresa @id_empresa = 1;

SELECT *
FROM almacen;
