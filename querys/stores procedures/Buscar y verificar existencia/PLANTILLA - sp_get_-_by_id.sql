

CREATE OR ALTER PROCEDURE sp_get_-_by_id
    @id_ BIGINT
AS
BEGIN
    SET NOCOUNT ON;
    
    SELECT 
        *
    FROM 
    WHERE id_ = @id_;
END;

EXEC sp_get_-_by_id @id_ = 1;