GO

/****** Object:  StoredProcedure [dbo].[UpdateCustomer]    Script Date: 7/25/2023 1:09:01 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[UpdateCustomer]
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

        update Customer set CustomerId=@CustomerId, FullName=@FullName, Username=@Username, Email=@Email, [Password]=@Password, Phone=@Phone, DateOfBirth=@DateOfBirth,
		Gender=@Gender, AccountPreferences=@AccountPreferences, TermsAndCondition=@TermsAndCondition, [Image]=@Image, UpdatedAt=CURRENT_TIMESTAMP
		where CustomerId=@CustomerId

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

