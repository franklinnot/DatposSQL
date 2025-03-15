

CREATE OR ALTER PROCEDURE sp_existencia_usuario_by_dni
    @dni CHAR(8),
    @id_empresa BIGINT
AS
BEGIN
    SET NOCOUNT ON;
    IF EXISTS(SELECT 1 FROM usuario WHERE dni = @dni AND id_empresa = @id_empresa)
    BEGIN
        SELECT 'true' AS 'verificar'
    END
    ELSE
    BEGIN
        SELECT 'false' AS 'verificar'
    END
END;

EXEC sp_existencia_usuario_by_dni @dni = '75048062', @id_empresa = 1;

SELECT *
FROM usuario;
