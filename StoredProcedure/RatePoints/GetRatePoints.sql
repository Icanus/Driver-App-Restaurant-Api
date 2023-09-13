USE [FoodAppApi_db]
GO

/****** Object:  StoredProcedure [dbo].[GetMaxOrderId]    Script Date: 8/1/2023 5:12:40 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[GetRatePoints]
AS
BEGIN
	SET NOCOUNT ON;
    SELECT * from RatePoints
END

GO


