GO

/****** Object:  StoredProcedure [dbo].[GetCustomers]    Script Date: 7/23/2023 9:12:24 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[GetCustomers]
AS
BEGIN
	SET NOCOUNT ON;
	SELECT * from dbo.Customer
END

GO

