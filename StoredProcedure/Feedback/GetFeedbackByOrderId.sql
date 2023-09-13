USE [FoodAppApi_db]
GO

/****** Object:  StoredProcedure [dbo].[GetFeedbackByOrderId]    Script Date: 7/27/2023 10:13:41 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO




-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[GetFeedbackByOrderId]
	@OrderId varchar(255)
AS
BEGIN
	select * from FeedBack where OrderId = @OrderId
END




GO

