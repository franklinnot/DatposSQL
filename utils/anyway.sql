-- update empresa 
-- set cantidad_sucursales = 8;

-- update empresa 
-- set sucursales_registradas = 2;
-- update almacen
-- set 
-- departamento = 'La Libertad',
-- ciudad = 'Trujillo'
-- where id_almacen = 61;


/*
Roles
roles/new

nombre

id_empresa => jalar este dato de inertia

*/

select * from empresa;
select * from sucursal;
select * from caja;
select * from almacen;
select * from rol;

SELECT top 1 id_acceso FROM acceso_rol
where id_rol = 1 and id_empresa = 1;

select * from usuario;
select * from rol;
select * from acceso_rol;


-- accesos que un rol tiene
EXEC sp_get_accesos_by_id_rol @id_rol = 1;

-- accesos que un rol no tiene
SELECT ac.id_acceso, ac.nombre
FROM acceso ac
    LEFT JOIN acceso_rol ar ON ac.id_acceso = ar.id_acceso AND ar.id_rol = 1
WHERE ar.id_acceso IS NULL;

select * from acceso;