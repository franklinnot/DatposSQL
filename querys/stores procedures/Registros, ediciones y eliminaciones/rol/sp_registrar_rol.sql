
-- Objeto de tipo tabla usado para registros masivos
-- CREATE TYPE ud_accesos_rol AS TABLE (
--     id_acceso BIGINT
-- );


CREATE OR ALTER PROCEDURE sp_registrar_rol
    @nombre NVARCHAR(64),
    @accesos NVARCHAR(MAX),
    -- Se espera un JSON con un arreglo de objetos que contengan "id_acceso"
    @id_empresa BIGINT
AS
BEGIN
    SET NOCOUNT ON;
    DECLARE @nuevo_id INT;
    DECLARE @accesosTable ud_accesos_rol;
    -- Tabla temporal
    DECLARE @transactionCount INT = @@TRANCOUNT;
    -- Guarda el conteo actual de transacciones

    BEGIN TRY
        IF @transactionCount = 0
        BEGIN
            BEGIN TRANSACTION;
        END
        
        -- Convertir el JSON a una tabla
        INSERT INTO @accesosTable
        (id_acceso)
        SELECT id_acceso
        FROM OPENJSON(@accesos)
        WITH (id_acceso BIGINT '$.id_acceso');
        
        -- Insertar el nuevo rol
        INSERT INTO rol
        (nombre, estado, id_empresa)
        VALUES (@nombre, 1, @id_empresa);
        
        SET @nuevo_id = SCOPE_IDENTITY();  -- Obtener el ID generado para el rol
        
        -- Registrar los accesos asociados al rol
        EXEC sp_registrar_accesos_rol @id_rol = @nuevo_id, @id_empresa = @id_empresa, @accesos = @accesosTable;
        
        -- Verificar que se hayan registrado los accesos
        IF NOT EXISTS (
            SELECT 1
            FROM acceso_rol
            WHERE id_rol = @nuevo_id
                AND id_empresa = @id_empresa
        )
        BEGIN
            ;THROW 51000, 'Los accesos no se registraron correctamente.', 1;
        END
        
        IF @transactionCount = 0
        BEGIN
            COMMIT TRANSACTION;
        END
        
        -- Devuelve el ID del nuevo rol
        SELECT @nuevo_id AS nuevo_id;
    END TRY
    BEGIN CATCH
        IF @transactionCount = 0 AND XACT_STATE() <> 0
        BEGIN
            ROLLBACK TRANSACTION;
        END
        
        -- Re-lanzar la excepción capturada
        ;THROW;
    END CATCH;
END;


GO


-- Ejecutar el procedimiento almacenado
------------------------------------

DECLARE @accesos NVARCHAR(MAX);
SET @accesos = N'[
    { "id_acceso": 1 },
    { "id_acceso": 2 },
    { "id_acceso": 3 }
]';

-- Paso 3: Ejecutar el procedimiento almacenado
DECLARE @nombre NVARCHAR(128) = 'Jefe de Almacén';
DECLARE @id_empresa BIGINT = 1;

EXEC sp_registrar_rol @nombre = @nombre, @accesos = @accesos, @id_empresa = @id_empresa;

-------------------------

-- accesos que un rol tiene
EXEC sp_get_accesos_by_id_rol @id_rol = 1;


SELECT *
from rol;
