USE [FoodAppApi_db]
GO

/****** Object:  StoredProcedure [dbo].[InsertCategory]    Script Date: 7/25/2023 8:36:30 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[InsertCategory]
		@Name varchar(255), 
        @Image varchar(255)
AS
BEGIN
    BEGIN TRY
        BEGIN TRANSACTION

        insert into Category(Name, [Image],CreatedAt) values
		(@Name, @Image,CURRENT_TIMESTAMP)

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

