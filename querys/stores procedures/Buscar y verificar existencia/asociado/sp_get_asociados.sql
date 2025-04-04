

CREATE OR ALTER PROCEDURE sp_get_proveedores
    @id_empresa BIGINT
AS
BEGIN
    SET NOCOUNT ON;
    SELECT
        a.id_asociado,
        a.nombre,
        a.estado
    FROM asociado a
    WHERE a.id_empresa = @id_empresa
    AND a.tipo_asociado = 2 -- soolo proveedores
    ORDER BY a.nombre;
END;


EXEC sp_get_proveedores 1;
select * from asociado;