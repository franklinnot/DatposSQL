

CREATE OR ALTER PROCEDURE sp_get_usuario_by_id
    @id_usuario BIGINT,
    @id_empresa BIGINT
AS
BEGIN
    SET NOCOUNT ON;
    
    SELECT 
        id_usuario,
        dni,
        email,
        created_at,
        nombre,
        foto,
        estado,
        id_rol,
        id_empresa
    FROM usuario
    WHERE id_usuario = @id_usuario and id_empresa = @id_empresa;
END;

EXEC sp_get_usuario_by_id @id_usuario = 1, @id_empresa = 1;