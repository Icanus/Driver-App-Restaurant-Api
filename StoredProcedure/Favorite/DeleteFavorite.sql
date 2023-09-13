USE [FoodAppApi_db]
GO

/****** Object:  StoredProcedure [dbo].[DeleteFavorite]    Script Date: 7/26/2023 12:40:14 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[DeleteFavorite]
		@FavoriteId varchar(255)
AS
BEGIN
    BEGIN TRY
        BEGIN TRANSACTION

        Delete from Favorite where FavoriteId = @FavoriteId

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

