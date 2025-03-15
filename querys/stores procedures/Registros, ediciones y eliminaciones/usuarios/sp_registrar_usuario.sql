

CREATE OR ALTER PROCEDURE sp_registrar_usuario
    @dni CHAR(8),
    @nombre NVARCHAR(255),
    @email NVARCHAR(255),
    @password NVARCHAR(255),
    @id_rol BIGINT,
    @id_empresa BIGINT
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @nuevo_id INT;
    DECLARE @usuarios_registrados INT, @cantidad_usuarios INT;

    BEGIN TRY
        BEGIN TRANSACTION;

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


        -- Validar si el usuario ya existe por Email
        IF EXISTS (SELECT 1
        FROM usuario
        WHERE email = @email)
                BEGIN
            ROLLBACK TRANSACTION;
            -- Evitar duplicados
            RETURN;
        END;


        -- Insertar el nuevo usuario
        INSERT INTO usuario 
        (dni, nombre, email, password, created_at, updated_at, estado, id_rol, id_empresa)
        VALUES
        (@dni, @nombre, @email, @password, GETDATE(), GETDATE(), 1, @id_rol, @id_empresa);
        
        SET @nuevo_id = SCOPE_IDENTITY();
        
        
        UPDATE empresa
        SET usuarios_registrados = usuarios_registrados + 1
        WHERE id_empresa = @id_empresa;

        COMMIT TRANSACTION;

        -- Retornar el ID del nuevo usuario
        SELECT @nuevo_id AS nuevo_id;
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;
        THROW;
    END CATCH;
END;


GO


EXEC sp_registrar_usuario
@dni = '85946632', @nombre = 'Castillo Rodriguez Franco Smith',
@email = 'smith@gmail.com', @password = '', 
@id_rol = 1, @id_empresa = 1;


SELECT * FROM usuario;

