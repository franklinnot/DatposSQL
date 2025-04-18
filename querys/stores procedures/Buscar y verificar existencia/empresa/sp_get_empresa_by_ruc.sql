

CREATE OR ALTER PROCEDURE sp_get_empresa_by_ruc
    @ruc CHAR(11)
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
        departamento,
        ciudad,
        direccion,
        igv,
        monto_maximo_boleta,
        cantidad_sucursales, 
        cantidad_usuarios,
        sucursales_registradas,
        usuarios_registrados,
        logo,
        estado
    FROM empresa
    WHERE ruc = @ruc;
END;


EXEC sp_get_empresa_by_ruc @ruc = '12345678';