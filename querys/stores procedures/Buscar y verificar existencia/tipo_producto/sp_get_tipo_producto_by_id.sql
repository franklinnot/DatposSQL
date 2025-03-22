

CREATE OR ALTER PROCEDURE sp_get_tipo_producto_by_id
@id_tipo_producto BIGINT
AS
BEGIN
    SELECT 
        id_tipo_producto,
        nombre,
        estado
    FROM tipo_producto
    WHERE id_tipo_producto = @id_tipo_producto;
END;


SELECT * FROM tipo_producto;