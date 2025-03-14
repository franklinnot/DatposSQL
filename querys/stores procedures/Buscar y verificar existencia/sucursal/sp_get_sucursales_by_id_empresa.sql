


CREATE OR ALTER PROCEDURE sp_get_sucursales_by_id_empresa
    @id_empresa BIGINT
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
        id_almacen,
        id_empresa
    FROM sucursal
    WHERE id_empresa = @id_empresa;
END;

EXEC sp_get_sucursales_by_id_empresa @id_empresa = 1;

SELECT *
FROM sucursal;
