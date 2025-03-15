


CREATE OR ALTER PROCEDURE sp_get_sucursal_by_codigo
    @codigo NVARCHAR(24),
    @id_empresa BIGINT
AS
BEGIN
    SET NOCOUNT ON;

    SELECT
        id_sucursal,
        codigo,
        nombre,
        departamento,
        ciudad,
        direccion,
        telefono,
        estado,
        id_almacen,
        id_empresa
    FROM sucursal
    WHERE codigo = @codigo AND id_empresa = @id_empresa;
END;

EXEC sp_get_sucursal_by_codigo @codigo = 'TPR', @id_empresa = 1;


SELECT *
FROM sucursal;




