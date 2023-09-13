USE [FoodAppApi_db]
GO

/****** Object:  StoredProcedure [dbo].[GetLoyaltyPointsByCustomerId]    Script Date: 7/31/2023 5:43:29 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[GetLoyaltyPointsByCustomerId]
		@LoyaltyId varchar(255), 
        @CustomerId varchar(255)
AS
BEGIN
    select * from CustomerLoyaltyPoints where LoyaltyId=@LoyaltyId and CustomerId=@CustomerId
END



GO

