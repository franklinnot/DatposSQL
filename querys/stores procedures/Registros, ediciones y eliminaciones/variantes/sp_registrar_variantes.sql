
-- Objeto de tipo tabla usado para registros masivos de variantes
-- CREATE TYPE ud_variantes AS TABLE (
--     nombre NVARCHAR(128)
-- );

-- CREATE TYPE ud_detalles_variante AS TABLE
-- (
--     nombre NVARCHAR(128)
-- );

GO

CREATE OR ALTER PROCEDURE sp_registrar_variantes
    @variantes NVARCHAR(MAX),
    @id_producto BIGINT,
    @id_empresa BIGINT
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @nuevo_id INT;
    DECLARE @variantTable TABLE (variante NVARCHAR(128),
        detalles NVARCHAR(MAX));
    DECLARE @detailTable TABLE (nombre NVARCHAR(128));

    BEGIN TRY
        -- No se inicia una nueva transacción, se asume que ya está en una transacción activa
        
        -- Convertir el JSON de variantes a una tabla
        INSERT INTO @variantTable
        (variante, detalles)
    SELECT variante, detalles
    FROM OPENJSON(@variantes)
        WITH (
            variante NVARCHAR(128) '$.variante',
            detalles NVARCHAR(MAX) AS JSON
        );

        DECLARE @variante NVARCHAR(128);
        DECLARE @detalles NVARCHAR(MAX);

        DECLARE variant_cursor CURSOR FOR
        SELECT variante, detalles
    FROM @variantTable;

        OPEN variant_cursor;

        FETCH NEXT FROM variant_cursor INTO @variante, @detalles;

        WHILE @@FETCH_STATUS = 0
        BEGIN
        -- Insertar el nuevo variante
        INSERT INTO variante
            (nombre, estado, id_producto, id_empresa)
        VALUES
            (@variante, 1, @id_producto, @id_empresa);

        SET @nuevo_id = SCOPE_IDENTITY();

        -- Convertir el JSON de detalles a una tabla
        INSERT INTO @detailTable
            (nombre)
        SELECT detalle
        FROM OPENJSON(@detalles)
            WITH (detalle NVARCHAR(128) '$.detalle');

        -- Insertar los detalles del variante
        INSERT INTO detalle_variante
            (nombre, estado, id_variante, id_empresa)
        SELECT nombre, 1, @nuevo_id, @id_empresa
        FROM @detailTable;

        -- Limpiar la tabla temporal de detalles
        DELETE FROM @detailTable;

        FETCH NEXT FROM variant_cursor INTO @variante, @detalles;
    END

        CLOSE variant_cursor;
        DEALLOCATE variant_cursor;
        
        -- Se confía en el procedimiento externo para el COMMIT
    END TRY
    BEGIN CATCH
        -- Se propaga el error para que lo gestione el procedimiento externo
        THROW;
    END CATCH;
END;
GO



-- -- Ejecutar el procedimiento almacenado
-- ------------------------------------

-- DECLARE @detalles NVARCHAR(MAX);
-- SET @detalles = N'[
--     { "id_acceso": 1 },
--     { "id_acceso": 2 },
--     { "id_acceso": 3 }
-- ]';

-- -- Paso 3: Ejecutar el procedimiento almacenado
-- DECLARE @nombre NVARCHAR(128) = 'Jefe de Almacén';
-- DECLARE @id_empresa BIGINT = 1;

-- EXEC sp_registrar_variante @nombre = @nombre, @detalles = @detalles, @id_empresa = @id_empresa;

-- -------------------------

-- -- accesos que un variante tiene
-- EXEC sp_get_accesos_by_id_variante @id_variante = 1;


-- SELECT *
-- from variante;
