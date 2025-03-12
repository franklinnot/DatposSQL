
-- Objeto de tipo tabla usado para registros masivos
-- CREATE TYPE ud_accesos_rol AS TABLE (
--     id_acceso BIGINT
-- );

CREATE OR ALTER PROCEDURE sp_registrar_rol
    @nombre NVARCHAR(128),
    @accesos ud_accesos_rol READONLY,
    @id_empresa BIGINT
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @nuevo_id INT;

    BEGIN TRY
        BEGIN TRANSACTION;

        INSERT INTO rol (nombre, estado, id_empresa)
        VALUES (@nombre, 1, @id_empresa);

        SET @nuevo_id = SCOPE_IDENTITY();  -- Obtener el ID generado

        -- registramos los accesos
        EXEC sp_registrar_accesos_rol @id_rol = @nuevo_id, @id_empresa = @id_empresa, @accesos = @accesos;

        -- verificamos si los accesos se registraron
        IF NOT EXISTS (
            SELECT TOP 1 ar.id_acceso
        FROM acceso_rol ar
        WHERE ar.id_rol = @nuevo_id AND ar.id_empresa = @id_empresa
                )
                BEGIN
            ROLLBACK TRANSACTION;
        END

        -- si todo salio bien
        COMMIT TRANSACTION;

        -- Devuelve el ID con SELECT
        SELECT @nuevo_id AS nuevo_id;
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;
        THROW;
    END CATCH;
END;


GO




-- Ejecutar el procedimiento almacenado
------------------------------------

DECLARE @ListaAccesos ud_accesos_rol;
-- Insertar datos en la variable tipo tabla
INSERT INTO @ListaAccesos
    (id_acceso)
VALUES
    (1),
    (2),
    (3),
    (4),
    (5),
    (6),
    (7),
    (8),
    (9),
    (10),
    (11),
    (12),
    (13),
    (14),
    (15),
    (16),
    (17),
    (18),
    (19),
    (20),
    (21),
    (22);

EXEC sp_registrar_rol 
    @nombre = 'Administrador',
    @id_empresa = 1,
    @accesos = @ListaAccesos;
-------------------------

-- accesos que un rol tiene
EXEC sp_get_accesos_by_id_rol @id_rol = 1;


SELECT * from rol;
