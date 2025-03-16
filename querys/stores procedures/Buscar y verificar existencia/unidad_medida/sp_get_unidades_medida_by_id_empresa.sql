


CREATE OR ALTER PROCEDURE sp_get_unidades_medida_by_id_empresa
    @id_empresa BIGINT
AS
BEGIN
    SET NOCOUNT ON;

    SELECT
        id_unidad_medida,
        codigo,
        nombre,
        descripcion,
        estado,
        id_empresa
    FROM unidad_medida
    WHERE id_empresa = @id_empresa;
END;

EXEC sp_get_unidades_medida_by_id_empresa @id_empresa = 1;

SELECT *
FROM unidad_medida;



