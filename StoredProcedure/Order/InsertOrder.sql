USE [FoodAppApi_db]
GO

/****** Object:  StoredProcedure [dbo].[InsertOrder]    Script Date: 8/5/2023 4:41:09 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO




ALTER PROCEDURE [dbo].[InsertOrder]
		@OrderId varchar(255), 
        @CustomerId varchar(255), 
        @DateGmt DATETIME, 
        @Address varchar(255), 
        @AddressTitle varchar(255), 
        @Shipping decimal(11,2), 
        @Total decimal(11,2), 
        @ModeOfPayment int, 
        @IsOngoingOrder bit,
        @Status varchar(255),
        @PlacedTime DATETIME,
        @ProcessingTime DATETIME,
        @OnTheWayTime DATETIME,
        @DeliveredTime DATETIME,
        @CanceledTime DATETIME,
		@GrandTotal decimal(11,2),
        @Lat varchar(255), 
        @Lon varchar(255),
        @RefereeId varchar(255)
AS
BEGIN
    BEGIN TRY
        BEGIN TRANSACTION

        insert into [Order](OrderId, CustomerId, DateGmt, [Address], AddressTitle,Shipping, Total, ModeOfPayment,
		IsOngoingOrder, [Status], PlacedTime, ProcessingTime,OnTheWayTime, DeliveredTime, CanceledTime, GrandTotal, Lat, Lon, RefereeId, CreatedAt) values
		(@OrderId, @CustomerId, @DateGmt, @Address, @AddressTitle, @Shipping, @Total, @ModeOfPayment, @IsOngoingOrder, @Status
		, @PlacedTime, @ProcessingTime,@OnTheWayTime, @DeliveredTime, @CanceledTime, @GrandTotal, @Lat, @Lon, @RefereeId, CURRENT_TIMESTAMP)

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


