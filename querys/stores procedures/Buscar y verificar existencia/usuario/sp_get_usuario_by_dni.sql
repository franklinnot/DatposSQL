

CREATE OR ALTER PROCEDURE sp_get_usuario_by_dni
    @dni CHAR(8),
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
        estado,
        id_rol,
        id_empresa
    FROM usuario
    WHERE dni = @dni and id_empresa = @id_empresa;
END;

EXEC sp_get_usuario_by_dni @dni = '75048062', @id_empresa = 1;