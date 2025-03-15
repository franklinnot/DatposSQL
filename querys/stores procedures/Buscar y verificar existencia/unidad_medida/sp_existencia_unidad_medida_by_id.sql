

CREATE OR ALTER PROCEDURE sp_existencia_unidad_medida_by_id
    @id_unidad_medida BIGINT,
    @id_empresa BIGINT
AS
BEGIN
    SET NOCOUNT ON;
    IF EXISTS(SELECT 1 FROM unidad_medida WHERE id_unidad_medida = @id_unidad_medida AND id_empresa = @id_empresa)
    BEGIN
        SELECT 'true' AS 'verificar'
    END
    ELSE
    BEGIN
        SELECT 'false' AS 'verificar'
    END
END;

EXEC sp_existencia_unidad_medida_by_id @id_unidad_medida = 1, @id_empresa = 1;

SELECT *
FROM unidad_medida;