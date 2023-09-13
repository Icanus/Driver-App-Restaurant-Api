USE [FoodAppApi_db]
GO

/****** Object:  StoredProcedure [dbo].[GetFavoriteByCustomerId]    Script Date: 7/26/2023 12:32:38 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[GetFavoriteByCustomerId]
	@CustomerId varchar(255)
AS
BEGIN
	SET NOCOUNT ON;
	SELECT * from dbo.Favorite where CustomerId=@CustomerId
END


GO

