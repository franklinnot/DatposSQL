


-- Objeto de tipo tabla usado para registros masivos
-- CREATE TYPE ud_usuarios_sucursal AS TABLE (
--     id_sucursal BIGINT
-- );

CREATE OR ALTER PROCEDURE sp_registrar_usuarios_sucursal
    @id_usuario BIGINT,
    @id_empresa BIGINT,
    @sucursales ud_usuarios_sucursal READONLY
AS
BEGIN
    SET NOCOUNT ON;
    BEGIN TRY
        -- Insertar los sucursales recibidos en la tabla usuario_sucursal en base al usuario
        INSERT INTO usuario_sucursal
        (id_sucursal, id_usuario, id_empresa)
        SELECT id_sucursal, @id_usuario, @id_empresa
        FROM @sucursales s
        WHERE NOT EXISTS (
        SELECT 1
        FROM usuario_sucursal us
        WHERE us.id_sucursal = s.id_sucursal
        AND us.id_usuario = @id_usuario
        AND us.id_empresa = @id_empresa
        );
        -- No hacer COMMIT o ROLLBACK aquí
    END TRY
    BEGIN CATCH
        -- No hacer ROLLBACK aquí, pero asegurarse de que la excepción se propague
        ;THROW; -- Punto y coma añadido antes de THROW
    END CATCH;
END;

GO

-------------------------

-- Ejecutar el procedimiento sucursalado
DECLARE @Listasucursales ud_usuarios_sucursal;

-- Insertar datos en la variable tipo tabla
INSERT INTO @Listasucursales
    (id_sucursal)
VALUES
    (1);

EXEC sp_registrar_usuarios_sucursal @id_usuario = 1, @id_empresa = 1, @sucursales = @Listasucursales;

-------------------------

-- sucursales que un usuario tiene
EXEC sp_get_sucursales_by_id_usuario @id_usuario = 1, @id_empresa = 1;

-- sucursales que un usuario no tiene
SELECT s.id_sucursal, s.nombre
FROM sucursal s
    LEFT JOIN usuario_sucursal us ON us.id_sucursal = us.id_sucursal AND us.id_usuario = 1
WHERE us.id_sucursal IS NULL;

