


CREATE OR ALTER PROCEDURE sp_actualizar_estado_empresa_by_id
    @id_empresa BIGINT
AS
BEGIN
    SET NOCOUNT ON;

    -- Tabla variable para capturar el estado anterior y el nuevo de la empresa.
    DECLARE @Changes TABLE (
         OldEstado CHAR(1),
         NewEstado CHAR(1)
    );

    -- Actualizamos el estado de la empresa de acuerdo a la prioridad:
    -- 1. Activo (1): Tiene al menos un pago en estado 1.
    -- 2. Pendiente de pago (2): No tiene pagos activos pero s� uno en periodo de gracia (estado 2).
    -- 3. Modo prueba (3): No tiene pagos en estado 1 ni 2, pero s� tiene uno en estado 3.
    -- 4. Inhabilitado (0): No cumple ninguna de las condiciones anteriores.
    UPDATE e
    SET estado = CASE
        WHEN EXISTS (
            SELECT 1 
            FROM pago_tarifa p 
            WHERE p.id_empresa = e.id_empresa 
              AND p.estado = '1'
        ) THEN '1'

        WHEN EXISTS (
            SELECT 1 
            FROM pago_tarifa p 
            WHERE p.id_empresa = e.id_empresa 
              AND p.estado = '2'
        ) THEN '2'

        WHEN EXISTS (
            SELECT 1 
            FROM pago_tarifa p 
            WHERE p.id_empresa = e.id_empresa 
              AND p.estado = '3'
			  AND e.estado = '3' -- La empresa debe estar ya en modo prueba para porque quedarse en este estado
        ) THEN '3'

        ELSE '0'
    END
    OUTPUT deleted.estado, inserted.estado 
           INTO @Changes(OldEstado, NewEstado)
    FROM empresa e
    WHERE e.id_empresa = @id_empresa;

    -- Obtenemos el estado anterior y el nuevo de la empresa.
    DECLARE @OldEstado CHAR(1), @NewEstado CHAR(1);
    SELECT TOP 1 @OldEstado = OldEstado, @NewEstado = NewEstado
    FROM @Changes;

    -- Si la empresa pasa de modo prueba (3) a otro estado, se elimina la data asociada.
    IF @OldEstado = '3' AND @NewEstado <> '3'
    BEGIN
         EXEC sp_eliminar_datos_empresa_modo_prueba @id_empresa = @id_empresa;
    END;
END;
GO
