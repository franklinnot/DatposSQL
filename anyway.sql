


-- columnas de una tabla
SELECT  COLUMN_NAME AS columna
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'producto';