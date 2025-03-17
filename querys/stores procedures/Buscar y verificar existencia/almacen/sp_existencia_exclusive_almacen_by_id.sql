

CREATE OR ALTER PROCEDURE sp_existencia_exclusive_almacen_by_id
    @id_almacen BIGINT,
    @id_empresa BIGINT
AS
BEGIN
    SET NOCOUNT ON;

    IF EXISTS(
        SELECT 1
        FROM almacen
        WHERE id_almacen = @id_almacen
            AND id_empresa = @id_empresa
       )
        AND NOT EXISTS(
         SELECT 1
        FROM sucursal
        WHERE id_almacen = @id_almacen
       )
    BEGIN
        SELECT 'true' AS verificar;
    END
    ELSE
    BEGIN
        SELECT 'false' AS verificar;
    END
END;


EXEC sp_existencia_exclusive_almacen_by_id @id_almacen = 1, @id_empresa = 1;

SELECT *
FROM almacen;