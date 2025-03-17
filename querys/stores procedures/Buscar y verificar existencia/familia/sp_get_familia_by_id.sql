


CREATE OR ALTER PROCEDURE sp_get_familia_by_id
    @id_familia BIGINT,
    @id_empresa BIGINT
AS
BEGIN
    SET NOCOUNT ON;

    SELECT
        id_familia,
        codigo,
        nombre,
        color,
        estado,
        id_empresa
    FROM familia
    WHERE id_familia = @id_familia and id_empresa = @id_empresa;
END;

EXEC sp_get_familia_by_id @id_familia = 34, @id_empresa = 1;

SELECT * FROM familia;