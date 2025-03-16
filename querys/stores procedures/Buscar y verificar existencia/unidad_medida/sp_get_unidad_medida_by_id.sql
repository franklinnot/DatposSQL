

CREATE OR ALTER PROCEDURE sp_get_unidad_medida_by_id
    @id_unidad_medida BIGINT,
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
    WHERE id_unidad_medida = @id_unidad_medida AND id_empresa = @id_empresa;
END;


EXEC sp_get_unidad_medida_by_id @id_unidad_medida = 1, @id_empresa = 1;

SELECT * FROM unidad_medida;

