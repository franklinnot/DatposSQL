-- Primero, asegúrate de que el tipo de datos esté creado y no comentado
-- CREATE TYPE ud_detalles_operacion AS TABLE (
--     id_producto BIGINT,
--     costo_unitario FLOAT NULL,
--     cantidad FLOAT
-- );
GO

CREATE OR ALTER PROCEDURE sp_registrar_operacion
    @id_usuario BIGINT,
    @id_tipo_operacion BIGINT,
    @id_almacen_origen BIGINT NULL,
    @id_almacen_destino BIGINT NULL,
    @id_asociado BIGINT NULL,
    @id_empresa BIGINT,
    @detalles NVARCHAR(MAX)
AS
BEGIN
    SET NOCOUNT ON;
    DECLARE @nuevo_id BIGINT;
    DECLARE @detallesTable ud_detalles_operacion;

    -- Campos a calcular
    DECLARE @serie NVARCHAR(128);
    DECLARE @numero NVARCHAR(128);
    DECLARE @codigo NVARCHAR(128);
    DECLARE @tipo_movimiento CHAR(1);

    DECLARE @fecha_actual DATETIME;
    SET @fecha_actual = GETDATE();

    -- Variable para control de transacciones
    DECLARE @transactionCount INT = @@TRANCOUNT;

    BEGIN TRY
        -- Iniciar transacción si no hay una activa
        IF @transactionCount = 0
        BEGIN
        BEGIN TRANSACTION;
    END;

        -- Validar que el tipo de operación exista y esté activo
        IF NOT EXISTS (SELECT 1
    FROM tipo_operacion
    WHERE id_tipo_operacion = @id_tipo_operacion
        AND id_empresa = @id_empresa AND estado = 1)
        BEGIN
        RAISERROR('El tipo de operación no existe o no está activo', 16, 1);
        RETURN;
    END;

        -- Validación de id_asociado (si no es null, debe estar activo)
        IF @id_asociado IS NOT NULL AND NOT EXISTS (SELECT 1
        FROM asociado
        WHERE id_asociado = @id_asociado
            AND id_empresa = @id_empresa AND estado = 1)
        BEGIN
        RAISERROR('El asociado no existe o no está activo', 16, 1);
        RETURN;
    END;

        -- Convertir el JSON a una tabla
        INSERT INTO @detallesTable
        (id_producto, costo_unitario, cantidad)
    SELECT id_producto, costo_unitario, cantidad
    FROM OPENJSON(@detalles)
        WITH (id_producto BIGINT '$.id_producto', 
              costo_unitario FLOAT '$.costo_unitario', 
              cantidad FLOAT '$.cantidad');

        -- Verificar que haya detalles
        IF NOT EXISTS (SELECT 1
    FROM @detallesTable)
        BEGIN
        RAISERROR('No se proporcionaron detalles para la operación', 16, 1);
        RETURN;
    END;

        -- Obtenemos el tipo de movimiento
        SET @tipo_movimiento = (SELECT tipo_movimiento
    FROM tipo_operacion
    WHERE id_tipo_operacion = @id_tipo_operacion);

        -- Calculamos la serie, número y código
        SET @serie = (SELECT serie
    FROM tipo_operacion
    WHERE id_tipo_operacion = @id_tipo_operacion
        AND id_empresa = @id_empresa);
        
        -- Calculamos el número basado en la cantidad de operaciones existentes de este tipo + 1
        DECLARE @contador INT;
        SELECT @contador = COUNT(*) + 1
    FROM operacion
    WHERE id_tipo_operacion = @id_tipo_operacion
        AND id_empresa = @id_empresa;
        
        -- Formateamos el número con ceros a la izquierda (8 dígitos)
        SET @numero = RIGHT('00000000' + CAST(@contador AS VARCHAR(8)), 8);
        
        -- Concatenamos serie y número para formar el código
        SET @codigo = @serie + '-' + @numero;

        -- Caso especial para transferencia (tipo_movimiento = 3)
        IF @tipo_movimiento = '3' -- Transferencia
        BEGIN
        -- Debe tener almacén origen y destino, y ambos deben estar activos
        IF @id_almacen_origen IS NULL OR NOT EXISTS (
                SELECT 1
            FROM almacen
            WHERE id_almacen = @id_almacen_origen
                AND id_empresa = @id_empresa AND estado = 1)
            BEGIN
            RAISERROR('El almacén de origen no existe o no está activo', 16, 1);
            RETURN;
        END;

        IF @id_almacen_destino IS NULL OR NOT EXISTS (
                SELECT 1
            FROM almacen
            WHERE id_almacen = @id_almacen_destino
                AND id_empresa = @id_empresa AND estado = 1)
            BEGIN
            RAISERROR('El almacén de destino no existe o no está activo', 16, 1);
            RETURN;
        END;

        -- Registramos la operación con ambos almacenes
        INSERT INTO operacion
            (serie, numero, codigo, fecha_registro, fecha_actualizacion, estado,
            id_usuario, id_almacen_origen, id_almacen_destino, id_tipo_operacion, id_asociado, id_empresa)
        VALUES
            (@serie, @numero, @codigo, @fecha_actual, @fecha_actual, 1,
                @id_usuario, @id_almacen_origen, @id_almacen_destino, @id_tipo_operacion, @id_asociado, @id_empresa);

        SET @nuevo_id = SCOPE_IDENTITY();

        -- Registramos los detalles de salida y entrada
        EXEC sp_registrar_detalles_operacion_salida @nuevo_id, @id_empresa, @id_almacen_origen, @detallesTable;
        EXEC sp_registrar_detalles_operacion_entrada @nuevo_id, @id_empresa, @id_almacen_destino, @detallesTable;
    END
        ELSE IF @tipo_movimiento = '2' -- Salida
        BEGIN
        -- Debe tener un almacen de origen y este debe estar activo
        IF @id_almacen_origen IS NULL OR NOT EXISTS (
                SELECT 1
            FROM almacen
            WHERE id_almacen = @id_almacen_origen
                AND id_empresa = @id_empresa AND estado = 1)
            BEGIN
            RAISERROR('El almacén de origen no existe o no está activo', 16, 1);
            RETURN;
        END;

        -- Registramos la operación
        INSERT INTO operacion
            (serie, numero, codigo, fecha_registro, fecha_actualizacion, estado,
            id_usuario, id_almacen_origen, id_tipo_operacion, id_asociado, id_empresa)
        VALUES
            (@serie, @numero, @codigo, @fecha_actual, @fecha_actual, 1,
                @id_usuario, @id_almacen_origen, @id_tipo_operacion, @id_asociado, @id_empresa);

        SET @nuevo_id = SCOPE_IDENTITY();

        -- Registramos los detalles de la operación
        EXEC sp_registrar_detalles_operacion_salida @nuevo_id, @id_empresa, @id_almacen_origen, @detallesTable;
    END
        ELSE IF @tipo_movimiento = '1' -- Entrada
        BEGIN
        -- Debe tener un almacen de destino y este debe estar activo
        IF @id_almacen_destino IS NULL OR NOT EXISTS (
                SELECT 1
            FROM almacen
            WHERE id_almacen = @id_almacen_destino
                AND id_empresa = @id_empresa AND estado = 1)
            BEGIN
            RAISERROR('El almacén de destino no existe o no está activo', 16, 1);
            RETURN;
        END;

        -- Registramos la operación
        INSERT INTO operacion
            (serie, numero, codigo, fecha_registro, fecha_actualizacion, estado,
            id_usuario, id_almacen_destino, id_tipo_operacion, id_asociado, id_empresa)
        VALUES
            (@serie, @numero, @codigo, @fecha_actual, @fecha_actual, 1,
                @id_usuario, @id_almacen_destino, @id_tipo_operacion, @id_asociado, @id_empresa);

        SET @nuevo_id = SCOPE_IDENTITY();

        -- Registramos los detalles de la operación
        EXEC sp_registrar_detalles_operacion_entrada @nuevo_id, @id_empresa, @id_almacen_destino, @detallesTable;
    END
        ELSE
        BEGIN
        RAISERROR('Tipo de movimiento no válido', 16, 1);
        RETURN;
    END;

        -- Actualizar el estado de stock para cada producto modificado
        DECLARE @productos_actualizados TABLE (id_producto BIGINT);
        
        INSERT INTO @productos_actualizados
        (id_producto)
    SELECT DISTINCT id_producto
    FROM @detallesTable;
        
        DECLARE @current_producto BIGINT;
        DECLARE producto_cursor CURSOR LOCAL FAST_FORWARD FOR 
            SELECT id_producto
    FROM @productos_actualizados;
        
        OPEN producto_cursor;
        FETCH NEXT FROM producto_cursor INTO @current_producto;
        
        WHILE @@FETCH_STATUS = 0
        BEGIN
        EXEC sp_actualizar_estado_stock @current_producto, @id_empresa;
        FETCH NEXT FROM producto_cursor INTO @current_producto;
    END
        
        CLOSE producto_cursor;
        DEALLOCATE producto_cursor;

        -- Commit transaction if we started it
        IF @transactionCount = 0 AND @@TRANCOUNT > 0
        BEGIN
        COMMIT TRANSACTION;
    END;

        -- Return the operation ID and code
        SELECT @nuevo_id AS nuevo_id, @codigo AS codigo;
    END TRY
    BEGIN CATCH
        -- Rollback transaction if we started it
        IF @transactionCount = 0 AND @@TRANCOUNT > 0
        BEGIN
        ROLLBACK TRANSACTION;
    END;
            
        -- Get error information
        DECLARE @ErrorMessage NVARCHAR(4000) = ERROR_MESSAGE();
        DECLARE @ErrorSeverity INT = ERROR_SEVERITY();
        DECLARE @ErrorState INT = ERROR_STATE();
        
        -- Raise the error with the original information
        RAISERROR(@ErrorMessage, @ErrorSeverity, @ErrorState);
    END CATCH;
END;