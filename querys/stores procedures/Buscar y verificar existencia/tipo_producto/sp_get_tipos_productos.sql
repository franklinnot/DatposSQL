

CREATE OR ALTER PROCEDURE sp_get_tipos_productos
AS
BEGIN
    SET NOCOUNT ON;
    SELECT t.id_tipo_producto, t.nombre, t.estado
    FROM tipo_producto t;
END;

-------------------------

EXEC sp_get_tipos_productos;

SELECT * FROM tipo_producto;
