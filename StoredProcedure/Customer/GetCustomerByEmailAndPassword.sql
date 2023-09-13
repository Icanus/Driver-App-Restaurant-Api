GO

/****** Object:  StoredProcedure [dbo].[GetCustomerByEmailAndPassword]    Script Date: 7/23/2023 9:12:03 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[GetCustomerByEmailAndPassword]
@Email varchar(255),
@Password varchar(255)
AS
BEGIN
	SET NOCOUNT ON;
	SELECT top 1 * from dbo.Customer where Email=@Email and [Password]=@Password
END

GO

