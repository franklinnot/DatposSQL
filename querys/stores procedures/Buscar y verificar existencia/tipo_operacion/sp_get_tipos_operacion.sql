
CREATE OR ALTER PROCEDURE sp_get_tipos_operacion
    @id_empresa BIGINT
AS
BEGIN
    SET NOCOUNT ON;
    SELECT
        id_tipo_operacion,
        nombre,
        estado
    FROM tipo_operacion
    WHERE id_empresa = @id_empresa;
END;

select * from tipo_operacion;