USE [FoodAppApi_db]
GO

/****** Object:  StoredProcedure [dbo].[CheckForReferrals]    Script Date: 8/5/2023 5:00:49 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[CheckForReferrals]
	@RefereeId varchar(255)
AS
BEGIN
	SELECT COUNT(*) from dbo.Referrals where RefereeId = @RefereeId
END



GO

