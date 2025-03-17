

-- Objeto de tipo tabla usado para registros masivos
-- CREATE TYPE ud_usuarios_almacen AS TABLE (
--     id_almacen BIGINT
-- );

-- CREATE TYPE ud_usuarios_sucursal AS TABLE (
--     id_sucursal BIGINT
-- );


GO

CREATE OR ALTER PROCEDURE sp_registrar_usuario
    @dni CHAR(8),
    @nombre NVARCHAR(255),
    @email NVARCHAR(255),
    @password NVARCHAR(255),
    @sucursales NVARCHAR(MAX),
    @almacenes NVARCHAR(MAX),
    @id_rol BIGINT,
    @id_empresa BIGINT
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @nuevo_id INT;
    DECLARE @usuarios_registrados INT, @cantidad_usuarios INT;
    -- Tablas temporales
    DECLARE @almacenesTable ud_usuarios_almacen;
    DECLARE @sucursalesTable ud_usuarios_sucursal;
    -- Guarda el conteo actual de transacciones
    DECLARE @transactionCount INT = @@TRANCOUNT;

    BEGIN TRY
        IF @transactionCount = 0
        BEGIN
            BEGIN TRANSACTION;
        END

        -- Obtener la cantidad de usuarios registrados y el límite
        SELECT
            @usuarios_registrados = ISNULL(usuarios_registrados, 0),
            @cantidad_usuarios = ISNULL(cantidad_usuarios, 0)
        FROM empresa
        WHERE id_empresa = @id_empresa;

        -- Si la empresa no puede registrar más usuarios, detener el proceso
        IF @usuarios_registrados >= @cantidad_usuarios
        BEGIN
            ROLLBACK TRANSACTION;
            -- Detener la ejecución
            RETURN;
        END;
        
        -- Validar si el usuario ya existe por dni y empresa
        IF EXISTS (SELECT 1
        FROM usuario
        WHERE dni = @dni and id_empresa = @id_empresa)
        BEGIN
            ROLLBACK TRANSACTION;
            -- Evitar duplicados
            RETURN;
        END;

        -- Validar si el usuario en la bd ya existe por Email
        IF EXISTS (SELECT 1
        FROM usuario
        WHERE email = @email)
        BEGIN
            ROLLBACK TRANSACTION;
            -- Evitar duplicados
            RETURN;
        END;

        -- Validar el estado del rol
        IF NOT EXISTS (
            SELECT 1
            FROM rol
            WHERE id_rol = @id_rol AND id_empresa = @id_empresa AND estado = '1'
        )
        BEGIN
            ROLLBACK TRANSACTION;
            RETURN;
        END;

  
        -- Convertir el JSON a una tabla
        INSERT INTO @almacenesTable
        (id_almacen)
        SELECT id_almacen
        FROM OPENJSON(@almacenes)
        WITH (id_almacen BIGINT '$.id_almacen');
    
        INSERT INTO @sucursalesTable
        (id_sucursal)
        SELECT id_sucursal
        FROM OPENJSON(@sucursales)
        WITH (id_sucursal BIGINT '$.id_sucursal');


        -- Insertar el nuevo usuario
        INSERT INTO usuario 
        (dni, nombre, email, password, created_at, updated_at, estado, id_rol, id_empresa)
        VALUES
        (@dni, @nombre, @email, @password, GETDATE(), GETDATE(), 1, @id_rol, @id_empresa);
        
        SET @nuevo_id = SCOPE_IDENTITY();
        
        -- Registrar los almacenes y sucursales
        EXEC sp_registrar_usuarios_sucursal @id_usuario = @nuevo_id, @id_empresa = @id_empresa, @sucursales = @sucursalesTable;
        EXEC sp_registrar_usuarios_almacen @id_usuario = @nuevo_id, @id_empresa = @id_empresa, @almacenes = @almacenesTable;
        
        -- Verificar que se hayan registrado los accesos
        IF NOT EXISTS (
            SELECT 1
            FROM usuario_sucursal
            WHERE id_usuario = @nuevo_id
            AND id_empresa = @id_empresa
        )
        BEGIN
            ;THROW 51000, 'Los accesos no se registraron correctamente.', 1;
        END

        IF NOT EXISTS (
            SELECT 1
            FROM usuario_almacen
            WHERE id_usuario = @nuevo_id
            AND id_empresa = @id_empresa
        )
        BEGIN
            ;THROW 51000, 'Los accesos no se registraron correctamente.', 1;
        END

        UPDATE empresa
        SET usuarios_registrados = usuarios_registrados + 1
        WHERE id_empresa = @id_empresa;

        
        IF @transactionCount = 0
                BEGIN
            COMMIT TRANSACTION;
        END

        -- Retornar el ID del nuevo usuario
        SELECT @nuevo_id AS nuevo_id;
    END TRY
    BEGIN CATCH
        IF @transactionCount = 0 AND XACT_STATE() <> 0
        BEGIN
            ROLLBACK TRANSACTION;
        END
        ;THROW;
    END CATCH;
END;


GO


---------------------------------------------------

DECLARE @sucursales NVARCHAR(MAX);
SET @sucursales = N'[
    { "id_sucursal": 1 }
]';

DECLARE @almacenes NVARCHAR(MAX);
SET @almacenes = N'[
    { "id_almacen": 1 },
    { "id_almacen": 2 },
    { "id_almacen": 3 }
]';


EXEC sp_registrar_usuario
@dni = '85946632', 
@nombre = 'Castillo Rodriguez Franco Smith',
@email = 'smith@gmail.com', 
@password = '', 
@id_rol = 1, 
@sucursales = @sucursales, 
@almacenes = @almacenes, 
@id_empresa = 1;


SELECT * FROM usuario;

