


CREATE OR ALTER PROCEDURE sp_get_roles_by_id_empresa
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
    WHERE id_empresa = @id_empresa;
END;

EXEC sp_get_roles_by_id_empresa @id_empresa = 1;

SELECT *
FROM rol;
