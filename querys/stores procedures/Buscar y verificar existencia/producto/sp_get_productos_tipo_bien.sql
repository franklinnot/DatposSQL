
CREATE OR ALTER PROCEDURE sp_get_productos_tipo_bien
    @id_empresa BIGINT
AS
BEGIN
    SET NOCOUNT ON;
    SELECT 
        p.id_producto,
        p.nombre
    FROM producto p
    INNER JOIN familia f ON p.id_familia = f.id_familia
    INNER JOIN tipo_producto tp ON f.id_tipo_producto = tp.id_tipo_producto
    WHERE p.id_empresa = @id_empresa and tp.nombre = 'Bien';
END;


SELECT * FROM producto;