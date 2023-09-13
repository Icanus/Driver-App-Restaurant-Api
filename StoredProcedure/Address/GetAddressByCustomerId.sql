USE [FoodAppDB]
GO

/****** Object:  StoredProcedure [dbo].[GetAddressByCustomerId]    Script Date: 7/24/2023 5:59:42 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[GetAddressByCustomerId]
 @CustomerId varchar(255)
AS
BEGIN
	SET NOCOUNT ON;
	SELECT * from dbo.Address where CustomerId = @CustomerId and IsDeleted = 0
END

GO

