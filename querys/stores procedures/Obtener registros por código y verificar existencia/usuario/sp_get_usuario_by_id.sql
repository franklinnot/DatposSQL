

CREATE OR ALTER PROCEDURE sp_get_usuario_by_id
    @id_usuario BIGINT
AS
BEGIN
    SET NOCOUNT ON;
    
    SELECT 
        id_usuario,
        dni,
        email,
        created_at,
        nombre,
        direccion,
        foto,
        estado,
        id_rol
    FROM usuario
    WHERE id_usuario = @id_usuario;
END;

EXEC sp_get_usuario_by_id @id_usuario = 1;