USE [FoodAppApi_db]
GO

/****** Object:  StoredProcedure [dbo].[CheckIfFirstPurchase]    Script Date: 8/5/2023 5:07:36 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[CheckIfFirstPurchase]
	@RefereeId varchar(255)
AS
BEGIN
	SELECT COUNT(*) from dbo.[Order] where RefereeId = @RefereeId and [Status] = 'Delivered'
END



GO

