

CREATE OR ALTER PROCEDURE sp_get_rol_by_id
    @id_rol BIGINT,
    @id_empresa BIGINT
AS
BEGIN
    SET NOCOUNT ON;
    
    SELECT 
        id_rol,
        nombre,
        estado,
        id_empresa
    FROM rol
    WHERE id_rol = @id_rol AND id_empresa = @id_empresa;
END;


EXEC sp_get_rol_by_id @id_rol = 1, @id_empresa = 1;