


CREATE OR ALTER PROCEDURE sp_get_caja_by_id
    @id_caja BIGINT
AS
BEGIN
    SET NOCOUNT ON;

    SELECT
        id_caja,
        codigo,
        nombre,
        estado,
        id_sucursal,
        id_empresa
    FROM caja
    WHERE LOWER(id_caja) = LOWER(@id_caja);
END;

EXEC sp_get_caja_by_id @id_caja = 34;

SELECT * FROM caja;