

CREATE OR ALTER PROCEDURE sp_get_accesos_by_id_rol
    @id_rol BIGINT,
    @id_empresa BIGINT
AS
BEGIN
    SET NOCOUNT ON;
    
    SELECT a.id_acceso, a.nombre, a.ruta, a.estado
    FROM acceso a
    INNER JOIN acceso_rol ar ON a.id_acceso = ar.id_acceso
    WHERE ar.id_rol = @id_rol and id_empresa = @id_empresa;
END;


---------------------------

EXEC sp_get_accesos_by_id_rol @id_rol = 1, @id_empresa = 1;

select * from acceso_rol;