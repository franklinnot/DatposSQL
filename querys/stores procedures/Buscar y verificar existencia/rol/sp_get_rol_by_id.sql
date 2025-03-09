

CREATE OR ALTER PROCEDURE sp_get_rol_by_id
    @id_rol BIGINT
AS
BEGIN
    SET NOCOUNT ON;
    
    SELECT 
        id_rol,
        nombre
    FROM rol
    WHERE id_rol = @id_rol;
END;


EXEC sp_get_rol_by_id @id_rol = 1;