USE [FoodAppApi_db]
GO

/****** Object:  StoredProcedure [dbo].[GetItems]    Script Date: 7/27/2023 7:48:54 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[GetItems]
AS
BEGIN
	SET NOCOUNT ON;
	SELECT * from dbo.Item
END


GO

