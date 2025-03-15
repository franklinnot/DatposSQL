

CREATE OR ALTER PROCEDURE sp_existencia_usuario_by_email
    @email NVARCHAR(255)
AS
BEGIN
    SET NOCOUNT ON;
    IF EXISTS(SELECT 1 FROM usuario WHERE LOWER(email) = LOWER(@email))
    BEGIN
        SELECT 'true' AS 'verificar'
    END
    ELSE
    BEGIN
        SELECT 'false' AS 'verificar'
    END
END;

EXEC sp_existencia_usuario_by_email @email = 'franklin@gmail.com';

SELECT *
FROM usuario;
