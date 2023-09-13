USE [FoodAppApi_db]
GO

/****** Object:  StoredProcedure [dbo].[InsertOrder]    Script Date: 7/27/2023 10:14:26 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



ALTER PROCEDURE [dbo].[UpdateFeedback]
		@FeedbackId varchar(255), 
        @CustomerId varchar(255), 
        @OrderId varchar(255),
        @Rating decimal(11,2), 
        @Comment varchar(255),
        @IsFeedBackAvailable bit
AS
BEGIN
    BEGIN TRY
        BEGIN TRANSACTION

        update FeedBack set Rating=@Rating, 
		Comment=@Comment, IsFeedBackAvailable=@IsFeedBackAvailable, ActivityDate=CURRENT_TIMESTAMP
		where OrderId=@OrderId and FeedbackId=@FeedbackId

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


