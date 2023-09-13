USE [FoodAppApi_db]
GO

/****** Object:  StoredProcedure [dbo].[SubtractCustomerLoyaltyPoints]    Script Date: 8/2/2023 6:01:58 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO





CREATE PROCEDURE [dbo].[SubtractCustomerLoyaltyPoints]
		@LoyaltyId varchar(255), 
        @CustomerId varchar(255), 
        @Balance decimal(11,2)
AS
BEGIN
    BEGIN TRY
        BEGIN TRANSACTION

        update CustomerLoyaltyPoints set Balance = Balance - @Balance, UpdatedAt=CURRENT_TIMESTAMP 
		where CustomerId = @CustomerId and LoyaltyId = @LoyaltyId

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

