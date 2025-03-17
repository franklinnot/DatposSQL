


-- Objeto de tipo tabla usado para registros masivos
-- CREATE TYPE ud_usuarios_almacen AS TABLE (
--     id_almacen BIGINT
-- );

CREATE OR ALTER PROCEDURE sp_registrar_usuarios_almacen
    @id_usuario BIGINT,
    @id_empresa BIGINT,
    @almacenes ud_usuarios_almacen READONLY
AS
BEGIN
    SET NOCOUNT ON;
    BEGIN TRY
        -- Insertar los almacenes recibidos en la tabla usuario_almacen en base al usuario
        INSERT INTO usuario_almacen
        (id_almacen, id_usuario, id_empresa)
        SELECT id_almacen, @id_usuario, @id_empresa
        FROM @almacenes a
        WHERE NOT EXISTS (
            SELECT 1
            FROM usuario_almacen ua
            WHERE ua.id_almacen = a.id_almacen
                AND ua.id_usuario = @id_usuario
                AND ua.id_empresa = @id_empresa
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

-- Ejecutar el procedimiento almacenado
DECLARE @Listaalmacenes ud_usuarios_almacen;

-- Insertar datos en la variable tipo tabla
INSERT INTO @Listaalmacenes (id_almacen) 
VALUES 
(1),
(2),
(3),
(4);

EXEC sp_registrar_usuarios_almacen @id_usuario = 1, @id_empresa = 1, @almacenes = @Listaalmacenes;

-------------------------

-- almacenes que un usuario tiene
EXEC sp_get_almacenes_by_id_usuario @id_usuario = 1, @id_empresa = 1;

-- almacenes que un usuario no tiene
SELECT a.id_almacen, a.nombre
FROM almacen a
LEFT JOIN usuario_almacen ua ON ua.id_almacen = a.id_almacen AND ua.id_usuario = 1
WHERE ua.id_almacen IS NULL;

