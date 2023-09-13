USE [FoodAppApi_db]
GO

/****** Object:  StoredProcedure [dbo].[InsertCustomerLoyaltyPoints]    Script Date: 7/31/2023 5:55:00 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[InsertCustomerLoyaltyPoints]
		@LoyaltyId varchar(255), 
        @CustomerId varchar(255), 
        @Balance decimal(11,2), 
        @TermsAndAgreement bit, 
        @IsTerminated bit,
		@ExpirationDate datetime
AS
BEGIN
    BEGIN TRY
        BEGIN TRANSACTION

        insert into CustomerLoyaltyPoints(LoyaltyId, CustomerId, Balance, TermsAndAgreement, IsTerminated, ExpirationDate, CreatedAt) values
		(@LoyaltyId, @CustomerId, 0, @TermsAndAgreement, @IsTerminated, @ExpirationDate, CURRENT_TIMESTAMP)

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


