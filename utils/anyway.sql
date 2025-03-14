


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

