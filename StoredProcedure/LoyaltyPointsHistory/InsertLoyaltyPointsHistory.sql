USE [FoodAppApi_db]
GO

/****** Object:  StoredProcedure [dbo].[InsertLoyaltyPointsHistory]    Script Date: 8/3/2023 7:27:25 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO





CREATE PROCEDURE [dbo].[InsertLoyaltyPointsHistory]
		@OrderId varchar(255),
		@LoyaltyId varchar(255),
		@TotalAmount decimal(11,2),
		@AddedBalance decimal(11,2),
		@AddedDate datetime,
		@TransferId varchar(255),
		@ActionType varchar(255),
		@Description varchar(255)
AS
BEGIN
    insert into LoyaltyPointsHistory(OrderId, LoyaltyId, TotalAmount, AddedBalance, AddedDate, TransferId, ActionType, [Description])
	values
	(@OrderId, @LoyaltyId, @TotalAmount, @AddedBalance, @AddedDate, @TransferId, @ActionType, @Description)
END





GO


