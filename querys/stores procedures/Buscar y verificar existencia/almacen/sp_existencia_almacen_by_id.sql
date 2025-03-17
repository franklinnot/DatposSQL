

CREATE OR ALTER PROCEDURE sp_existencia_almacen_by_id
    @id_almacen BIGINT,
    @id_empresa BIGINT
AS
BEGIN
    SET NOCOUNT ON;
    IF EXISTS(SELECT 1 FROM almacen WHERE id_almacen = @id_almacen and id_empresa = @id_empresa)
    BEGIN
        SELECT 'true' AS 'verificar'
    END
    ELSE
    BEGIN
        SELECT 'false' AS 'verificar'
    END
END;

EXEC sp_existencia_almacen_by_id @id_almacen = 60, @id_empresa = 1;

SELECT *
FROM almacen;