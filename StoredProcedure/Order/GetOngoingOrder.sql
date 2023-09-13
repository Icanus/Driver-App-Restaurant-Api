USE [FoodAppApi_db]
GO

/****** Object:  StoredProcedure [dbo].[GetOngoingOrder]    Script Date: 7/27/2023 7:47:09 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[GetOngoingOrder]
 @CustomerId varchar(255)
AS
BEGIN
	SET NOCOUNT ON;
	select * from [Order] where CustomerId = @CustomerId and IsOngoingOrder=1
END



GO

