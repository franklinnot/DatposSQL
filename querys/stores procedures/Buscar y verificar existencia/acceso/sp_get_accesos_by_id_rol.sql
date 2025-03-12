

CREATE OR ALTER PROCEDURE sp_get_accesos_by_id_rol
    @id_rol BIGINT
AS
BEGIN
    SET NOCOUNT ON;
    
    SELECT a.id_acceso, a.nombre, a.ruta, a.estado
    FROM acceso a
    INNER JOIN acceso_rol ar ON a.id_acceso = ar.id_acceso
    WHERE ar.id_rol = @id_rol;
END;

EXEC sp_get_accesos_by_id_rol @id_rol = 1;
