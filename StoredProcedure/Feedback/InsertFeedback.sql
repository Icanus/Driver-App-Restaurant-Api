USE [FoodAppApi_db]
GO

/****** Object:  StoredProcedure [dbo].[InsertFeedback]    Script Date: 7/27/2023 10:17:47 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO




CREATE PROCEDURE [dbo].[InsertFeedback]
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

        insert into FeedBack(FeedbackId, CustomerId, OrderId, Rating, Comment, IsFeedBackAvailable, ActivityDate) 
		 values
		(@FeedbackId, @CustomerId, @OrderId, @Rating, @Comment, @IsFeedBackAvailable, CURRENT_TIMESTAMP)

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

