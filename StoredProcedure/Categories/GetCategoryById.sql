GO

/****** Object:  StoredProcedure [dbo].[GetCategoryById]    Script Date: 7/24/2023 5:55:39 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[GetCategoryById]
 @Id int
AS
BEGIN
	SET NOCOUNT ON;
	SELECT * from dbo.Category where Id = @Id
END

GO

