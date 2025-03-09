
-- ACCESO
select * from acceso;
insert into acceso (nombre, ruta, estado)
values 
-- Accesos que necesitan permiso para la cada ruta padre:

-- Dashboard
('Dashboard', 'dashboard', 1),

-- Perfil de Usuario
('Editar perfil de Usuario', 'profile/edit/info', 1),
('Cambiar contraseña', 'profile/edit/password', 1),

-- EMPRESA
('Ver información de la Empresa', 'business', 1),
('Editar información de la Empresa', 'business/edit', 1),
('Ver suscripciones de la Empresa', 'business/subscriptions', 1),

-- SUCURSALES
('Registrar nueva Sucursal', 'stores/new', 1),
('Ver Sucursales', 'stores', 1),
('Editar información de una Sucursal', 'stores/edit', 1),
('Eliminar una Sucursal', 'stores/delete', 1)

-------------------------------------------------------


-- EMPRESA
SELECT * FROM empresa;

INSERT INTO empresa 
(ruc, razon_social, nombre_comercial, email, telefono, ciudad, direccion, igv,
monto_maximo_boleta, numero_tributario, cantidad_sucursales, cantidad_usuarios,
-- logo,
facturacion_electronica, dias_plazo, estado)

values

('12345678', 
'Living S.A.C.',
'Living Group',
'living@corp.com',
'253-443',
'Trujillo',
'Av. Larco 552',
8.1,
120,
'NUM-TRIB-853',
5,
10,
--logo,
0,
3,
1);



-- PAGO_TARIFA
SELECT * FROM pago_tarifa;

INSERT INTO pago_tarifa 
(fecha_pago, fecha_inicio, fecha_renovacion, duracion_meses,
monto, estado, id_tipo_tarifa, id_empresa)
values
('2025-02-07', '2025-02-12', '2025-03-12',
2, 89.99, 1, 1, 1)



-- SUCURSAL
SELECT * FROM sucursal;

INSERT INTO sucursal 
(nombre, ciudad, direccion, telefono, estado, id_empresa)
values
('Sucursal principal',
'Trujillo',
'Av. Larco 512',
'213-443',
1,
1)



-- ALMACEN
SELECT * FROM almacen;
INSERT INTO almacen (codigo, nombre, estado, id_empresa)
values ('AL-000', 'Almacen Principal', 1, 1)




-- ROL
SELECT * FROM rol;

INSERT INTO rol (nombre, estado, id_empresa)
values 
('Administrador', 1, 1),
('Cajero', 1, 1),
('Almacenero', 1, 1)



-- ACCESO_ROL
SELECT * FROM acceso_rol;

INSERT INTO acceso_rol (id_rol, id_acceso, id_empresa)
values (1, 1, 1)



-- USUARIO
SELECT * FROM usuario;

insert into usuario
(email, password, created_at, nombre, estado, id_rol, id_sucursal, id_empresa)
values
('franklin@gmail.com',
'$2y$10$GpkNnnP3LIWUqScnWYMwfefAeFC42M7qYpbDZTyIYo8BdboT8wk1e',
GETDATE(),
'franklin',
1,
1,
1,
1)
