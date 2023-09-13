USE [FoodAppApi_db]
GO

/****** Object:  StoredProcedure [dbo].[UpdateCategory]    Script Date: 7/25/2023 8:36:43 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[UpdateCategory]
		@Id int, 
		@Name varchar(255), 
        @Image varchar(255)
AS
BEGIN
    BEGIN TRY
        BEGIN TRANSACTION

        update Category set Name=@Name, Image=@Image, UpdatedAt=CURRENT_TIMESTAMP
		where Id=@Id

        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;
        -- Add any data to a log if desired
        RETURN -1;
    END CATCH;

    RETURN 1;
END


GO

