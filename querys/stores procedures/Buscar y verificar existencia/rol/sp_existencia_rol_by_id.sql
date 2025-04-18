

CREATE OR ALTER PROCEDURE sp_existencia_rol_by_id
    @id_rol BIGINT,
    @id_empresa BIGINT
AS
BEGIN
    SET NOCOUNT ON;
    IF EXISTS(SELECT 1 FROM rol WHERE id_rol = @id_rol AND id_empresa = @id_empresa)
    BEGIN
        SELECT 'true' AS 'verificar'
    END
    ELSE
    BEGIN
        SELECT 'false' AS 'verificar'
    END
END;

EXEC sp_existencia_rol_by_id @id_rol = 1, @id_empresa = 1;

SELECT *
FROM rol;