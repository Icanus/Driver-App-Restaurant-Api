USE [FoodAppApi_db]
GO

/****** Object:  StoredProcedure [dbo].[GetOrderItemByOrderId]    Script Date: 7/27/2023 9:14:57 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[GetOrderItemByOrderId]
	@OrderId varchar
AS
BEGIN
	SET NOCOUNT ON;
	SELECT * from dbo.OrderItem where OrderId = @OrderId
END



GO

