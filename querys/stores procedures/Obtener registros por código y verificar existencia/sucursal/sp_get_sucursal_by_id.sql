


CREATE OR ALTER PROCEDURE sp_get_sucursal_by_id
    @id_sucursal BIGINT
AS
BEGIN
    SET NOCOUNT ON;

    SELECT
        id_sucursal,
        codigo,
        nombre,
        departamento,
        ciudad,
        direccion,
        telefono,
        estado,
        id_almacen
    FROM sucursal
    WHERE id_sucursal = @id_sucursal;
END;

EXEC sp_get_sucursal_by_id @id_sucursal = 34;

SELECT *
FROM sucursal;



