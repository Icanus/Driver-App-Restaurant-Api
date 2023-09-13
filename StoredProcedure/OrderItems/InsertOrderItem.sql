USE [FoodAppApi_db]
GO

/****** Object:  StoredProcedure [dbo].[InsertOrderItem]    Script Date: 7/27/2023 9:46:07 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO




CREATE PROCEDURE [dbo].[InsertOrderItem]
		@OrderId varchar(255), 
        @ProductId varchar(255), 
        @ProductName varchar(255), 
        @ProductImage varchar(255), 
        @ProductDescription varchar(255), 
        @UnitPrice decimal(11,2), 
        @Quantity int, 
        @IngredientString varchar(255),
        @ChoiceString varchar(255),
        @Total decimal(11,2)
AS
BEGIN
    BEGIN TRY
        BEGIN TRANSACTION

        insert into OrderItem (OrderId, ProductId, ProductName, ProductImage, ProductDescription, UnitPrice,
		Quantity, IngredientString, ChoiceString, Total) values(@OrderId, @ProductId,@ProductName ,@ProductImage ,
		@ProductDescription, @UnitPrice ,@Quantity ,@IngredientString ,@ChoiceString,@Total)

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

