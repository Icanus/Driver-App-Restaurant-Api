GO

/****** Object:  StoredProcedure [dbo].[InsertCustomer]    Script Date: 7/25/2023 1:08:50 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[InsertCustomer]
		@CustomerId varchar(255), 
        @FullName varchar(255), 
        @Username varchar(255), 
        @Email varchar(255), 
        @Password varchar(255), 
        @Phone varchar(255), 
        @DateOfBirth DATETIME, 
        @Gender varchar(10),
        @AccountPreferences varchar(255),
        @TermsAndCondition bit,
        @Image varchar(255)
AS
BEGIN
    BEGIN TRY
        BEGIN TRANSACTION

        insert into Customer(CustomerId, FullName, Username, Email, [Password], Phone, DateOfBirth,
		Gender, AccountPreferences, TermsAndCondition, [Image], CreatedAt) values
		(@CustomerId, @FullName, @Username, @Email, @Password, @Phone, @DateOfBirth, @Gender, @AccountPreferences
		, @TermsAndCondition, @Image, CURRENT_TIMESTAMP)

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

