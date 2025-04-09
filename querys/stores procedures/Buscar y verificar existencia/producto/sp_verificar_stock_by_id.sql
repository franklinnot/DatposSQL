

CREATE OR ALTER PROCEDURE sp_verificar_stock_by_id
    @id_producto BIGINT,
    @cantidad FLOAT,
    @id_almacen BIGINT,
    @id_empresa BIGINT
AS
BEGIN
    SET NOCOUNT ON;
    DECLARE @stock FLOAT;
    SELECT @stock = SUM(stock) FROM producto_almacen WHERE id_producto = @id_producto AND id_almacen = @id_almacen AND id_empresa = @id_empresa;
    IF @stock IS NULL
    BEGIN
        SET @stock = 0;
    END
    IF @cantidad > @stock
    BEGIN
        SELECT 'false' as 'verificar';
    END
    ELSE
    BEGIN
        SELECT 'true' as 'verificar';
    END
END;

---------------------------

EXEC sp_verificar_stock_by_id 24, 12, 2, 1;

SELECT * from producto;
select * from producto_almacen;
select * from almacen;