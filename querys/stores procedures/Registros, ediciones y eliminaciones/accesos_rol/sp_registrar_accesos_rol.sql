


-- Objeto de tipo tabla usado para registros masivos
-- CREATE TYPE ud_accesos_rol AS TABLE (
--     id_acceso BIGINT
-- );

CREATE OR ALTER PROCEDURE sp_registrar_accesos_rol
    @id_rol BIGINT,
    @id_empresa BIGINT,
    @accesos ud_accesos_rol READONLY
AS
BEGIN
    SET NOCOUNT ON;
    BEGIN TRY
        -- Insertar los accesos recibidos en la tabla acceso_rol en base al rol
        INSERT INTO acceso_rol
        (id_acceso, id_rol, id_empresa)
        SELECT id_acceso, @id_rol, @id_empresa
        FROM @accesos a
        WHERE NOT EXISTS (
            SELECT 1
            FROM acceso_rol ar
            WHERE ar.id_acceso = a.id_acceso
                AND ar.id_rol = @id_rol
                AND ar.id_empresa = @id_empresa
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
DECLARE @ListaAccesos ud_accesos_rol;

-- Insertar datos en la variable tipo tabla
INSERT INTO @ListaAccesos (id_acceso) 
VALUES 
(21),
(22),
(23),
(24);

EXEC sp_registrar_accesos_rol @id_rol = 1, @id_empresa = 1, @accesos = @ListaAccesos;

-------------------------

-- accesos que un rol tiene
EXEC sp_get_accesos_by_id_rol @id_rol = 1;

-- accesos que un rol no tiene
SELECT ac.id_acceso, ac.nombre
FROM acceso ac
LEFT JOIN acceso_rol ar ON ac.id_acceso = ar.id_acceso AND ar.id_rol = 1
WHERE ar.id_acceso IS NULL;

