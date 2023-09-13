GO

/****** Object:  StoredProcedure [dbo].[UpdateBanner]    Script Date: 7/25/2023 1:07:02 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[UpdateBanner]
		@Id int,  
        @Image varchar(255)
AS
BEGIN
    BEGIN TRY
        BEGIN TRANSACTION

        update Banner set [Image]=@Image, UpdatedAt=CURRENT_TIMESTAMP
		where Id=@Id

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

