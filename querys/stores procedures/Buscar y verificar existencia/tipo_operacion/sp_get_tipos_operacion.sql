
CREATE OR ALTER PROCEDURE sp_get_tipos_operacion
    @id_empresa BIGINT
AS
BEGIN
    SET NOCOUNT ON;
    SELECT
        id_tipo_operacion,
        nombre,
        tipo_movimiento,
        estado
    FROM tipo_operacion
    WHERE id_empresa = @id_empresa
    ORDER BY nombre;
END;

exec sp_get_tipos_operacion 1;

select * from tipo_operacion;