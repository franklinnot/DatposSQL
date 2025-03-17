

CREATE OR ALTER PROCEDURE sp_get_almacenes_by_id_usuario
    @id_usuario BIGINT,
    @id_empresa BIGINT
AS
BEGIN
    SET NOCOUNT ON;
    SELECT a.id_almacen, a.codigo, a.nombre, a.estado
    FROM almacen a
    INNER JOIN usuario_almacen ua ON a.id_almacen = ua.id_almacen
    WHERE ua.id_usuario = @id_usuario AND ua.id_empresa = @id_empresa;
END;


---------------------------

EXEC sp_get_almacenes_by_id_usuario @id_usuario = 1, @id_empresa = 1;

select * from almacen;


