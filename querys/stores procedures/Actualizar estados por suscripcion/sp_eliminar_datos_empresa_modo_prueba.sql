

CREATE OR ALTER PROCEDURE sp_eliminar_datos_empresa_modo_prueba
    @id_empresa BIGINT
AS
BEGIN
    SET NOCOUNT ON;

    DELETE FROM anulacion         WHERE id_empresa = @id_empresa;
    DELETE FROM comprobante_pago  WHERE id_empresa = @id_empresa;
    DELETE FROM pago              WHERE id_empresa = @id_empresa;
    DELETE FROM detalle_venta     WHERE id_empresa = @id_empresa;
    DELETE FROM venta             WHERE id_empresa = @id_empresa;
    DELETE FROM retiro_dinero     WHERE id_empresa = @id_empresa;
    DELETE FROM turno_caja        WHERE id_empresa = @id_empresa;
    DELETE FROM producto_almacen  WHERE id_empresa = @id_empresa;
    DELETE FROM detalle_operacion WHERE id_empresa = @id_empresa;
    DELETE FROM operacion         WHERE id_empresa = @id_empresa;
END;
GO


GO

EXEC sp_eliminar_datos_empresa_modo_prueba @id_empresa = 1;
