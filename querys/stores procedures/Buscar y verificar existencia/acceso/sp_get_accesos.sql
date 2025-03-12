

CREATE OR ALTER PROCEDURE sp_get_accesos
AS
BEGIN
    SET NOCOUNT ON;
    SELECT a.id_acceso, a.nombre, a.ruta, a.estado
    FROM acceso a;
END;

-------------------------

EXEC sp_get_accesos;

SELECT * FROM acceso;
