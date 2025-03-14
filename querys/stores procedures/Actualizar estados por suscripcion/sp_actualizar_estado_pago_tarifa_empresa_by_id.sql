
CREATE OR ALTER PROCEDURE sp_actualizar_estado_pago_tarifa_empresa_by_id
     @id_pago_tarifa BIGINT
AS
BEGIN
     SET NOCOUNT ON;
     DECLARE @id_empresa BIGINT;
     --
     DECLARE @fecha_actual DATE = CAST(GETDATE() AS DATE);
     DECLARE @fecha_inicio DATE,
            @fecha_renovacion DATE,
            @dias_plazo INT,
            @nuevo_estado CHAR(1);

     -- Obtenemos los valores necesarios de pago_tarifa y los días de plazo de la empresa.
     SELECT @id_empresa = pt.id_empresa
     FROM pago_tarifa pt;

     SELECT
          @fecha_inicio = pt.fecha_inicio,
          @fecha_renovacion = pt.fecha_renovacion,
          @dias_plazo = e.dias_plazo
     FROM pago_tarifa pt
          INNER JOIN empresa e ON e.id_empresa = pt.id_empresa
     WHERE pt.id_pago_tarifa = @id_pago_tarifa
          AND e.id_empresa = @id_empresa;

     -- Determinar el estado a asignar según las fechas:
     -- 3: Pendiente de activación (si la fecha actual es menor que fecha_inicio).
     -- 1: Activo (si la fecha actual está entre fecha_inicio y fecha_renovacion).
     -- 2: Periodo de gracia (si la fecha actual es mayor que fecha_renovacion pero menor o igual que (fecha_renovacion + días_plazo)).
     -- 4: Expirado (si la fecha actual es mayor que (fecha_renovacion + días_plazo)).
     IF (@fecha_actual < @fecha_inicio)
     BEGIN
          SET @nuevo_estado = '3';
     -- Pendiente de activación
     END
     ELSE IF (@fecha_actual >= @fecha_inicio AND @fecha_actual <= @fecha_renovacion)
     BEGIN
          SET @nuevo_estado = '1';
     -- Activo
     END
     ELSE IF (@fecha_actual > @fecha_renovacion AND @fecha_actual <= DATEADD(DAY, @dias_plazo, @fecha_renovacion))
     BEGIN
          SET @nuevo_estado = '2';
     -- Periodo de gracia
     END
     ELSE IF (@fecha_actual > DATEADD(DAY, @dias_plazo, @fecha_renovacion))
     BEGIN
          SET @nuevo_estado = '4';
     -- Expirado
     END

     -- Actualizamos el estado del pago_tarifa para el registro específico.
     UPDATE pago_tarifa
     SET estado = @nuevo_estado
     WHERE id_pago_tarifa = @id_pago_tarifa;

     -- Finalmente, se actualiza el estado de la empresa en función de sus suscripciones.
     EXEC sp_actualizar_estado_empresa_by_id @id_empresa = @id_empresa;
END;
GO
