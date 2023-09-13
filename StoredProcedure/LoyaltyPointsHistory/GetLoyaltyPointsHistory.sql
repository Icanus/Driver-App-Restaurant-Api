USE [FoodAppApi_db]
GO

/****** Object:  StoredProcedure [dbo].[GetLoyaltyPointsHistory]    Script Date: 8/3/2023 1:37:32 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO




CREATE PROCEDURE [dbo].[GetLoyaltyPointsHistory]
		@LoyaltyId varchar(255)
AS
BEGIN
    select * from LoyaltyPointsHistory where LoyaltyId=@LoyaltyId order by AddedDate Desc
END




GO


