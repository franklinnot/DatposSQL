

CREATE OR ALTER PROCEDURE sp_get_empresa_by_id
    @id_empresa BIGINT
AS
BEGIN
    SET NOCOUNT ON;
    
    SELECT 
        id_empresa,
        ruc, 
        razon_social,
        nombre_comercial,
        email,
        telefono,
        ciudad,
        direccion,
        igv,
        monto_maximo_boleta,
        numero_tributario,
        cantidad_sucursales, 
        cantidad_usuarios,
        sucursales_registradas,
        usuarios_registrados,
        logo,
        estado
    FROM empresa
    WHERE id_empresa = @id_empresa;
END;


EXEC sp_get_empresa_by_id @id_empresa = 1;