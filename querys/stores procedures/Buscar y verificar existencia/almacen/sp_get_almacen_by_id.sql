


CREATE OR ALTER PROCEDURE sp_get_almacen_by_id
    @id_almacen BIGINT
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
    WHERE LOWER(id_almacen) = LOWER(@id_almacen);
END;

EXEC sp_get_almacen_by_id @id_almacen = 34;

SELECT * FROM almacen;