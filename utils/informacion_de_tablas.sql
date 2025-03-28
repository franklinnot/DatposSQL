
-- tablas de la base de datos
SELECT '''' + TABLE_NAME + '''' + ',' AS TABLE_NAME
FROM INFORMATION_SCHEMA.TABLES
ORDER BY TABLE_NAME;

-- columnas de una tabla
SELECT '''' + COLUMN_NAME + '''' + ',' AS COLUMN_NAME
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'sucursal';


-- tablas con la columna '--'
SELECT DISTINCT '''' + TABLE_NAME + ''''  + ',' AS TABLE_NAME
FROM INFORMATION_SCHEMA.COLUMNS
WHERE COLUMN_NAME = 'ciudad'
ORDER BY TABLE_NAME;


-- tablas con el FK '<insertar>'
SELECT DISTINCT '''' + kcu.TABLE_NAME + '''' + ','AS TABLE_NAME
FROM INFORMATION_SCHEMA.KEY_COLUMN_USAGE AS kcu
JOIN INFORMATION_SCHEMA.TABLE_CONSTRAINTS AS tc 
  ON kcu.CONSTRAINT_NAME = tc.CONSTRAINT_NAME
WHERE tc.CONSTRAINT_TYPE = 'FOREIGN KEY'
  AND kcu.COLUMN_NAME = 'id_almacen'
ORDER BY TABLE_NAME;


-- tablas que no tienen la columna '---'
SELECT TABLE_NAME
FROM (
    SELECT DISTINCT 
           '''' + t.TABLE_NAME + '''' + ',' AS TABLE_NAME,
           t.TABLE_NAME AS RawTableName
    FROM INFORMATION_SCHEMA.TABLES t
    WHERE t.TABLE_TYPE = 'BASE TABLE'
      AND t.TABLE_NAME NOT IN (
          SELECT DISTINCT TABLE_NAME
          FROM INFORMATION_SCHEMA.COLUMNS
          WHERE COLUMN_NAME = 'id_empresa'
      )
) AS sub
ORDER BY RawTableName;


