USE [FoodAppApi_db]
GO

/****** Object:  StoredProcedure [dbo].[GetOrderDetails]    Script Date: 8/3/2023 8:41:10 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO




-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[GetOrderDetails]
 @CustomerId varchar(255),
 @OrderId varchar(255)
AS
BEGIN
	SET NOCOUNT ON;
	select * from [Order] where CustomerId = @CustomerId and IsOngoingOrder=0 and OrderId = @OrderId
END




GO

