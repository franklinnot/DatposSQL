


CREATE OR ALTER PROCEDURE sp_registrar_sucursal
    @codigo NVARCHAR(128),
    @nombre NVARCHAR(128),
    @departamento NVARCHAR(128) = NULL,
    @ciudad NVARCHAR(128) = NULL,
    @direccion NVARCHAR(255) = NULL,
    @telefono NVARCHAR(128) = NULL,
    @id_almacen BIGINT,
    @id_empresa BIGINT
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @nuevo_id INT;

    BEGIN TRY
        BEGIN TRANSACTION;

        INSERT INTO sucursal (codigo, nombre, departamento, ciudad, direccion, telefono, estado, id_almacen, id_empresa)
        VALUES (@codigo, @nombre, @departamento, @ciudad, @direccion, @telefono, 1, @id_almacen, @id_empresa);

        SET @nuevo_id = SCOPE_IDENTITY();  -- Obtener el ID generado

        UPDATE empresa
        SET sucursales_registradas = sucursales_registradas + 1
        WHERE id_empresa = @id_empresa;

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


EXEC sp_registrar_sucursal 
    @codigo = '',
    @nombre = '',
    @departamento = '',
    @ciudad = '',
    @direccion = '',
    @telefono = '',
    @id_almacen = 1,
    @id_empresa = 1


SELECT * from sucursal;
