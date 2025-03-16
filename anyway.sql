


select * from caja;

select * from almacen;

select * from rol;

select * from usuario;

select * from unidad_medida;

-- columnas de una tabla
SELECT '''' + COLUMN_NAME + '''' + ',' AS COLUMN_NAME
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'unidad_medida';

/*
Nueva unidad de medida
> rutaPadre: units
> subRuta: units/new

------------------

codigo
nombre

estado
id_empresa

*/
select * from acceso;
-- Ejecutar el procedimiento almacenado
DECLARE @ListaAccesos ud_accesos_rol;

-- Insertar datos en la variable tipo tabla
INSERT INTO @ListaAccesos
    (id_acceso)
VALUES
    (28),
    (29),
    (30),
    (31);

EXEC sp_registrar_accesos_rol @id_rol = 1, @id_empresa = 1, @accesos = @ListaAccesos;








