



-- eliminar id de sucursal
select * from usuario;
select * from lista_precios;
select * from rol;
select * from sucursal;

select * from acceso;



EXEC sp_get_accesos_rol_by_id @id_rol = 1;



select * from acceso_rol;
INSERT INTO acceso_rol (id_rol, id_acceso, id_empresa)
values (1, 12, 1)


---------------
GO

DECLARE @ListaAccesos ud_accesos_rol;
-- Insertar datos en la variable tipo tabla
INSERT INTO @ListaAccesos (id_acceso) 
VALUES (4);

-- Ejecutar el procedimiento almacenado
EXEC sp_registrar_accesos_rol @id_rol = 1, @id_empresa = 1, @accesos = @ListaAccesos;



