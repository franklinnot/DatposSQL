



CREATE OR ALTER PROCEDURE sp_existencia_tipo_operacion_by_serie
    @serie NVARCHAR(24),
    @id_empresa BIGINT
AS
BEGIN
    SET NOCOUNT ON;
    IF EXISTS(SELECT 1
    FROM tipo_operacion
    WHERE serie = @serie AND id_empresa = @id_empresa)
    BEGIN
        SELECT 'true' AS 'verificar'
    END
    ELSE
    BEGIN
        SELECT 'false' AS 'verificar'
    END
END;

EXEC sp_existencia_tipo_operacion_by_serie @serie = 'cj-a', @id_empresa = 1;

SELECT *
FROM tipo_operacion;
