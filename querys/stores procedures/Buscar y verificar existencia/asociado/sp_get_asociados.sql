
CREATE OR ALTER PROCEDURE sp_get_asociados
    @id_empresa BIGINT
AS
BEGIN
    SET NOCOUNT ON;
    SELECT
        a.id_asociado,
        a.nombre,
        a.estado
    FROM asociado a
    WHERE a.id_empresa = @id_empresa;
END;