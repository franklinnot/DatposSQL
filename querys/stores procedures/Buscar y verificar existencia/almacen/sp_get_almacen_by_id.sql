


CREATE OR ALTER PROCEDURE sp_get_almacen_by_id
    @id_almacen BIGINT,
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
    WHERE id_almacen = @id_almacen and id_empresa = @id_empresa;
END;

EXEC sp_get_almacen_by_id @id_almacen = 34, @id_empresa = 1;

SELECT * FROM almacen;