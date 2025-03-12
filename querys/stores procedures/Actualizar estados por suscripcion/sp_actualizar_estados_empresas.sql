


CREATE OR ALTER PROCEDURE sp_actualizar_estados_empresas
AS
BEGIN
    SET NOCOUNT ON;
    
    -- Tabla temporal para almacenar los cambios en el estado de cada empresa.
    DECLARE @Changes TABLE (
         id_empresa BIGINT,
         OldEstado INT,
         NewEstado INT
    );

    -- Se actualiza el estado de cada empresa según los registros asociados en pago_tarifa.
    UPDATE e
    SET estado = CASE
        -- 1. Activo: Tiene al menos un pago en estado 1.
        WHEN EXISTS (
            SELECT 1 
            FROM pago_tarifa p 
            WHERE p.id_empresa = e.id_empresa 
              AND p.estado = 1
        ) THEN 1

        -- 2. Pendiente de pago: No tiene pagos activos, pero tiene al menos uno en periodo de gracia (estado 2).
        WHEN EXISTS (
            SELECT 1 
            FROM pago_tarifa p 
            WHERE p.id_empresa = e.id_empresa 
              AND p.estado = 2
        ) THEN 2

        -- 3. Modo prueba: No tiene pagos activos ni en periodo de gracia, pero tiene al menos uno pendiente de activación (estado 3).
        WHEN EXISTS (
            SELECT 1 
            FROM pago_tarifa p 
            WHERE p.id_empresa = e.id_empresa 
              AND p.estado = 3
			  AND e.estado = 3 -- La empresa debe estar en modo prueba para poder mantenerse en este estado
        ) THEN 3

        -- 4. Inhabilitado: No se encontró ningún registro válido (estados 1, 2 o 3).
        ELSE 0
	END
    OUTPUT deleted.id_empresa, deleted.estado, inserted.estado 
           INTO @Changes (id_empresa, OldEstado, NewEstado)
    FROM empresa e;

    -- Se recorre la tabla de cambios para identificar empresas que pasan de estado 3 a otro.
    DECLARE @id_empresa BIGINT;

    DECLARE change_cursor CURSOR LOCAL FAST_FORWARD FOR
        SELECT id_empresa 
        FROM @Changes
        WHERE OldEstado = 3 AND NewEstado <> 3;

    OPEN change_cursor;
    FETCH NEXT FROM change_cursor INTO @id_empresa;

    WHILE @@FETCH_STATUS = 0
    BEGIN
        -- Ejecuta el procedimiento para eliminar datos asociados a modo prueba.
        EXEC sp_eliminar_datos_empresa_modo_prueba @id_empresa = @id_empresa;
        
        FETCH NEXT FROM change_cursor INTO @id_empresa;
    END;

    CLOSE change_cursor;
    DEALLOCATE change_cursor;
END;


EXEC sp_actualizar_estados_empresas;