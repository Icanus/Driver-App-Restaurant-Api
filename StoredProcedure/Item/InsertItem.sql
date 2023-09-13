USE [FoodAppApi_db]
GO

/****** Object:  StoredProcedure [dbo].[InsertItem]    Script Date: 7/26/2023 5:49:07 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[InsertItem]
		@ItemId varchar(255), 
        @Name varchar(255), 
        @Description varchar(255), 
        @Price float, 
        @RegularPrice float, 
        @IsPopular bit, 
        @IsFeatured bit, 
        @IsFavorite bit, 
        @Image varchar(255), 
        @CategoryId int,
        @OnSale bit
AS
BEGIN
    BEGIN TRY
        BEGIN TRANSACTION

        insert into Item(ItemId, Name, [Description], Price,RegularPrice, IsPopular, IsFeatured, IsFavorite,
		[Image], CategoryId, OnSale, CreatedAt) values
		(@ItemId, @Name, @Description, @Price, @RegularPrice, @IsPopular, @IsFeatured, @IsFavorite, @Image, @CategoryId
		, @OnSale, CURRENT_TIMESTAMP)

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


