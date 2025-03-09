

CREATE OR ALTER PROCEDURE sp_get_usuario_by_dni
    @dni NVARCHAR(100)
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
    WHERE dni = @dni;
END;

EXEC sp_get_usuario_by_dni @dni = '75048062';