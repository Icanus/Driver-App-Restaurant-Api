USE [FoodAppApi_db]
GO

/****** Object:  StoredProcedure [dbo].[InsertFavorite]    Script Date: 7/26/2023 12:39:55 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[InsertFavorite]
		@FavoriteId varchar(255), 
		@CustomerId varchar(255), 
        @ItemId varchar(255)
AS
BEGIN
    BEGIN TRY
        BEGIN TRANSACTION

        insert into Favorite(CustomerId, ItemId, FavoriteId) values
		(@CustomerId, @ItemId, @FavoriteId)

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

