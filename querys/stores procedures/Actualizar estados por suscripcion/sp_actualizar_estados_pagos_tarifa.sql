

CREATE OR ALTER PROCEDURE sp_actualizar_estados_pagos_tarifa
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @fecha_actual DATE = CAST(GETDATE() AS DATE);

    UPDATE p
    SET estado = CASE 
         WHEN @fecha_actual < p.fecha_inicio THEN 3
         WHEN @fecha_actual >= p.fecha_inicio 
              AND @fecha_actual <= p.fecha_renovacion THEN 1
         WHEN @fecha_actual > p.fecha_renovacion 
              AND @fecha_actual <= DATEADD(DAY, e.dias_plazo, p.fecha_renovacion) THEN 2
         WHEN @fecha_actual > DATEADD(DAY, e.dias_plazo, p.fecha_renovacion) THEN 4
         ELSE p.estado  -- En caso de que no se cumpla alguna condición, se mantiene el estado actual.
    END
    FROM pago_tarifa p
    INNER JOIN empresa e ON e.id_empresa = p.id_empresa;
END;
GO
