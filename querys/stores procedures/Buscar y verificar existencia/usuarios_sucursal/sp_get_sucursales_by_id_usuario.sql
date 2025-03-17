

CREATE OR ALTER PROCEDURE sp_get_sucursales_by_id_usuario
    @id_usuario BIGINT,
    @id_empresa BIGINT
AS
BEGIN
    SET NOCOUNT ON;
    SELECT s.id_sucursal, s.codigo, s.nombre, s.estado
    FROM sucursal s
    INNER JOIN usuario_sucursal us ON s.id_sucursal = us.id_sucursal
    WHERE us.id_usuario = @id_usuario AND us.id_empresa = @id_empresa;
END;


---------------------------

EXEC sp_get_sucursales_by_id_usuario @id_usuario = 1, @id_empresa = 1;

select * from sucursal;


