



CREATE TYPE ud_accesos_rol AS TABLE (
    id_acceso BIGINT
);

GO

CREATE PROCEDURE sp_registrar_accesos_rol
    @id_rol BIGINT,
    @id_empresa BIGINT,
    @accesos ud_accesos_rol READONLY
AS
BEGIN
    SET NOCOUNT ON;
    BEGIN TRANSACTION;
    BEGIN TRY
        -- Insertar los accesos recibidos en la tabla acceso_rol en base al rol
        INSERT INTO acceso_rol (id_acceso, id_rol, id_empresa)
        SELECT id_acceso, @id_rol, @id_empresa FROM @accesos a
        WHERE NOT EXISTS (
            SELECT 1 FROM acceso_rol ar
            WHERE ar.id_acceso = a.id_acceso
            AND ar.id_rol = @id_rol
            AND ar.id_empresa = @id_empresa
        );
        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;
        RAISERROR ('Error al registrar accesos.', 16, 1);
    END CATCH;
END;



-------------------------


DECLARE @ListaAccesos ud_accesos_rol;
-- Insertar datos en la variable tipo tabla
INSERT INTO @ListaAccesos (id_acceso) 
VALUES (7);

-- Ejecutar el procedimiento almacenado
EXEC sp_registrar_accesos_rol @id_rol = 1, @id_empresa = 1, @accesos = @ListaAccesos;



