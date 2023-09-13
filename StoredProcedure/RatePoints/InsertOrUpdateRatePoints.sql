USE [FoodAppApi_db]
GO

/****** Object:  StoredProcedure [dbo].[InsertBanner]    Script Date: 8/1/2023 5:14:38 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[InsertOrUpdateRatePoints]
        @RatePoints decimal(11,2)
AS
BEGIN
    BEGIN TRY
        BEGIN TRANSACTION
		DECLARE @totalCount Int
		SET @totalCount = (Select COUNT(*) From RatePoints)
		
		if(@totalCount>0)
			Update RatePoints set Rate = @RatePoints
		else
			insert into RatePoints(Rate) values(@RatePoints)
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


