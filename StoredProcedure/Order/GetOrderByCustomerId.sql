USE [FoodAppApi_db]
GO

/****** Object:  StoredProcedure [dbo].[GetOrderByCustomerId]    Script Date: 7/27/2023 7:47:44 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[GetOrderByCustomerId]
 @CustomerId varchar(255)
AS
BEGIN
	SET NOCOUNT ON;
	select * from [Order] where CustomerId = @CustomerId
END



GO

