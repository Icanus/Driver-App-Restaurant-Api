USE [FoodAppApi_db]
GO

/****** Object:  StoredProcedure [dbo].[UpdateItem]    Script Date: 7/27/2023 7:48:39 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[UpdateItem]
		@ItemId varchar(255), 
        @Name varchar(255), 
        @Description varchar(255), 
        @Price float, 
        @IsPopular bit, 
        @IsFeatured bit, 
        @IsFavorite bit, 
        @Image varchar(255), 
        @CategoryId int,
        @OnSale bit,
        @IsDeleted bit
AS
BEGIN
    BEGIN TRY
        BEGIN TRANSACTION

        update Item set Name=@Name, [Description]=@Description, Price=@Price, IsPopular=@IsPopular, IsFeatured=@IsFeatured, IsFavorite=@IsFavorite,
		[Image]=@Image, CategoryId=@CategoryId, OnSale=@OnSale, IsDeleted=@IsDeleted, UpdatedAt=CURRENT_TIMESTAMP
		where ItemId=@ItemId

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

