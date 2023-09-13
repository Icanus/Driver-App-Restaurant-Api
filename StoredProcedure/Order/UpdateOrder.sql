USE [FoodAppApi_db]
GO

/****** Object:  StoredProcedure [dbo].[UpdateOrder]    Script Date: 7/28/2023 12:59:14 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO




CREATE PROCEDURE [dbo].[UpdateOrder]
		@OrderId varchar(255), 
        @OrderStatus varchar(255)
AS
BEGIN
    BEGIN TRY
        BEGIN TRANSACTION
			if(@OrderStatus = 'Placed')
				update [Order] set PlacedTime = CURRENT_TIMESTAMP, [Status] = @OrderStatus, UpdatedAt = CURRENT_TIMESTAMP where OrderId = @OrderId
			if(@OrderStatus = 'Processing')
				update [Order] set ProcessingTime = CURRENT_TIMESTAMP, [Status] = @OrderStatus, UpdatedAt = CURRENT_TIMESTAMP where OrderId = @OrderId
			if(@OrderStatus = 'OnTheWay')
				update [Order] set OnTheWayTime = CURRENT_TIMESTAMP, [Status] = @OrderStatus, UpdatedAt = CURRENT_TIMESTAMP where OrderId = @OrderId
			if(@OrderStatus = 'Delivered')
				update [Order] set DeliveredTime = CURRENT_TIMESTAMP, [Status] = @OrderStatus, UpdatedAt = CURRENT_TIMESTAMP, IsOngoingOrder = 0 where OrderId = @OrderId
				update FeedBack set IsFeedBackAvailable = 1 where OrderId = @OrderId
			if(@OrderStatus = 'Cancelled')
				update [Order] set DeliveredTime = CURRENT_TIMESTAMP, [Status] = @OrderStatus, UpdatedAt = CURRENT_TIMESTAMP, IsOngoingOrder = 0 where OrderId = @OrderId
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


