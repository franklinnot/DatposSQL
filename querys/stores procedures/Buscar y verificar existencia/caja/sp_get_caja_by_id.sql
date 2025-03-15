


CREATE OR ALTER PROCEDURE sp_get_caja_by_id
    @id_caja BIGINT,
    @id_empresa BIGINT
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
    WHERE id_caja = @id_caja and id_empresa = @id_empresa;
END;

EXEC sp_get_caja_by_id @id_caja = 34, @id_empresa = 1;

SELECT * FROM caja;