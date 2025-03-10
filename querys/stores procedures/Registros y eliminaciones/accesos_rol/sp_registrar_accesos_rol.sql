



CREATE TYPE ud_accesos_rol AS TABLE (
    id_acceso BIGINT
);

GO

CREATE OR ALTER PROCEDURE sp_registrar_accesos_rol
    @id_rol BIGINT,
    @id_empresa BIGINT,
    @accesos ud_accesos_rol READONLY
AS
BEGIN
    SET NOCOUNT ON;
    DECLARE @rowCount INT;
    BEGIN TRANSACTION;
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

        -- Obtener el número de filas afectadas
        SET @rowCount = @@ROWCOUNT;

        -- Verificar si se insertaron filas
        IF @rowCount > 0
        BEGIN
        COMMIT TRANSACTION;
        SELECT 'true' AS verificar;
    END
        ELSE
        BEGIN
        ROLLBACK TRANSACTION;
        SELECT 'false' AS verificar;
    END
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;
        SELECT 'false' AS verificar;
        THROW;
    END CATCH;
END;

-------------------------

-- Ejecutar el procedimiento almacenado
DECLARE @ListaAccesos ud_accesos_rol;

-- Insertar datos en la variable tipo tabla
INSERT INTO @ListaAccesos (id_acceso) 
VALUES 
(17),
(18),
(19),
(20);

EXEC sp_registrar_accesos_rol @id_rol = 1, @id_empresa = 1, @accesos = @ListaAccesos;

-------------------------

-- accesos que un rol tiene
EXEC sp_get_accesos_rol_by_id @id_rol = 1;

-- accesos que un rol no tiene
SELECT ac.id_acceso, ac.nombre
FROM acceso ac
LEFT JOIN acceso_rol ar ON ac.id_acceso = ar.id_acceso AND ar.id_rol = 1
WHERE ar.id_acceso IS NULL;

