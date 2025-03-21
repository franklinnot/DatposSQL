

CREATE OR ALTER PROCEDURE sp_existencia_tipo_producto_by_id
    @id_tipo_producto BIGINT
AS
BEGIN
    SET NOCOUNT ON;
    IF EXISTS(SELECT 1 FROM tipo_producto WHERE id_tipo_producto = @id_tipo_producto)
    BEGIN
        SELECT 'true' AS 'verificar'
    END
    ELSE
    BEGIN
        SELECT 'false' AS 'verificar'
    END
END;

EXEC sp_existencia_tipo_producto_by_id @id_tipo_producto = 1;

SELECT *
FROM tipo_producto;