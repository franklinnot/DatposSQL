


/*

Usuarios
> ruta: users

Campos necesarios para el registro:
> dni
> nombre
> email
> password
> foto ~ => Nuevo componente para cargar imagenes 
> id_rol => SelectInput
> id_empresa => Auth::user();

*/

select * from usuario;

-- columnas de una tabla
SELECT '''' + COLUMN_NAME + '''' + ',' AS COLUMN_NAME
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'usuario';



-- Ejecutar el procedimiento almacenado
DECLARE @ListaAccesos ud_accesos_rol;

-- Insertar datos en la variable tipo tabla
INSERT INTO @ListaAccesos
    (id_acceso)
VALUES
    (24),
    (25),
    (26),
    (27);

EXEC sp_registrar_accesos_rol @id_rol = 1, @id_empresa = 1, @accesos = @ListaAccesos;

-------------------------

-- accesos que un rol tiene
EXEC sp_get_accesos_by_id_rol @id_rol = 1;

-- accesos que un rol no tiene
SELECT ac.id_acceso, ac.nombre
FROM acceso ac
    LEFT JOIN acceso_rol ar ON ac.id_acceso = ar.id_acceso AND ar.id_rol = 1
WHERE ar.id_acceso IS NULL;














