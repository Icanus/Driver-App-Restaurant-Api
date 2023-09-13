USE [FoodAppApi_db]
GO

/****** Object:  StoredProcedure [dbo].[GetActiveCustomerLoyaltyPointsByCustomerId]    Script Date: 8/1/2023 1:59:40 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO





CREATE PROCEDURE [dbo].[GetActiveCustomerLoyaltyPointsByCustomerId]
		@CustomerId varchar(255)
AS
BEGIN
     select * from CustomerLoyaltyPoints where IsTerminated = 0 and CustomerId = @CustomerId  and CURRENT_TIMESTAMP <= ExpirationDate
END





GO

