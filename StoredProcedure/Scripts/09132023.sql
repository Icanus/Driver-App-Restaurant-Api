USE [FoodAppApi_db]
GO
/****** Object:  StoredProcedure [dbo].[AcceptAddressChange]    Script Date: 9/13/2023 8:12:57 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[AcceptAddressChange]
		@OrderId varchar(255),  
        @DriverId varchar(255)
AS
BEGIN
    BEGIN TRY
        BEGIN TRANSACTION

        update [Order] set IsChangeAddressAccepted=1, UpdatedAt=CURRENT_TIMESTAMP
		where OrderId=@OrderId and DriverId=@DriverId

        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;
        -- Add any data to a log if desired
        RETURN -1;
    END CATCH;

    RETURN 1;
END




GO
/****** Object:  StoredProcedure [dbo].[ArchiveOrder]    Script Date: 9/13/2023 8:12:57 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO





CREATE PROCEDURE [dbo].[ArchiveOrder]
		@Type varchar(10), 
        @OrderId varchar(255)
AS
BEGIN
    BEGIN TRY
        BEGIN TRANSACTION

		if(@Type = 'Customer')
			update [Order] set IsArchive=1 where OrderId = @OrderId
		if(@Type = 'Driver')
			update [Order] set IsDriverArchive=1 where OrderId = @OrderId

        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;
        -- Add any data to a log if desired
        RETURN -1;
    END CATCH;

    RETURN 1;
END







GO
/****** Object:  StoredProcedure [dbo].[CheckForReferrals]    Script Date: 9/13/2023 8:12:57 AM ******/
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
	@CustomerId varchar(255)
AS
BEGIN
	SELECT * from dbo.Referrals where RefereeId=@CustomerId
END






GO
/****** Object:  StoredProcedure [dbo].[CheckIfFirstPurchase]    Script Date: 9/13/2023 8:12:57 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO





-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[CheckIfFirstPurchase]
	@ReferrerId varchar(255),
	@CustomerId varchar(255)
AS
BEGIN
	SELECT COUNT(*) from dbo.[Order] where ReferrerId = @ReferrerId and CustomerId =@CustomerId and [Status] = 'Delivered'
END







GO
/****** Object:  StoredProcedure [dbo].[CheckIfFirstPurchaseV2]    Script Date: 9/13/2023 8:12:57 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[CheckIfFirstPurchaseV2]
	@CustomerId varchar(255)
AS
BEGIN
	SELECT COUNT(*) from dbo.[Order] where CustomerId =@CustomerId
END



GO
/****** Object:  StoredProcedure [dbo].[CheckIfReferralCodeExist]    Script Date: 9/13/2023 8:12:57 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO






-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[CheckIfReferralCodeExist]
	@ReferralCode varchar(255)
AS
BEGIN
	SELECT COUNT(*) from dbo.Customer where ReferralCode = @ReferralCode
END








GO
/****** Object:  StoredProcedure [dbo].[DeleteFavorite]    Script Date: 9/13/2023 8:12:57 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[DeleteFavorite]
		@FavoriteId varchar(255)
AS
BEGIN
    BEGIN TRY
        BEGIN TRANSACTION

        Delete from Favorite where FavoriteId = @FavoriteId

        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;
        -- Add any data to a log if desired
        RETURN -1;
    END CATCH;

    RETURN 1;
END





GO
/****** Object:  StoredProcedure [dbo].[GetActiveCustomerLoyaltyPointsByCustomerId]    Script Date: 9/13/2023 8:12:57 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




CREATE PROCEDURE [dbo].[GetActiveCustomerLoyaltyPointsByCustomerId]
		@CustomerId varchar(255)
AS
BEGIN
     select * from CustomerLoyaltyPoints where IsTerminated = 0 and CustomerId = @CustomerId  and CURRENT_TIMESTAMP <= ExpirationDate
END






GO
/****** Object:  StoredProcedure [dbo].[GetAddressByCustomerId]    Script Date: 9/13/2023 8:12:57 AM ******/
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
/****** Object:  StoredProcedure [dbo].[GetBanners]    Script Date: 9/13/2023 8:12:57 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[GetBanners]
AS
BEGIN
	SET NOCOUNT ON;
	SELECT * from dbo.Banner
END

GO
/****** Object:  StoredProcedure [dbo].[GetCategories]    Script Date: 9/13/2023 8:12:57 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[GetCategories]
AS
BEGIN
	SET NOCOUNT ON;
	SELECT * from dbo.Category
END



GO
/****** Object:  StoredProcedure [dbo].[GetCategoryById]    Script Date: 9/13/2023 8:12:57 AM ******/
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
/****** Object:  StoredProcedure [dbo].[GetClosedOrderss]    Script Date: 9/13/2023 8:12:57 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO







-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[GetClosedOrderss]
	@LastSyncId int
AS
BEGIN
	SET NOCOUNT ON;
	if(@LastSyncId = 0)
		select * from [Order] where IsOngoingOrder = 0 and ModeOfPayment != 3
	else
		select * from [Order] where IsOngoingOrder = 0 and ModeOfPayment != 3 and Id <= @LastSyncId
END









GO
/****** Object:  StoredProcedure [dbo].[GetCustomerByCustomerId]    Script Date: 9/13/2023 8:12:57 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[GetCustomerByCustomerId]
@CustomerId varchar(255)
AS
BEGIN
	SET NOCOUNT ON;
	SELECT * from dbo.Customer where CustomerId=@CustomerId
END





GO
/****** Object:  StoredProcedure [dbo].[GetCustomerByEmail]    Script Date: 9/13/2023 8:12:57 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[GetCustomerByEmail]
@Email varchar(255)
AS
BEGIN
	SET NOCOUNT ON;
	SELECT * from dbo.Customer where Email=@Email
END




GO
/****** Object:  StoredProcedure [dbo].[GetCustomerByEmailAndPassword]    Script Date: 9/13/2023 8:12:57 AM ******/
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
/****** Object:  StoredProcedure [dbo].[GetCustomers]    Script Date: 9/13/2023 8:12:57 AM ******/
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
/****** Object:  StoredProcedure [dbo].[GetDriver]    Script Date: 9/13/2023 8:12:57 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[GetDriver]
AS
BEGIN
	SET NOCOUNT ON;
	SELECT * from dbo.Driver
END




GO
/****** Object:  StoredProcedure [dbo].[GetDriverByEmail]    Script Date: 9/13/2023 8:12:57 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[GetDriverByEmail]
@Email varchar(255)
AS
BEGIN
	SET NOCOUNT ON;
	SELECT * from dbo.Driver where Email=@Email
END





GO
/****** Object:  StoredProcedure [dbo].[GetDriverByEmailAndPassword]    Script Date: 9/13/2023 8:12:57 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[GetDriverByEmailAndPassword]
@Email varchar(255),
@Password varchar(255)
AS
BEGIN
	SET NOCOUNT ON;
	SELECT top 1 * from dbo.Driver where Email=@Email and [Password]=@Password
END




GO
/****** Object:  StoredProcedure [dbo].[GetDriverDetails]    Script Date: 9/13/2023 8:12:57 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[GetDriverDetails]
@DriverId varchar(255)
AS
BEGIN
	SET NOCOUNT ON;
	SELECT 
	top 1
		*
  FROM [dbo].[Driver]
	where DriverId = @DriverId
END





GO
/****** Object:  StoredProcedure [dbo].[GetFavoriteByCustomerId]    Script Date: 9/13/2023 8:12:57 AM ******/
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
/****** Object:  StoredProcedure [dbo].[GetFeedbackByOrderId]    Script Date: 9/13/2023 8:12:57 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[GetFeedbackByOrderId]
	@OrderId varchar(255)
AS
BEGIN
	select * from FeedBack where OrderId = @OrderId
END





GO
/****** Object:  StoredProcedure [dbo].[GetItems]    Script Date: 9/13/2023 8:12:57 AM ******/
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
/****** Object:  StoredProcedure [dbo].[GetLoyaltyPointsByCustomerId]    Script Date: 9/13/2023 8:12:57 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[GetLoyaltyPointsByCustomerId]
		@LoyaltyId varchar(255), 
        @CustomerId varchar(255)
AS
BEGIN
    select * from CustomerLoyaltyPoints where LoyaltyId=@LoyaltyId and CustomerId=@CustomerId and CURRENT_TIMESTAMP <= ExpirationDate
END





GO
/****** Object:  StoredProcedure [dbo].[GetLoyaltyPointsHistory]    Script Date: 9/13/2023 8:12:57 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO





CREATE PROCEDURE [dbo].[GetLoyaltyPointsHistory]
		@LoyaltyId varchar(255)
AS
BEGIN
    select * from LoyaltyPointsHistory where LoyaltyId=@LoyaltyId order by Id Desc
END







GO
/****** Object:  StoredProcedure [dbo].[GetLoyaltyPointsHistoryByOrderId]    Script Date: 9/13/2023 8:12:57 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO






CREATE PROCEDURE [dbo].[GetLoyaltyPointsHistoryByOrderId]
		@OrderId varchar(255)
AS
BEGIN
    select * from LoyaltyPointsHistory where OrderId=@OrderId order by Id Desc
END








GO
/****** Object:  StoredProcedure [dbo].[GetMaxOrderId]    Script Date: 9/13/2023 8:12:57 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[GetMaxOrderId]
AS
BEGIN
	SET NOCOUNT ON;
    SELECT MAX(Id) FROM [Order]
END


GO
/****** Object:  StoredProcedure [dbo].[GetOngoingOrder]    Script Date: 9/13/2023 8:12:57 AM ******/
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
/****** Object:  StoredProcedure [dbo].[GetOngoingOrderByDriverId]    Script Date: 9/13/2023 8:12:57 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO





-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[GetOngoingOrderByDriverId]
 @DriverId varchar(255)
AS
BEGIN
	SET NOCOUNT ON;
	select * from [Order] where DriverId = @DriverId and IsOngoingOrder=1  order by DateGmt  asc
END







GO
/****** Object:  StoredProcedure [dbo].[GetOpenOrderss]    Script Date: 9/13/2023 8:12:57 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO






-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[GetOpenOrderss]
	@LastSyncId int
AS
BEGIN
	SET NOCOUNT ON;
	if(@LastSyncId = 0)
		select * from [Order] where IsOngoingOrder != 0 and DriverId is null and ModeOfPayment != 3
	else
		select * from [Order] where IsOngoingOrder != 0 and DriverId is null and ModeOfPayment != 3 and Id > @LastSyncId
END








GO
/****** Object:  StoredProcedure [dbo].[GetOrderByCustomerId]    Script Date: 9/13/2023 8:12:57 AM ******/
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
	select * from [Order] where CustomerId = @CustomerId order by CreatedAt desc
END





GO
/****** Object:  StoredProcedure [dbo].[GetOrderDetails]    Script Date: 9/13/2023 8:12:57 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[GetOrderDetails]
 @CustomerId varchar(255),
 @OrderId varchar(255)
AS
BEGIN
	SET NOCOUNT ON;
	select * from [Order] where CustomerId = @CustomerId and OrderId = @OrderId
END






GO
/****** Object:  StoredProcedure [dbo].[GetOrderDocs]    Script Date: 9/13/2023 8:12:57 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[GetOrderDocs]
	@OrderId varchar(255)
AS
BEGIN
	SET NOCOUNT ON;
	SELECT * from dbo.OrderDocuments where OrderId=@OrderId
END






GO
/****** Object:  StoredProcedure [dbo].[GetOrderItemByOrderId]    Script Date: 9/13/2023 8:12:57 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[GetOrderItemByOrderId]
	@OrderId varchar(255)
AS
BEGIN
	select * from OrderItem where OrderId = @OrderId
END





GO
/****** Object:  StoredProcedure [dbo].[GetOrdersByDriverId]    Script Date: 9/13/2023 8:12:57 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[GetOrdersByDriverId]
	@DriverId varchar(255)
AS
BEGIN
	SET NOCOUNT ON;
	select * from [Order] where DriverId = @DriverId
END





GO
/****** Object:  StoredProcedure [dbo].[GetRatePoints]    Script Date: 9/13/2023 8:12:57 AM ******/
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
/****** Object:  StoredProcedure [dbo].[GetReferralsByCustomerId]    Script Date: 9/13/2023 8:12:57 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[GetReferralsByCustomerId]
	@CustomerId varchar(255)
AS
BEGIN
	SET NOCOUNT ON;
	SELECT * from dbo.Referrals where ReferrerId=@CustomerId
END





GO
/****** Object:  StoredProcedure [dbo].[GetReferralsByOrderId]    Script Date: 9/13/2023 8:12:57 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[GetReferralsByOrderId]
 @OrderId varchar(255)
AS
BEGIN
	SET NOCOUNT ON;
	select * from [Referrals] where OrderId = @OrderId
END





GO
/****** Object:  StoredProcedure [dbo].[GetRewardsByCustomerId]    Script Date: 9/13/2023 8:12:57 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[GetRewardsByCustomerId]
	@ReferralId varchar(255)
AS
BEGIN
	SELECT * from dbo.ReferralRewards where ReferralId=@ReferralId and CURRENT_TIMESTAMP <= ExpirationDate
END






GO
/****** Object:  StoredProcedure [dbo].[GetRewardsHistory]    Script Date: 9/13/2023 8:12:57 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[GetRewardsHistory]
		@ReferralId varchar(255)
AS
BEGIN
    select * from ReferralRewardsHistory where ReferralId=@ReferralId order by Id Desc
END



GO
/****** Object:  StoredProcedure [dbo].[GetSMTP]    Script Date: 9/13/2023 8:12:57 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[GetSMTP]
 @Type varchar(255)
AS
BEGIN
	SET NOCOUNT ON;
	select * from [SMTPConfig] where [Type] = @Type
END






GO
/****** Object:  StoredProcedure [dbo].[GetVehicleByDriverId]    Script Date: 9/13/2023 8:12:57 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[GetVehicleByDriverId]
    @DriverId NVARCHAR(50)
AS
BEGIN
    SET NOCOUNT ON;

    SELECT * FROM Vehicle
    WHERE DriverId = @DriverId;
END;



GO
/****** Object:  StoredProcedure [dbo].[InsertAddress]    Script Date: 9/13/2023 8:12:57 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[InsertAddress]
		@AddressId varchar(255), 
		@CustomerId varchar(255), 
        @Title varchar(255),
        @PostCode varchar(255),
        @Address1 varchar(255),
        @State varchar(255),
        @Street varchar(255),
        @City varchar(255),
        @Country varchar(255),
        @Comment varchar(255),
        @Lon varchar(255),
        @Lat varchar(255),
        @IsDeleted int
AS
BEGIN
    BEGIN TRY
        BEGIN TRANSACTION

        insert into Address(AddressId, CustomerId, Title, PostCode,Address1 ,[State],Street, City, Country, Comment, Lon, Lat, IsDeleted, CreatedAt) values
		(@AddressId, @CustomerId, @Title, @PostCode,@Address1 ,@State,@Street, @City,@Country,@Comment,@Lon,@Lat,@IsDeleted, CURRENT_TIMESTAMP)

        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;
        -- Add any data to a log if desired
        RETURN -1;
    END CATCH;

    RETURN 1;
END



GO
/****** Object:  StoredProcedure [dbo].[InsertBanner]    Script Date: 9/13/2023 8:12:57 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[InsertBanner]
        @Image varchar(255)
AS
BEGIN
    BEGIN TRY
        BEGIN TRANSACTION

        insert into Banner([Image],CreatedAt) values
		(@Image,CURRENT_TIMESTAMP)

        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;
        -- Add any data to a log if desired
        RETURN -1;
    END CATCH;

    RETURN 1;
END



GO
/****** Object:  StoredProcedure [dbo].[InsertCategory]    Script Date: 9/13/2023 8:12:57 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[InsertCategory]
		@Name varchar(255), 
        @Image varchar(255)
AS
BEGIN
    BEGIN TRY
        BEGIN TRANSACTION

        insert into Category(Name, [Image],CreatedAt) values
		(@Name, @Image,CURRENT_TIMESTAMP)

        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;
        -- Add any data to a log if desired
        RETURN -1;
    END CATCH;

    RETURN 1;
END



GO
/****** Object:  StoredProcedure [dbo].[InsertCustomer]    Script Date: 9/13/2023 8:12:57 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[InsertCustomer]
		@CustomerId varchar(255), 
        @FullName varchar(255), 
        @Username varchar(255), 
        @Email varchar(255), 
        @Password varchar(255), 
        @Phone varchar(255), 
        @DateOfBirth DATETIME, 
        @Gender varchar(10),
        @AccountPreferences varchar(255),
        @TermsAndCondition bit,
        @Image varchar(255),
		@ReferralCode varchar(255),
		@CountryCode varchar(255),
		@Country varchar(255)
AS
BEGIN
    BEGIN TRY
        BEGIN TRANSACTION

        insert into Customer(CustomerId, FullName, Username, Email, [Password], Phone, DateOfBirth,
		Gender, AccountPreferences, TermsAndCondition, [Image],ReferralCode, CreatedAt, CountryCode, Country) values
		(@CustomerId, @FullName, @Username, @Email, @Password, @Phone, @DateOfBirth, @Gender, @AccountPreferences
		, @TermsAndCondition, @Image,@ReferralCode, CURRENT_TIMESTAMP, @CountryCode, @Country)

        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;
        -- Add any data to a log if desired
        RETURN -1;
    END CATCH;

    RETURN 1;
END





GO
/****** Object:  StoredProcedure [dbo].[InsertCustomerLoyaltyPoints]    Script Date: 9/13/2023 8:12:57 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[InsertCustomerLoyaltyPoints]
		@LoyaltyId varchar(255), 
        @CustomerId varchar(255), 
        @Balance decimal(11,2), 
        @TermsAndAgreement bit, 
        @IsTerminated bit,
		@ExpirationDate datetime
AS
BEGIN
    BEGIN TRY
        BEGIN TRANSACTION

        insert into CustomerLoyaltyPoints(LoyaltyId, CustomerId, Balance, TermsAndAgreement, IsTerminated, ExpirationDate, CreatedAt) values
		(@LoyaltyId, @CustomerId, 0, @TermsAndAgreement, @IsTerminated, @ExpirationDate, CURRENT_TIMESTAMP)

        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;
        -- Add any data to a log if desired
        RETURN -1;
    END CATCH;

    RETURN 1;
END





GO
/****** Object:  StoredProcedure [dbo].[InsertDriver]    Script Date: 9/13/2023 8:12:57 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




CREATE PROCEDURE [dbo].[InsertDriver]
		@DriverId varchar(255), 
        @FullName varchar(255), 
        @Username varchar(255), 
        @Email varchar(255), 
        @Password varchar(255), 
        @Phone varchar(255), 
        @DateOfBirth DATETIME, 
        @Gender varchar(10),
        @AccountPreferences varchar(255),
        @TermsAndCondition bit,
        @Image varchar(255),
		@ReferralCode varchar(255),
		@CountryCode varchar(255),
		@Country varchar(255)
AS
BEGIN
    BEGIN TRY
        BEGIN TRANSACTION

        insert into Driver(DriverId, FullName, Username, Email, [Password], Phone, DateOfBirth,
		Gender, AccountPreferences, TermsAndCondition, [Image],ReferralCode, CreatedAt, CountryCode, Country) values
		(@DriverId, @FullName, @Username, @Email, @Password, @Phone, @DateOfBirth, @Gender, @AccountPreferences
		, @TermsAndCondition, @Image,@ReferralCode, CURRENT_TIMESTAMP, @CountryCode, @Country)

        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;
        -- Add any data to a log if desired
        RETURN -1;
    END CATCH;

    RETURN 1;
END






GO
/****** Object:  StoredProcedure [dbo].[InsertFavorite]    Script Date: 9/13/2023 8:12:57 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[InsertFavorite]
		@FavoriteId varchar(255), 
		@CustomerId varchar(255), 
        @ItemId varchar(255)
AS
BEGIN
    BEGIN TRY
        BEGIN TRANSACTION

        insert into Favorite(CustomerId, ItemId, FavoriteId) values
		(@CustomerId, @ItemId, @FavoriteId)

        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;
        -- Add any data to a log if desired
        RETURN -1;
    END CATCH;

    RETURN 1;
END





GO
/****** Object:  StoredProcedure [dbo].[InsertFeedback]    Script Date: 9/13/2023 8:12:57 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[InsertFeedback]
		@FeedbackId varchar(255), 
        @CustomerId varchar(255), 
        @OrderId varchar(255),
        @Rating decimal(11,2), 
        @Comment varchar(255),
        @IsFeedBackAvailable bit
AS
BEGIN
    BEGIN TRY
        BEGIN TRANSACTION

        insert into FeedBack(FeedbackId, CustomerId, OrderId, Rating, Comment, IsFeedBackAvailable, ActivityDate) 
		 values
		(@FeedbackId, @CustomerId, @OrderId, @Rating, @Comment, @IsFeedBackAvailable, CURRENT_TIMESTAMP)

        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;
        -- Add any data to a log if desired
        RETURN -1;
    END CATCH;

    RETURN 1;
END





GO
/****** Object:  StoredProcedure [dbo].[InsertItem]    Script Date: 9/13/2023 8:12:57 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[InsertItem]
		@ItemId varchar(255), 
        @Name varchar(255), 
        @Description varchar(255), 
        @Price float, 
        @RegularPrice float, 
        @IsPopular bit, 
        @IsFeatured bit, 
        @IsFavorite bit, 
        @Image varchar(255), 
        @CategoryId int,
        @OnSale bit
AS
BEGIN
    BEGIN TRY
        BEGIN TRANSACTION

        insert into Item(ItemId, Name, [Description], Price,RegularPrice, IsPopular, IsFeatured, IsFavorite,
		[Image], CategoryId, OnSale, CreatedAt) values
		(@ItemId, @Name, @Description, @Price, @RegularPrice, @IsPopular, @IsFeatured, @IsFavorite, @Image, @CategoryId
		, @OnSale, CURRENT_TIMESTAMP)

        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;
        -- Add any data to a log if desired
        RETURN -1;
    END CATCH;

    RETURN 1;
END




GO
/****** Object:  StoredProcedure [dbo].[InsertLoyaltyPointsHistory]    Script Date: 9/13/2023 8:12:57 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO






CREATE PROCEDURE [dbo].[InsertLoyaltyPointsHistory]
		@OrderId varchar(255),
		@LoyaltyId varchar(255),
		@TotalAmount decimal(11,2),
		@AddedBalance decimal(11,2),
		@AddedDate datetime,
		@TransferId varchar(255),
		@ActionType varchar(255),
		@Description varchar(255),
		@ReferenceId int
AS
BEGIN
    insert into LoyaltyPointsHistory(OrderId, LoyaltyId, TotalAmount, AddedBalance, AddedDate, TransferId, ActionType, [Description], ReferenceId)
	values
	(@OrderId, @LoyaltyId, @TotalAmount, @AddedBalance, @AddedDate, @TransferId, @ActionType, @Description, @ReferenceId)
END








GO
/****** Object:  StoredProcedure [dbo].[InsertOrder]    Script Date: 9/13/2023 8:12:57 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO






CREATE PROCEDURE [dbo].[InsertOrder]
		@OrderId varchar(255), 
        @CustomerId varchar(255), 
        @DateGmt DATETIME, 
        @Address varchar(255), 
        @AddressTitle varchar(255), 
        @Shipping decimal(11,2), 
        @Discount decimal(11,2), 
        @Total decimal(11,2), 
        @ModeOfPayment int, 
        @IsOngoingOrder bit,
        @Status varchar(255),
        @PlacedTime DATETIME,
        @ProcessingTime DATETIME,
        @OnTheWayTime DATETIME,
        @DeliveredTime DATETIME,
        @CanceledTime DATETIME,
		@GrandTotal decimal(11,2),
        @Lat varchar(255), 
        @Lon varchar(255),
        @ReferrerId varchar(255)
AS
BEGIN
    BEGIN TRY
        BEGIN TRANSACTION

        insert into [Order](OrderId, CustomerId, DateGmt, [Address], AddressTitle,Shipping,Discount, Total, ModeOfPayment,
		IsOngoingOrder, [Status], PlacedTime, ProcessingTime,OnTheWayTime, DeliveredTime, CanceledTime, GrandTotal, Lat, Lon, ReferrerId, CreatedAt) values
		(@OrderId, @CustomerId, @DateGmt, @Address, @AddressTitle, @Shipping,@Discount, @Total, @ModeOfPayment, @IsOngoingOrder, @Status
		, @PlacedTime, @ProcessingTime,@OnTheWayTime, @DeliveredTime, @CanceledTime, @GrandTotal, @Lat, @Lon, @ReferrerId, CURRENT_TIMESTAMP)

        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;
        -- Add any data to a log if desired
        RETURN -1;
    END CATCH;

    RETURN 1;
END








GO
/****** Object:  StoredProcedure [dbo].[InsertOrderDocs]    Script Date: 9/13/2023 8:12:57 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[InsertOrderDocs]
        @OrderId varchar(255)
AS
BEGIN
    BEGIN TRY
        BEGIN TRANSACTION

        insert into OrderDocuments(OrderId) values
		(@OrderId)

        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;
        -- Add any data to a log if desired
        RETURN -1;
    END CATCH;

    RETURN 1;
END




GO
/****** Object:  StoredProcedure [dbo].[InsertOrderItem]    Script Date: 9/13/2023 8:12:57 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[InsertOrderItem]
		@OrderId varchar(255), 
        @ProductId varchar(255), 
        @ProductName varchar(255), 
        @ProductImage varchar(255), 
        @ProductDescription varchar(255), 
        @UnitPrice decimal(11,2), 
        @Quantity int, 
        @IngredientString varchar(255),
        @ChoiceString varchar(255),
        @Total decimal(11,2)
AS
BEGIN
    BEGIN TRY
        BEGIN TRANSACTION

        insert into OrderItem (OrderId, ProductId, ProductName, ProductImage, ProductDescription, UnitPrice,
		Quantity, IngredientString, ChoiceString, Total) values(@OrderId, @ProductId,@ProductName ,@ProductImage ,
		@ProductDescription, @UnitPrice ,@Quantity ,@IngredientString ,@ChoiceString,@Total)

        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;
        -- Add any data to a log if desired
        RETURN -1;
    END CATCH;

    RETURN 1;
END





GO
/****** Object:  StoredProcedure [dbo].[InsertOrUpdateRatePoints]    Script Date: 9/13/2023 8:12:57 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[InsertOrUpdateRatePoints]
        @RatePoints decimal(11,2)
AS
BEGIN
    BEGIN TRY
        BEGIN TRANSACTION
		DECLARE @totalCount Int
		SET @totalCount = (Select COUNT(*) From RatePoints)
		
		if(@totalCount>0)
			Update RatePoints set Rate = @RatePoints
		else
			insert into RatePoints(Rate) values(@RatePoints)
        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;
        -- Add any data to a log if desired
        RETURN -1;
    END CATCH;

    RETURN 1;
END




GO
/****** Object:  StoredProcedure [dbo].[InsertReferral]    Script Date: 9/13/2023 8:12:57 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




CREATE PROCEDURE [dbo].[InsertReferral]
		@ReferrerId varchar(255), 
		@RefereeId varchar(255), 
        @ReferrerEmail varchar(255), 
        @RefereeEmail varchar(255),
		@ReferralCode varchar(255),
		@Points decimal(11,2),
		@OrderId varchar(255),
		@ReferenceId varchar(255)
AS
BEGIN
    BEGIN TRY
        BEGIN TRANSACTION

        insert into Referrals(ReferrerId, RefereeId, ReferrerEmail, RefereeEmail, Points,ReferralCode, CreatedDate, OrderId, ReferenceId) values
		(@ReferrerId, @RefereeId, @ReferrerEmail, @RefereeEmail, @Points,@ReferralCode, CURRENT_TIMESTAMP, @OrderId, @ReferenceId)

        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;
        -- Add any data to a log if desired
        RETURN -1;
    END CATCH;

    RETURN 1;
END












GO
/****** Object:  StoredProcedure [dbo].[InsertReferralRewards]    Script Date: 9/13/2023 8:12:57 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO





CREATE PROCEDURE [dbo].[InsertReferralRewards]
		@ReferralId varchar(255)
AS
BEGIN
    BEGIN TRY
        BEGIN TRANSACTION
		DECLARE @currentDateTime DATETIME = GETDATE();
		DECLARE @endOfYearDateTime DATETIME;

		-- Calculate the end date and time of the current year
		SET @endOfYearDateTime = DATEADD(MILLISECOND, -3, DATEADD(SECOND, -1, DATEADD(YEAR, 1, DATEADD(YEAR, DATEDIFF(YEAR, 0, @currentDateTime), 0))));
        insert into ReferralRewards(ReferralId, Balance, IsTerminated, CreatedAt, ExpirationDate) values
		(@ReferralId, 0, 0, CURRENT_TIMESTAMP, @endOfYearDateTime)

        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;
        -- Add any data to a log if desired
        RETURN -1;
    END CATCH;

    RETURN 1;
END







GO
/****** Object:  StoredProcedure [dbo].[InsertRewardHistory]    Script Date: 9/13/2023 8:12:57 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[InsertRewardHistory]
		@ReferralId varchar(255),
		@ReferrerId varchar(255),
		@RefereeId varchar(255),
		@OrderId varchar(255),
		@ActionType varchar(255),
		@Description varchar(255),
		@AddedBalance decimal(11,2),
		@AddedDate datetime
AS
BEGIN
    insert into ReferralRewardsHistory(ReferralId, ReferrerId, RefereeId, OrderId, ActionType, [Description], AddedBalance, AddedDate)
	values
	(@ReferralId, @ReferrerId, @RefereeId, @OrderId, @ActionType, @Description, @AddedBalance, @AddedDate)
END




GO
/****** Object:  StoredProcedure [dbo].[SubtractCustomerLoyaltyPoints]    Script Date: 9/13/2023 8:12:57 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




CREATE PROCEDURE [dbo].[SubtractCustomerLoyaltyPoints]
		@LoyaltyId varchar(255), 
        @CustomerId varchar(255), 
        @Balance decimal(11,2)
AS
BEGIN
    BEGIN TRY
        BEGIN TRANSACTION

        update CustomerLoyaltyPoints set Balance = Balance - @Balance, UpdatedAt=CURRENT_TIMESTAMP 
		where CustomerId = @CustomerId and LoyaltyId = @LoyaltyId

        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;
        -- Add any data to a log if desired
        RETURN -1;
    END CATCH;

    RETURN 1;
END






GO
/****** Object:  StoredProcedure [dbo].[UpdateAddress]    Script Date: 9/13/2023 8:12:57 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[UpdateAddress]
        @AddressId varchar(255),
        @Title varchar(255),
        @PostCode varchar(255),
        @Address1 varchar(255),
        @State varchar(255),
        @Street varchar(255),
        @City varchar(255),
        @Country varchar(255),
        @Comment varchar(255),
        @Lon varchar(255),
        @Lat varchar(255),
        @IsDeleted int
AS
BEGIN
    BEGIN TRY
        BEGIN TRANSACTION

        update Address set Title=@Title, PostCode=@PostCode,Address1=@Address1 ,[State]=@State,
		Street=@Street, City=@City, Country=@Country, Comment=@Comment, Lon=@Lon, Lat=@Lat, IsDeleted=@IsDeleted, UpdatedAt=CURRENT_TIMESTAMP
		where AddressId=@AddressId and IsDeleted != 1

        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;
        -- Add any data to a log if desired
        RETURN -1;
    END CATCH;

    RETURN 1;
END



GO
/****** Object:  StoredProcedure [dbo].[UpdateBanner]    Script Date: 9/13/2023 8:12:57 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[UpdateBanner]
		@Id int,  
        @Image varchar(255)
AS
BEGIN
    BEGIN TRY
        BEGIN TRANSACTION

        update Banner set [Image]=@Image, UpdatedAt=CURRENT_TIMESTAMP
		where Id=@Id

        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;
        -- Add any data to a log if desired
        RETURN -1;
    END CATCH;

    RETURN 1;
END



GO
/****** Object:  StoredProcedure [dbo].[UpdateCategory]    Script Date: 9/13/2023 8:12:57 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[UpdateCategory]
		@Id int, 
		@Name varchar(255), 
        @Image varchar(255)
AS
BEGIN
    BEGIN TRY
        BEGIN TRANSACTION

        update Category set Name=@Name, Image=@Image, UpdatedAt=CURRENT_TIMESTAMP
		where Id=@Id

        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;
        -- Add any data to a log if desired
        RETURN -1;
    END CATCH;

    RETURN 1;
END



GO
/****** Object:  StoredProcedure [dbo].[UpdateCustomer]    Script Date: 9/13/2023 8:12:57 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[UpdateCustomer]
		@CustomerId varchar(255), 
        @FullName varchar(255), 
        @Username varchar(255), 
        @Email varchar(255), 
        @Password varchar(255), 
        @Phone varchar(255), 
        @DateOfBirth DATETIME, 
        @Gender varchar(10),
        @AccountPreferences varchar(255),
        @TermsAndCondition bit,
        @Image varchar(255),
		@CountryCode varchar(255),
		@Country varchar(255)
AS
BEGIN
    BEGIN TRY
        BEGIN TRANSACTION

        update Customer set CustomerId=@CustomerId, FullName=@FullName, Username=@Username, Email=@Email, [Password]=@Password, Phone=@Phone, DateOfBirth=@DateOfBirth,
		Gender=@Gender, AccountPreferences=@AccountPreferences, TermsAndCondition=@TermsAndCondition, [Image]=@Image, UpdatedAt=CURRENT_TIMESTAMP, CountryCode = @CountryCode,
		Country=@Country
		where CustomerId=@CustomerId

        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;
        -- Add any data to a log if desired
        RETURN -1;
    END CATCH;

    RETURN 1;
END




GO
/****** Object:  StoredProcedure [dbo].[UpdateCustomerLoyaltyPoints]    Script Date: 9/13/2023 8:12:57 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[UpdateCustomerLoyaltyPoints]
		@LoyaltyId varchar(255), 
        @CustomerId varchar(255), 
        @Balance decimal(11,2)
AS
BEGIN
    BEGIN TRY
        BEGIN TRANSACTION

        update CustomerLoyaltyPoints set Balance = Balance + @Balance, UpdatedAt=CURRENT_TIMESTAMP 
		where CustomerId = @CustomerId and LoyaltyId = @LoyaltyId

        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;
        -- Add any data to a log if desired
        RETURN -1;
    END CATCH;

    RETURN 1;
END





GO
/****** Object:  StoredProcedure [dbo].[UpdateDriver]    Script Date: 9/13/2023 8:12:57 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[UpdateDriver]
		@DriverId varchar(255), 
        @FullName varchar(255), 
        @Username varchar(255), 
        @Email varchar(255), 
        @Password varchar(255), 
        @Phone varchar(255), 
        @DateOfBirth DATETIME, 
        @Gender varchar(10),
        @AccountPreferences varchar(255),
        @TermsAndCondition bit,
        @Image varchar(255),
		@CountryCode varchar(255),
		@Country varchar(255)
AS
BEGIN
    BEGIN TRY
        BEGIN TRANSACTION

        update Driver set FullName=@FullName, Username=@Username, Email=@Email, [Password]=@Password, Phone=@Phone, DateOfBirth=@DateOfBirth,
		Gender=@Gender, AccountPreferences=@AccountPreferences, TermsAndCondition=@TermsAndCondition, [Image]=@Image, UpdatedAt=CURRENT_TIMESTAMP, CountryCode = @CountryCode,
		Country=@Country
		where DriverId=@DriverId

        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;
        -- Add any data to a log if desired
        RETURN -1;
    END CATCH;

    RETURN 1;
END





GO
/****** Object:  StoredProcedure [dbo].[UpdateFeedback]    Script Date: 9/13/2023 8:12:57 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[UpdateFeedback]
		@FeedbackId varchar(255), 
        @CustomerId varchar(255), 
        @OrderId varchar(255),
        @Rating decimal(11,2), 
        @Comment varchar(255),
        @IsFeedBackAvailable bit
AS
BEGIN
    BEGIN TRY
        BEGIN TRANSACTION

        update FeedBack set Rating=@Rating, 
		Comment=@Comment, IsFeedBackAvailable=@IsFeedBackAvailable, ActivityDate=CURRENT_TIMESTAMP
		where OrderId=@OrderId and FeedbackId=@FeedbackId

        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;
        -- Add any data to a log if desired
        RETURN -1;
    END CATCH;

    RETURN 1;
END





GO
/****** Object:  StoredProcedure [dbo].[UpdateItem]    Script Date: 9/13/2023 8:12:57 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[UpdateItem]
		@ItemId varchar(255), 
        @Name varchar(255), 
        @Description varchar(255), 
        @Price float, 
        @IsPopular bit, 
        @IsFeatured bit, 
        @IsFavorite bit, 
        @Image varchar(255), 
        @CategoryId int,
        @OnSale bit,
        @IsDeleted bit
AS
BEGIN
    BEGIN TRY
        BEGIN TRANSACTION

        update Item set Name=@Name, [Description]=@Description, Price=@Price, IsPopular=@IsPopular, IsFeatured=@IsFeatured, IsFavorite=@IsFavorite,
		[Image]=@Image, CategoryId=@CategoryId, OnSale=@OnSale, IsDeleted=@IsDeleted, UpdatedAt=CURRENT_TIMESTAMP
		where ItemId=@ItemId

        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;
        -- Add any data to a log if desired
        RETURN -1;
    END CATCH;

    RETURN 1;
END



GO
/****** Object:  StoredProcedure [dbo].[UpdateOrder]    Script Date: 9/13/2023 8:12:57 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO





CREATE PROCEDURE [dbo].[UpdateOrder]
		@OrderId varchar(255), 
        @OrderStatus varchar(255)
AS
BEGIN
    BEGIN TRY
        BEGIN TRANSACTION
			if(@OrderStatus = 'Placed')
				update [Order] set PlacedTime = CURRENT_TIMESTAMP, [Status] = @OrderStatus, UpdatedAt = CURRENT_TIMESTAMP where OrderId = @OrderId
			if(@OrderStatus = 'Processing')
				update [Order] set ProcessingTime = CURRENT_TIMESTAMP, [Status] = @OrderStatus, UpdatedAt = CURRENT_TIMESTAMP where OrderId = @OrderId
			if(@OrderStatus = 'OnTheWay')
				update [Order] set OnTheWayTime = CURRENT_TIMESTAMP, [Status] = @OrderStatus, UpdatedAt = CURRENT_TIMESTAMP where OrderId = @OrderId
			if(@OrderStatus = 'ForPickUp')
				update [Order] set ForPickUpTime = CURRENT_TIMESTAMP, [Status] = @OrderStatus, UpdatedAt = CURRENT_TIMESTAMP where OrderId = @OrderId
			if(@OrderStatus = 'Delivered')
				update [Order] set DeliveredTime = CURRENT_TIMESTAMP, [Status] = @OrderStatus, UpdatedAt = CURRENT_TIMESTAMP, IsOngoingOrder = 0 where OrderId = @OrderId
				update FeedBack set IsFeedBackAvailable = 1 where OrderId = @OrderId
			if(@OrderStatus = 'Cancelled')
				update [Order] set DeliveredTime = CURRENT_TIMESTAMP, [Status] = @OrderStatus, UpdatedAt = CURRENT_TIMESTAMP, IsOngoingOrder = 0 where OrderId = @OrderId
        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;
        -- Add any data to a log if desired
        RETURN -1;
    END CATCH;

    RETURN 1;
END







GO
/****** Object:  StoredProcedure [dbo].[UpdateOrderAddressByOrderId]    Script Date: 9/13/2023 8:12:57 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO






CREATE PROCEDURE [dbo].[UpdateOrderAddressByOrderId]
		@OrderId varchar(255), 
		@ChangeAddress varchar(255),
		@ChangeAddressTitle varchar(255),
		@ChangeAddressLat varchar(255),
		@ChangeAddressLon varchar(255)
AS
BEGIN
    BEGIN TRY
        BEGIN TRANSACTION
				update [Order] set IsChangeAddress = 1, ChangeAddress = @ChangeAddress, ChangeAddressTitle = @ChangeAddressTitle,
				ChangeAddressLat = @ChangeAddressLat, ChangeAddressLon=@ChangeAddressLon,
				AdditionalFee = 10.00, GrandTotal = GrandTotal + 10.00, UpdatedAt = CURRENT_TIMESTAMP where OrderId = @OrderId
        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;
        -- Add any data to a log if desired
        RETURN -1;
    END CATCH;

    RETURN 1;
END








GO
/****** Object:  StoredProcedure [dbo].[UpdateOrderDocs]    Script Date: 9/13/2023 8:12:57 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO







CREATE PROCEDURE [dbo].[UpdateOrderDocs]
		@OrderId varchar(255), 
        @Type varchar(255),
		@Image TEXT,
		@Reason varchar(255)
AS
BEGIN
    BEGIN TRY
        BEGIN TRANSACTION
			if(@Type = 0)
				update [OrderDocuments] set OnTheWayImage = @Image, OnTheWayImageTime = CURRENT_TIMESTAMP where OrderId = @OrderId
			if(@Type = 1)
				update [OrderDocuments] set CancelledImage = @Image, CancelledImageTime = CURRENT_TIMESTAMP, CancelledReason=@Reason where OrderId = @OrderId
			if(@Type = 2)
				update [OrderDocuments] set DeliveredImage = @Image, DeliveredImageTime = CURRENT_TIMESTAMP where OrderId = @OrderId
        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;
        -- Add any data to a log if desired
        RETURN -1;
    END CATCH;

    RETURN 1;
END









GO
/****** Object:  StoredProcedure [dbo].[UpdateOrderSetDriverId]    Script Date: 9/13/2023 8:12:57 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO






CREATE PROCEDURE [dbo].[UpdateOrderSetDriverId]
		@OrderId varchar(255), 
        @DriverId varchar(255),
		@DriverLat varchar(255),
		@DriverLon varchar(255)
AS
BEGIN
    BEGIN TRY
        BEGIN TRANSACTION
				update [Order] set DriverId = @DriverId, DriverLat = @DriverLat, DriverLon=@DriverLon, UpdatedAt = CURRENT_TIMESTAMP where OrderId = @OrderId
        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;
        -- Add any data to a log if desired
        RETURN -1;
    END CATCH;

    RETURN 1;
END








GO
/****** Object:  StoredProcedure [dbo].[UpdateReferral]    Script Date: 9/13/2023 8:12:57 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[UpdateReferral]
		@RefereeEmail varchar(255),
        @RefereeId varchar(255)
AS
BEGIN
    BEGIN TRY
        BEGIN TRANSACTION

        update Referrals set RefereeId=@RefereeId
		where RefereeEmail=@RefereeEmail

        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;
        -- Add any data to a log if desired
        RETURN -1;
    END CATCH;

    RETURN 1;
END




GO
/****** Object:  StoredProcedure [dbo].[UpdateReferralBalance]    Script Date: 9/13/2023 8:12:57 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[UpdateReferralBalance]
        @RefereeId varchar(255),
        @ReferrerId varchar(255)
AS
BEGIN
    BEGIN TRY
        BEGIN TRANSACTION

        update Referrals set Points = 1
		where RefereeId=@RefereeId and ReferrerId=@ReferrerId

        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;
        -- Add any data to a log if desired
        RETURN -1;
    END CATCH;

    RETURN 1;
END





GO
/****** Object:  StoredProcedure [dbo].[UpdateRewards]    Script Date: 9/13/2023 8:12:57 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




CREATE PROCEDURE [dbo].[UpdateRewards]
		@ReferralId varchar(255), 
        @Balance decimal(11,2)
AS
BEGIN
    BEGIN TRY
        BEGIN TRANSACTION

        update ReferralRewards set Balance = Balance + @Balance, UpdatedAt=CURRENT_TIMESTAMP 
		where ReferralId = @ReferralId and IsTerminated = 0

        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;
        -- Add any data to a log if desired
        RETURN -1;
    END CATCH;

    RETURN 1;
END






GO
/****** Object:  StoredProcedure [dbo].[UpsertVehicle]    Script Date: 9/13/2023 8:12:57 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[UpsertVehicle]
    @DriverId NVARCHAR(50),
    @CarDescription NVARCHAR(100) = NULL,
    @CarRegistration NVARCHAR(20) = NULL,
    @DriversPhoto NVARCHAR(200) = NULL,
    @CarPhoto NVARCHAR(200) = NULL,
    @Result INT OUTPUT
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY
        -- Start the transaction
        BEGIN TRANSACTION;

        -- Check if the user exists in the Vehicle table
        IF EXISTS (SELECT 1 FROM Vehicle WHERE DriverId = @DriverId)
        BEGIN
            -- Update existing vehicle record
            UPDATE Vehicle
            SET
                CarDescription = COALESCE(@CarDescription, CarDescription),
                CarRegistration = COALESCE(@CarRegistration, CarRegistration),
                DriversPhoto = COALESCE(@DriversPhoto, DriversPhoto),
                CarPhoto = COALESCE(@CarPhoto, CarPhoto),
				UpdateAt = CURRENT_TIMESTAMP
            WHERE DriverId = @DriverId;

            SET @Result = 1; -- Success
        END
        ELSE
        BEGIN
            -- Insert new vehicle record
            INSERT INTO Vehicle (DriverId, CarDescription, CarRegistration, DriversPhoto, CarPhoto, CreatedAt)
            VALUES (@DriverId, @CarDescription, @CarRegistration, @DriversPhoto, @CarPhoto, CURRENT_TIMESTAMP);

            SET @Result = 1; -- Success
        END;

        -- Commit the transaction
        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        -- Rollback the transaction on error
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;

        SET @Result = -1; -- Error
    END CATCH;
END;







GO
/****** Object:  Table [dbo].[__EFMigrationsHistory]    Script Date: 9/13/2023 8:12:57 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[__EFMigrationsHistory](
	[MigrationId] [nvarchar](150) NOT NULL,
	[ProductVersion] [nvarchar](32) NOT NULL,
 CONSTRAINT [PK___EFMigrationsHistory] PRIMARY KEY CLUSTERED 
(
	[MigrationId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
)

GO
/****** Object:  Table [dbo].[Address]    Script Date: 9/13/2023 8:12:58 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Address](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[CustomerId] [nvarchar](max) NOT NULL,
	[Title] [nvarchar](max) NULL,
	[PostCode] [nvarchar](max) NULL,
	[Address1] [nvarchar](max) NOT NULL,
	[State] [nvarchar](max) NULL,
	[Street] [nvarchar](max) NULL,
	[City] [nvarchar](max) NOT NULL,
	[Country] [nvarchar](max) NULL,
	[Comment] [nvarchar](max) NOT NULL,
	[Lon] [nvarchar](max) NOT NULL,
	[Lat] [nvarchar](max) NOT NULL,
	[IsDeleted] [int] NOT NULL,
	[CreatedAt] [datetime2](7) NULL,
	[UpdatedAt] [datetime2](7) NULL,
	[AddressId] [nvarchar](max) NOT NULL DEFAULT (N''),
 CONSTRAINT [PK_Address] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
)

GO
/****** Object:  Table [dbo].[Banner]    Script Date: 9/13/2023 8:12:58 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Banner](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Image] [nvarchar](max) NOT NULL,
	[CreatedAt] [datetime2](7) NULL,
	[UpdatedAt] [datetime2](7) NULL,
 CONSTRAINT [PK_Banner] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
)

GO
/****** Object:  Table [dbo].[Category]    Script Date: 9/13/2023 8:12:59 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Category](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](max) NOT NULL,
	[Image] [nvarchar](max) NOT NULL,
	[CreatedAt] [datetime2](7) NULL,
	[UpdatedAt] [datetime2](7) NULL,
 CONSTRAINT [PK_Category] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
)

GO
/****** Object:  Table [dbo].[Customer]    Script Date: 9/13/2023 8:12:59 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Customer](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[CustomerId] [nvarchar](max) NOT NULL,
	[FullName] [nvarchar](max) NOT NULL,
	[Username] [nvarchar](max) NOT NULL,
	[Email] [nvarchar](max) NOT NULL,
	[Password] [nvarchar](255) NULL,
	[Phone] [nvarchar](255) NULL,
	[DateOfBirth] [datetime2](7) NOT NULL,
	[Gender] [nvarchar](255) NULL,
	[AccountPreferences] [nvarchar](255) NULL,
	[TermsAndCondition] [bit] NOT NULL,
	[Image] [nvarchar](255) NULL,
	[CreatedAt] [datetime2](7) NULL,
	[UpdatedAt] [datetime2](7) NULL,
	[ReferralCode] [nvarchar](255) NOT NULL DEFAULT (N''),
	[Country] [nvarchar](255) NULL,
	[CountryCode] [nvarchar](255) NULL,
 CONSTRAINT [PK_Customer] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
)

GO
/****** Object:  Table [dbo].[CustomerLoyaltyPoints]    Script Date: 9/13/2023 8:13:00 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CustomerLoyaltyPoints](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[LoyaltyId] [nvarchar](255) NULL,
	[CustomerId] [nvarchar](255) NOT NULL,
	[Balance] [float] NOT NULL,
	[ExpirationDate] [datetime2](7) NULL,
	[TermsAndAgreement] [bit] NOT NULL,
	[IsTerminated] [bit] NULL,
	[CreatedAt] [datetime2](7) NULL,
	[UpdatedAt] [datetime2](7) NULL,
 CONSTRAINT [PK_CustomerLoyaltyPoints] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
)

GO
/****** Object:  Table [dbo].[Driver]    Script Date: 9/13/2023 8:13:00 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Driver](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[DriverId] [nvarchar](255) NOT NULL,
	[FullName] [nvarchar](255) NOT NULL,
	[ReferralCode] [nvarchar](255) NOT NULL,
	[Username] [nvarchar](255) NOT NULL,
	[Email] [nvarchar](255) NOT NULL,
	[CountryCode] [nvarchar](255) NULL,
	[Country] [nvarchar](255) NULL,
	[Phone] [nvarchar](255) NULL,
	[Password] [nvarchar](255) NULL,
	[DateOfBirth] [datetime2](7) NOT NULL,
	[Gender] [nvarchar](255) NULL,
	[AccountPreferences] [nvarchar](255) NULL,
	[TermsAndCondition] [bit] NOT NULL,
	[Image] [nvarchar](255) NULL,
	[CreatedAt] [datetime2](7) NULL,
	[UpdatedAt] [datetime2](7) NULL,
 CONSTRAINT [PK_Driver] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
)

GO
/****** Object:  Table [dbo].[Favorite]    Script Date: 9/13/2023 8:13:01 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Favorite](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[CustomerId] [nvarchar](255) NOT NULL,
	[ItemId] [nvarchar](255) NOT NULL,
	[FavoriteId] [nvarchar](255) NOT NULL DEFAULT (N''),
 CONSTRAINT [PK_Favorite] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
)

GO
/****** Object:  Table [dbo].[FeedBack]    Script Date: 9/13/2023 8:13:01 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FeedBack](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[FeedbackId] [nvarchar](255) NOT NULL,
	[CustomerId] [nvarchar](255) NOT NULL,
	[OrderId] [nvarchar](255) NOT NULL,
	[Rating] [float] NULL,
	[Comment] [nvarchar](255) NULL,
	[IsFeedBackAvailable] [bit] NOT NULL,
	[ActivityDate] [datetime2](7) NOT NULL,
 CONSTRAINT [PK_FeedBack] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
)

GO
/****** Object:  Table [dbo].[Item]    Script Date: 9/13/2023 8:13:02 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Item](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[ItemId] [nvarchar](255) NOT NULL,
	[Name] [nvarchar](255) NOT NULL,
	[Description] [nvarchar](255) NOT NULL,
	[Price] [real] NOT NULL,
	[RegularPrice] [real] NOT NULL,
	[IsPopular] [bit] NOT NULL,
	[IsFeatured] [bit] NOT NULL,
	[IsFavorite] [bit] NOT NULL,
	[Image] [nvarchar](255) NOT NULL,
	[CategoryId] [int] NOT NULL,
	[OnSale] [bit] NOT NULL,
	[CreatedAt] [datetime2](7) NULL,
	[UpdatedAt] [datetime2](7) NULL,
	[IsDeleted] [bit] NOT NULL DEFAULT (CONVERT([bit],(0))),
 CONSTRAINT [PK_Item] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
)

GO
/****** Object:  Table [dbo].[LoyaltyPointsHistory]    Script Date: 9/13/2023 8:13:02 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LoyaltyPointsHistory](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[LoyaltyId] [nvarchar](255) NOT NULL,
	[TotalAmount] [float] NOT NULL,
	[AddedBalance] [float] NOT NULL,
	[AddedDate] [datetime2](7) NOT NULL,
	[OrderId] [nvarchar](255) NULL,
	[ActionType] [nvarchar](255) NULL,
	[Description] [nvarchar](255) NULL,
	[TransferId] [nvarchar](255) NULL,
	[ReferenceId] [int] NULL,
 CONSTRAINT [PK_LoyaltyPointsHistory] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
)

GO
/****** Object:  Table [dbo].[Order]    Script Date: 9/13/2023 8:13:03 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Order](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[OrderId] [nvarchar](255) NOT NULL,
	[CustomerId] [nvarchar](255) NOT NULL,
	[DateGmt] [datetime2](7) NULL,
	[Address] [nvarchar](255) NOT NULL,
	[Shipping] [float] NOT NULL,
	[Total] [float] NOT NULL,
	[ModeOfPayment] [int] NOT NULL,
	[IsOngoingOrder] [bit] NOT NULL,
	[Status] [nvarchar](255) NOT NULL,
	[PlacedTime] [datetime2](7) NULL,
	[ProcessingTime] [datetime2](7) NULL,
	[OnTheWayTime] [datetime2](7) NULL,
	[DeliveredTime] [datetime2](7) NULL,
	[CanceledTime] [datetime2](7) NULL,
	[GrandTotal] [float] NOT NULL,
	[CreatedAt] [datetime2](7) NULL,
	[UpdatedAt] [datetime2](7) NULL,
	[Lat] [nvarchar](255) NOT NULL DEFAULT (N''),
	[Lon] [nvarchar](255) NOT NULL DEFAULT (N''),
	[AddressTitle] [nvarchar](255) NOT NULL DEFAULT (N''),
	[ReferrerId] [nvarchar](255) NULL,
	[ForPickUpTime] [datetime2](7) NULL,
	[Discount] [float] NOT NULL DEFAULT ((0.0000000000000000e+000)),
	[DriverId] [nvarchar](255) NULL,
	[DriverLat] [nvarchar](255) NULL,
	[DriverLon] [nvarchar](255) NULL,
	[AdditionalFee] [float] NULL,
	[ChangeAddress] [nvarchar](255) NULL,
	[ChangeAddressLat] [nvarchar](255) NULL,
	[ChangeAddressLon] [nvarchar](255) NULL,
	[ChangeAddressTitle] [nvarchar](255) NULL,
	[IsChangeAddress] [bit] NOT NULL DEFAULT (CONVERT([bit],(0))),
	[IsChangeAddressAccepted] [bit] NOT NULL DEFAULT (CONVERT([bit],(0))),
	[IsArchive] [bit] NOT NULL DEFAULT (CONVERT([bit],(0))),
	[IsDriverArchive] [bit] NOT NULL DEFAULT (CONVERT([bit],(0))),
 CONSTRAINT [PK_Order] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
)

GO
/****** Object:  Table [dbo].[OrderDocuments]    Script Date: 9/13/2023 8:13:03 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OrderDocuments](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[OrderId] [nvarchar](255) NOT NULL,
	[OnTheWayImage] [nvarchar](max) NULL,
	[OnTheWayImageTime] [datetime2](7) NULL,
	[DeliveredImage] [nvarchar](max) NULL,
	[DeliveredImageTime] [datetime2](7) NULL,
	[CancelledImage] [nvarchar](max) NULL,
	[CancelledImageTime] [datetime2](7) NULL,
	[CancelledReason] [nvarchar](255) NULL,
 CONSTRAINT [PK_OrderDocuments] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
)

GO
/****** Object:  Table [dbo].[OrderItem]    Script Date: 9/13/2023 8:13:04 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OrderItem](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[OrderId] [nvarchar](255) NOT NULL,
	[ProductId] [nvarchar](255) NOT NULL,
	[ProductName] [nvarchar](255) NOT NULL,
	[ProductImage] [nvarchar](255) NOT NULL,
	[ProductDescription] [nvarchar](255) NOT NULL,
	[UnitPrice] [real] NOT NULL,
	[Quantity] [int] NOT NULL,
	[IngredientString] [nvarchar](255) NOT NULL,
	[ChoiceString] [nvarchar](255) NOT NULL,
	[Total] [float] NOT NULL,
 CONSTRAINT [PK_OrderItem] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
)

GO
/****** Object:  Table [dbo].[RatePoints]    Script Date: 9/13/2023 8:13:04 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RatePoints](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Rate] [float] NOT NULL,
 CONSTRAINT [PK_RatePoints] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
)

GO
/****** Object:  Table [dbo].[ReferralRewards]    Script Date: 9/13/2023 8:13:05 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ReferralRewards](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[ReferralId] [nvarchar](255) NOT NULL,
	[Balance] [float] NOT NULL,
	[IsTerminated] [bit] NOT NULL,
	[CreatedAt] [datetime2](7) NULL,
	[UpdatedAt] [datetime2](7) NULL,
	[ExpirationDate] [datetime2](7) NULL,
 CONSTRAINT [PK_ReferralRewards] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
)

GO
/****** Object:  Table [dbo].[ReferralRewardsHistory]    Script Date: 9/13/2023 8:13:05 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ReferralRewardsHistory](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[ReferralId] [nvarchar](255) NOT NULL,
	[ReferrerId] [nvarchar](255) NOT NULL,
	[OrderId] [nvarchar](255) NULL,
	[ActionType] [nvarchar](255) NULL,
	[Description] [nvarchar](255) NULL,
	[AddedBalance] [float] NOT NULL,
	[AddedDate] [datetime2](7) NOT NULL,
	[RefereeId] [nvarchar](255) NOT NULL DEFAULT (N''),
	[ReferralCode] [nvarchar](255) NOT NULL DEFAULT (N''),
 CONSTRAINT [PK_ReferralRewardsHistory] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
)

GO
/****** Object:  Table [dbo].[Referrals]    Script Date: 9/13/2023 8:13:06 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Referrals](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[ReferrerId] [nvarchar](255) NULL,
	[RefereeId] [nvarchar](255) NULL,
	[Points] [float] NULL,
	[CreatedDate] [datetime2](7) NULL,
	[RefereeEmail] [nvarchar](255) NULL,
	[ReferrerEmail] [nvarchar](255) NULL,
	[ReferralCode] [nvarchar](255) NOT NULL DEFAULT (N''),
	[OrderId] [nvarchar](255) NULL,
	[ReferenceId] [nvarchar](255) NULL,
 CONSTRAINT [PK_Referrals] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
)

GO
/****** Object:  Table [dbo].[SMTPConfig]    Script Date: 9/13/2023 8:13:06 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SMTPConfig](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Type] [nvarchar](255) NOT NULL,
	[Email] [nvarchar](255) NULL,
	[Password] [nvarchar](255) NULL,
	[ApiKey] [nvarchar](max) NULL,
	[ApiSecret] [nvarchar](max) NULL,
 CONSTRAINT [PK_SMTPConfig] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
)

GO
/****** Object:  Table [dbo].[Vehicle]    Script Date: 9/13/2023 8:13:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Vehicle](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[DriverId] [nvarchar](255) NOT NULL,
	[CarDescription] [nvarchar](255) NULL,
	[CarRegistration] [nvarchar](255) NULL,
	[DriversPhoto] [nvarchar](255) NULL,
	[CarPhoto] [nvarchar](255) NULL,
	[CreatedAt] [datetime2](7) NOT NULL,
	[UpdateAt] [datetime2](7) NULL,
 CONSTRAINT [PK_Vehicle] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
)

GO
INSERT [dbo].[__EFMigrationsHistory] ([MigrationId], [ProductVersion]) VALUES (N'20230815093214_DriverMigration', N'7.0.9')
INSERT [dbo].[__EFMigrationsHistory] ([MigrationId], [ProductVersion]) VALUES (N'20230816063132_AddedDriverFieldsINOrderMigration', N'7.0.9')
INSERT [dbo].[__EFMigrationsHistory] ([MigrationId], [ProductVersion]) VALUES (N'20230816083141_AddOrderDocumentsMigration', N'7.0.9')
INSERT [dbo].[__EFMigrationsHistory] ([MigrationId], [ProductVersion]) VALUES (N'20230820223852_ChangeAddressMigation', N'7.0.9')
INSERT [dbo].[__EFMigrationsHistory] ([MigrationId], [ProductVersion]) VALUES (N'20230820225024_IsChangeAddressAcceptedMigration', N'7.0.9')
INSERT [dbo].[__EFMigrationsHistory] ([MigrationId], [ProductVersion]) VALUES (N'20230827091803_VehicleMigration', N'7.0.9')
INSERT [dbo].[__EFMigrationsHistory] ([MigrationId], [ProductVersion]) VALUES (N'20230911010238_AddedOrderArchive', N'7.0.9')
INSERT [dbo].[__EFMigrationsHistory] ([MigrationId], [ProductVersion]) VALUES (N'20230911011555_addeddriverarchive', N'7.0.9')
SET IDENTITY_INSERT [dbo].[Address] ON 

INSERT [dbo].[Address] ([Id], [CustomerId], [Title], [PostCode], [Address1], [State], [Street], [City], [Country], [Comment], [Lon], [Lat], [IsDeleted], [CreatedAt], [UpdatedAt], [AddressId]) VALUES (1, N'fa1ddca8-4ead-4799-ac9e-18ec51e72d8b', N'Home', N'', N'home', N'', N'', N'home', N'', N'home', N'-122.083918713033', N'37.4219460002308', 1, CAST(N'2023-08-16 07:35:18.2733333' AS DateTime2), CAST(N'2023-08-19 07:40:11.2866667' AS DateTime2), N'b4e4a2c8-57cf-4f0d-8247-dc4f3f8cb2a5')
INSERT [dbo].[Address] ([Id], [CustomerId], [Title], [PostCode], [Address1], [State], [Street], [City], [Country], [Comment], [Lon], [Lat], [IsDeleted], [CreatedAt], [UpdatedAt], [AddressId]) VALUES (3, N'fa1ddca8-4ead-4799-ac9e-18ec51e72d8b', N'School', N'', N'school', N'', N'', N'scholl', N'', N'school', N'-122.083923406899', N'37.4219404085556', 1, CAST(N'2023-08-16 09:10:13.3133333' AS DateTime2), CAST(N'2023-08-19 07:40:17.5300000' AS DateTime2), N'f6d760e8-a084-4823-a0cf-4c5622b834b0')
INSERT [dbo].[Address] ([Id], [CustomerId], [Title], [PostCode], [Address1], [State], [Street], [City], [Country], [Comment], [Lon], [Lat], [IsDeleted], [CreatedAt], [UpdatedAt], [AddressId]) VALUES (4, N'fa1ddca8-4ead-4799-ac9e-18ec51e72d8b', N'Others', N'', N'otherz 123123', N'', N'', N'otherz', N'', N'otherz', N'178.4594816342', N'-18.121447722234', 0, CAST(N'2023-08-19 07:31:51.5700000' AS DateTime2), CAST(N'2023-08-31 08:36:41.6300000' AS DateTime2), N'c307c573-1b0c-4d0f-9ea5-63c9b8310762')
INSERT [dbo].[Address] ([Id], [CustomerId], [Title], [PostCode], [Address1], [State], [Street], [City], [Country], [Comment], [Lon], [Lat], [IsDeleted], [CreatedAt], [UpdatedAt], [AddressId]) VALUES (5, N'fa1ddca8-4ead-4799-ac9e-18ec51e72d8b', N'Home', N'', N'blk 13 l21 wamee', N'', N'', N'geruda', N'', N'homex', N'178.462183959782', N'-18.1145046021085', 0, CAST(N'2023-08-19 07:41:19.0166667' AS DateTime2), CAST(N'2023-08-31 08:21:20.2466667' AS DateTime2), N'3b405ed7-e0c7-4aca-ac0c-ae81439bacf1')
INSERT [dbo].[Address] ([Id], [CustomerId], [Title], [PostCode], [Address1], [State], [Street], [City], [Country], [Comment], [Lon], [Lat], [IsDeleted], [CreatedAt], [UpdatedAt], [AddressId]) VALUES (6, N'5435f9ff-8096-401e-9178-fc1deab2a048', N'Others', N'', N'golf coure, ab 13', N'', N'', N'bacoor', N'', N'Bacoor', N'178.461611308157', N'-18.1237613971431', 0, CAST(N'2023-08-20 16:18:27.8000000' AS DateTime2), NULL, N'453d4738-fb78-4d37-bbbe-0eb55f1ab821')
INSERT [dbo].[Address] ([Id], [CustomerId], [Title], [PostCode], [Address1], [State], [Street], [City], [Country], [Comment], [Lon], [Lat], [IsDeleted], [CreatedAt], [UpdatedAt], [AddressId]) VALUES (7, N'e3a08713-3d80-40ef-a464-9a3983b5c4cd', N'School', N'', N'Laucala Bay Parish', N'', N'', N'Grantham Road', N'', N'Opposite Damodar City', N'178.447161577642', N'-18.1448749359278', 0, CAST(N'2023-08-20 17:32:25.8200000' AS DateTime2), CAST(N'2023-09-09 18:10:28.2433333' AS DateTime2), N'2bf62fce-5874-47e9-ae46-20bf5ab47202')
INSERT [dbo].[Address] ([Id], [CustomerId], [Title], [PostCode], [Address1], [State], [Street], [City], [Country], [Comment], [Lon], [Lat], [IsDeleted], [CreatedAt], [UpdatedAt], [AddressId]) VALUES (8, N'fa1ddca8-4ead-4799-ac9e-18ec51e72d8b', N'School', N'', N'blk 12 l22 halway', N'', N'', N'bermuda', N'', N'schoolx1', N'178.459092378616', N'-18.123392409309', 0, CAST(N'2023-08-21 00:19:48.0433333' AS DateTime2), CAST(N'2023-08-31 08:21:58.4033333' AS DateTime2), N'78e99d5d-95e0-4d3d-82db-f3f029bdcf92')
INSERT [dbo].[Address] ([Id], [CustomerId], [Title], [PostCode], [Address1], [State], [Street], [City], [Country], [Comment], [Lon], [Lat], [IsDeleted], [CreatedAt], [UpdatedAt], [AddressId]) VALUES (9, N'dfee830d-3cd1-4a3e-b928-9cc04acd2192', N'Work', N'', N'kalabu tax free zone', N'', N'', N'suva', N'', N'ktfz', N'178.482055440545', N'-18.0908527831406', 0, CAST(N'2023-08-22 18:43:48.3733333' AS DateTime2), CAST(N'2023-08-25 10:35:08.6500000' AS DateTime2), N'67edc4f4-4f01-469e-b227-e264a073e03a')
INSERT [dbo].[Address] ([Id], [CustomerId], [Title], [PostCode], [Address1], [State], [Street], [City], [Country], [Comment], [Lon], [Lat], [IsDeleted], [CreatedAt], [UpdatedAt], [AddressId]) VALUES (10, N'dfee830d-3cd1-4a3e-b928-9cc04acd2192', N'Home', N'', N'Sevuka place', N'', N'', N'Suva', N'', N'left house', N'178.482055440545', N'-18.0908527831406', 0, CAST(N'2023-08-22 18:46:44.6800000' AS DateTime2), CAST(N'2023-08-25 10:27:05.3300000' AS DateTime2), N'a5de66f7-cace-4810-9d80-5dc16c259eed')
INSERT [dbo].[Address] ([Id], [CustomerId], [Title], [PostCode], [Address1], [State], [Street], [City], [Country], [Comment], [Lon], [Lat], [IsDeleted], [CreatedAt], [UpdatedAt], [AddressId]) VALUES (11, N'dfee830d-3cd1-4a3e-b928-9cc04acd2192', N'Others', N'', N'Statham campus', N'', N'', N'suva', N'', N'in the city', N'178.482055440545', N'-18.0908527831406', 0, CAST(N'2023-08-24 19:36:00.8433333' AS DateTime2), CAST(N'2023-08-25 10:36:17.2300000' AS DateTime2), N'e168477f-bef5-49b4-b5db-dfb77623b7bc')
INSERT [dbo].[Address] ([Id], [CustomerId], [Title], [PostCode], [Address1], [State], [Street], [City], [Country], [Comment], [Lon], [Lat], [IsDeleted], [CreatedAt], [UpdatedAt], [AddressId]) VALUES (12, N'dfee830d-3cd1-4a3e-b928-9cc04acd2192', N'School', N'', N'Kids School', N'', N'', N'city', N'', N'Primary', N'178.436988964677', N'-18.1455035396092', 0, CAST(N'2023-08-24 19:52:15.2933333' AS DateTime2), CAST(N'2023-08-27 00:33:16.8400000' AS DateTime2), N'cae56a9e-dbef-47ff-a398-afac3d62b3ca')
INSERT [dbo].[Address] ([Id], [CustomerId], [Title], [PostCode], [Address1], [State], [Street], [City], [Country], [Comment], [Lon], [Lat], [IsDeleted], [CreatedAt], [UpdatedAt], [AddressId]) VALUES (13, N'fa1ddca8-4ead-4799-ac9e-18ec51e72d8b', N'Work', N'', N'Work13321 111', N'', N'', N'triangle', N'', N'Wokr33', N'178.458646461368', N'-18.1234854529468', 0, CAST(N'2023-08-26 05:18:40.1300000' AS DateTime2), CAST(N'2023-08-31 08:37:06.2100000' AS DateTime2), N'222856b8-f739-4eec-861a-d87abaf3c8df')
INSERT [dbo].[Address] ([Id], [CustomerId], [Title], [PostCode], [Address1], [State], [Street], [City], [Country], [Comment], [Lon], [Lat], [IsDeleted], [CreatedAt], [UpdatedAt], [AddressId]) VALUES (14, N'805762d5-4f7d-4c1f-a5de-e15405ab73c1', N'Home', N'', N'home', N'', N'', N'home1', N'', N'home2', N'178.45091432333', N'-18.1308551804094', 0, CAST(N'2023-09-03 17:01:52.3866667' AS DateTime2), NULL, N'c87f732d-ff83-4f34-88a1-1a5af135143b')
INSERT [dbo].[Address] ([Id], [CustomerId], [Title], [PostCode], [Address1], [State], [Street], [City], [Country], [Comment], [Lon], [Lat], [IsDeleted], [CreatedAt], [UpdatedAt], [AddressId]) VALUES (15, N'e3a08713-3d80-40ef-a464-9a3983b5c4cd', N'Others', N'', N'Bright Little Ones', N'', N'', N'Muanikau, Suva', N'', N'Back if Usp', N'178.442704081535', N'-18.1553346962396', 0, CAST(N'2023-09-07 20:19:00.0533333' AS DateTime2), CAST(N'2023-09-09 18:10:49.6666667' AS DateTime2), N'91f08ca3-e3e9-4902-9b3d-5ca6b6454b94')
INSERT [dbo].[Address] ([Id], [CustomerId], [Title], [PostCode], [Address1], [State], [Street], [City], [Country], [Comment], [Lon], [Lat], [IsDeleted], [CreatedAt], [UpdatedAt], [AddressId]) VALUES (16, N'e3a08713-3d80-40ef-a464-9a3983b5c4cd', N'Work', N'', N'F8 KTFZ ', N'', N'', N'Kalabu, Nasinu,Suva', N'', N'Valelevu', N'178.482179157436', N'-18.0912546657236', 0, CAST(N'2023-09-10 18:25:38.1666667' AS DateTime2), NULL, N'a07aa124-d59d-4f5c-ba85-8875498eee57')
SET IDENTITY_INSERT [dbo].[Address] OFF
SET IDENTITY_INSERT [dbo].[Category] ON 

INSERT [dbo].[Category] ([Id], [Name], [Image], [CreatedAt], [UpdatedAt]) VALUES (1, N'Menu', N'cat_menu', NULL, NULL)
INSERT [dbo].[Category] ([Id], [Name], [Image], [CreatedAt], [UpdatedAt]) VALUES (2, N'Burger', N'cat_burger', NULL, NULL)
INSERT [dbo].[Category] ([Id], [Name], [Image], [CreatedAt], [UpdatedAt]) VALUES (3, N'Meat', N'cat_meat', NULL, NULL)
INSERT [dbo].[Category] ([Id], [Name], [Image], [CreatedAt], [UpdatedAt]) VALUES (4, N'Chicken', N'cat_chicken', NULL, NULL)
INSERT [dbo].[Category] ([Id], [Name], [Image], [CreatedAt], [UpdatedAt]) VALUES (5, N'Pasta', N'cat_pasta', NULL, NULL)
INSERT [dbo].[Category] ([Id], [Name], [Image], [CreatedAt], [UpdatedAt]) VALUES (6, N'Salad', N'cat_salad', NULL, NULL)
INSERT [dbo].[Category] ([Id], [Name], [Image], [CreatedAt], [UpdatedAt]) VALUES (7, N'Dessert', N'mi_supangle', NULL, NULL)
INSERT [dbo].[Category] ([Id], [Name], [Image], [CreatedAt], [UpdatedAt]) VALUES (8, N'Beverage', N'mi_cappucino', NULL, CAST(N'2023-07-25 12:35:46.1600000' AS DateTime2))
SET IDENTITY_INSERT [dbo].[Category] OFF
SET IDENTITY_INSERT [dbo].[Customer] ON 

INSERT [dbo].[Customer] ([Id], [CustomerId], [FullName], [Username], [Email], [Password], [Phone], [DateOfBirth], [Gender], [AccountPreferences], [TermsAndCondition], [Image], [CreatedAt], [UpdatedAt], [ReferralCode], [Country], [CountryCode]) VALUES (1, N'fa1ddca8-4ead-4799-ac9e-18ec51e72d8b', N'Jerbs', N'user-001', N'arciaga.clark00@gmail.com', N'Vmsi123!', N'9991231234', CAST(N'2023-07-25 07:53:40.4000000' AS DateTime2), N'Male', N'', 1, N'https://foodappblobstorage.blob.core.windows.net:443/images/74bbe870-b8fa-4743-8dc4-b4ac269a4ced.png', CAST(N'2023-08-15 09:07:57.2700000' AS DateTime2), CAST(N'2023-08-30 07:42:51.8766667' AS DateTime2), N'AAA000', N'Philippines', N'63')
INSERT [dbo].[Customer] ([Id], [CustomerId], [FullName], [Username], [Email], [Password], [Phone], [DateOfBirth], [Gender], [AccountPreferences], [TermsAndCondition], [Image], [CreatedAt], [UpdatedAt], [ReferralCode], [Country], [CountryCode]) VALUES (2, N'e3a08713-3d80-40ef-a464-9a3983b5c4cd', N'Icanus Tuiloma', N'user-001', N'icanus.tuiloma@gmail.com', N'', N'4681234', CAST(N'2023-07-25 07:53:40.4000000' AS DateTime2), N'Male', N'', 1, N'https://lh3.googleusercontent.com/a/AAcHTteM30v9OiskzxNB3ji4eslmxYsLRav1PBnN4-ns97_hpaj7', CAST(N'2023-08-20 13:43:41.8266667' AS DateTime2), CAST(N'2023-09-12 08:32:45.1166667' AS DateTime2), N'AAA001', N'Fiji', N'679')
INSERT [dbo].[Customer] ([Id], [CustomerId], [FullName], [Username], [Email], [Password], [Phone], [DateOfBirth], [Gender], [AccountPreferences], [TermsAndCondition], [Image], [CreatedAt], [UpdatedAt], [ReferralCode], [Country], [CountryCode]) VALUES (3, N'5435f9ff-8096-401e-9178-fc1deab2a048', N'baket na nga', N'user-001', N'baketnanga00@gmail.com', N'Vmsi123!', N'9991231234', CAST(N'2023-07-25 07:53:40.4000000' AS DateTime2), N'Male', N'', 1, N'https://foodappblobstorage.blob.core.windows.net:443/images/e15d766d-a773-4dc3-9ed5-a4ad1f012b02.png', CAST(N'2023-08-20 16:17:14.4533333' AS DateTime2), CAST(N'2023-08-30 09:26:00.4666667' AS DateTime2), N'AAA002', N'Fiji', N'679')
INSERT [dbo].[Customer] ([Id], [CustomerId], [FullName], [Username], [Email], [Password], [Phone], [DateOfBirth], [Gender], [AccountPreferences], [TermsAndCondition], [Image], [CreatedAt], [UpdatedAt], [ReferralCode], [Country], [CountryCode]) VALUES (4, N'dfee830d-3cd1-4a3e-b928-9cc04acd2192', N'systems trials', N'user-001', N'systems.trials@gmail.com', N'', N'', CAST(N'2023-07-25 07:53:40.4000000' AS DateTime2), N'Male', N'', 1, N'https://lh3.googleusercontent.com/a/AAcHTtcqTBFmE9SDQiaz3Q7S-gny09P0frS3RgKMdAl1TfenqQ', CAST(N'2023-08-22 18:40:02.6000000' AS DateTime2), CAST(N'2023-09-12 01:58:29.4033333' AS DateTime2), N'AAA003', N'Fiji', N'679')
INSERT [dbo].[Customer] ([Id], [CustomerId], [FullName], [Username], [Email], [Password], [Phone], [DateOfBirth], [Gender], [AccountPreferences], [TermsAndCondition], [Image], [CreatedAt], [UpdatedAt], [ReferralCode], [Country], [CountryCode]) VALUES (5, N'1140a116-9749-4c37-8f7f-af0a86e9f30a', N'Test Service', N'user-001', N'servicing.tests@gmail.com', N'', N'', CAST(N'2023-07-25 07:53:40.4000000' AS DateTime2), N'Male', N'', 1, N'https://lh3.googleusercontent.com/a/AAcHTtewXX44vufVWMzSJSt8HZJSRAw_hzNMSNAnnn6wJtl20A', CAST(N'2023-08-31 19:33:36.3300000' AS DateTime2), NULL, N'AAA004', N'Fiji', N'679')
INSERT [dbo].[Customer] ([Id], [CustomerId], [FullName], [Username], [Email], [Password], [Phone], [DateOfBirth], [Gender], [AccountPreferences], [TermsAndCondition], [Image], [CreatedAt], [UpdatedAt], [ReferralCode], [Country], [CountryCode]) VALUES (6, N'805762d5-4f7d-4c1f-a5de-e15405ab73c1', N'arlene cabrera', N'user-001', N'arlenecabrera151@gmail.com', N'', N'', CAST(N'2023-07-25 07:53:40.4000000' AS DateTime2), N'Male', N'', 1, N'https://autisticdating.net/imgs/profile-placeholder.jpg', CAST(N'2023-09-03 12:57:22.8666667' AS DateTime2), NULL, N'AAA005', N'Fiji', N'679')
INSERT [dbo].[Customer] ([Id], [CustomerId], [FullName], [Username], [Email], [Password], [Phone], [DateOfBirth], [Gender], [AccountPreferences], [TermsAndCondition], [Image], [CreatedAt], [UpdatedAt], [ReferralCode], [Country], [CountryCode]) VALUES (7, N'5efece17-7391-4371-9ec7-f191d5915e14', N'servicing platforms', N'user-001', N'servicing.platforms@gmail.com', N'', N'', CAST(N'2023-07-25 07:53:40.4000000' AS DateTime2), N'Male', N'', 1, N'https://lh3.googleusercontent.com/a/AAcHTtfps7zy7EsUZGg-F3RO1ynID9Cl4evsUIqfG-ImWwjlKg', CAST(N'2023-09-03 16:38:25.7900000' AS DateTime2), NULL, N'AAA006', N'Fiji', N'679')
SET IDENTITY_INSERT [dbo].[Customer] OFF
SET IDENTITY_INSERT [dbo].[CustomerLoyaltyPoints] ON 

INSERT [dbo].[CustomerLoyaltyPoints] ([Id], [LoyaltyId], [CustomerId], [Balance], [ExpirationDate], [TermsAndAgreement], [IsTerminated], [CreatedAt], [UpdatedAt]) VALUES (1, N'd3be322d-1725-4a4c-b569-96620925c516', N'dfee830d-3cd1-4a3e-b928-9cc04acd2192', 25, CAST(N'2024-01-01 00:00:00.0000000' AS DateTime2), 1, 0, CAST(N'2023-08-22 18:48:20.6133333' AS DateTime2), CAST(N'2023-09-10 20:43:57.1700000' AS DateTime2))
INSERT [dbo].[CustomerLoyaltyPoints] ([Id], [LoyaltyId], [CustomerId], [Balance], [ExpirationDate], [TermsAndAgreement], [IsTerminated], [CreatedAt], [UpdatedAt]) VALUES (2, N'b6004b32-fef2-4221-8025-d0af92411c29', N'fa1ddca8-4ead-4799-ac9e-18ec51e72d8b', 29.900000000000006, CAST(N'2024-01-01 00:00:00.0000000' AS DateTime2), 1, 0, CAST(N'2023-08-24 16:52:22.1900000' AS DateTime2), CAST(N'2023-09-11 07:05:34.4166667' AS DateTime2))
INSERT [dbo].[CustomerLoyaltyPoints] ([Id], [LoyaltyId], [CustomerId], [Balance], [ExpirationDate], [TermsAndAgreement], [IsTerminated], [CreatedAt], [UpdatedAt]) VALUES (3, N'2fcc631e-3c7b-481a-b370-30e88c32dce6', N'e3a08713-3d80-40ef-a464-9a3983b5c4cd', 7.9, CAST(N'2024-01-01 00:00:00.0000000' AS DateTime2), 1, 0, CAST(N'2023-08-26 06:40:03.2000000' AS DateTime2), CAST(N'2023-09-12 06:52:53.8700000' AS DateTime2))
SET IDENTITY_INSERT [dbo].[CustomerLoyaltyPoints] OFF
SET IDENTITY_INSERT [dbo].[Driver] ON 

INSERT [dbo].[Driver] ([Id], [DriverId], [FullName], [ReferralCode], [Username], [Email], [CountryCode], [Country], [Phone], [Password], [DateOfBirth], [Gender], [AccountPreferences], [TermsAndCondition], [Image], [CreatedAt], [UpdatedAt]) VALUES (1, N'c471f0bf-92e6-466d-a38a-8df5a88832ff', N'clark', N'', N'user-001', N'arciaga.clark00@gmail.com', N'679', N'Fiji', N'9999999999', N'Vmsi123!', CAST(N'2023-09-12 10:01:12.2700000' AS DateTime2), N'Male', N'', 1, N'jane_doe', CAST(N'2023-08-16 05:41:36.4133333' AS DateTime2), CAST(N'2023-09-12 10:02:28.9366667' AS DateTime2))
INSERT [dbo].[Driver] ([Id], [DriverId], [FullName], [ReferralCode], [Username], [Email], [CountryCode], [Country], [Phone], [Password], [DateOfBirth], [Gender], [AccountPreferences], [TermsAndCondition], [Image], [CreatedAt], [UpdatedAt]) VALUES (2, N'20d4a3a5-056e-4efe-ad36-4c913257a3bc', N'Driver 1', N'', N'user-001', N'systems.trials@gmail.com', N'679', N'Fiji', N'7993472', N'', CAST(N'2023-07-25 07:53:40.4000000' AS DateTime2), N'Female', N'', 1, N'jane_doe', CAST(N'2023-08-20 07:38:59.1400000' AS DateTime2), NULL)
INSERT [dbo].[Driver] ([Id], [DriverId], [FullName], [ReferralCode], [Username], [Email], [CountryCode], [Country], [Phone], [Password], [DateOfBirth], [Gender], [AccountPreferences], [TermsAndCondition], [Image], [CreatedAt], [UpdatedAt]) VALUES (3, N'b1df6432-282c-4e47-a16e-fa940c9c5f29', N'Driver 1', N'', N'user-001', N'servicing.tests@gmail.com', N'679', N'Fiji', N'7993472', N'', CAST(N'2023-07-25 07:53:40.4000000' AS DateTime2), N'Male', N'', 1, N'jane_doe', CAST(N'2023-08-22 18:18:18.0400000' AS DateTime2), NULL)
INSERT [dbo].[Driver] ([Id], [DriverId], [FullName], [ReferralCode], [Username], [Email], [CountryCode], [Country], [Phone], [Password], [DateOfBirth], [Gender], [AccountPreferences], [TermsAndCondition], [Image], [CreatedAt], [UpdatedAt]) VALUES (4, N'40140194-b9fd-488a-93cc-9b7a72c9ec59', N'saketnanga', N'', N'user-001', N'saketnanga00@gmail.com', N'679', N'Fiji', N'999131234', N'Vmsi123!', CAST(N'2023-07-25 07:53:40.4000000' AS DateTime2), N'Male', N'', 1, N'jane_doe', CAST(N'2023-08-28 10:33:31.7933333' AS DateTime2), NULL)
INSERT [dbo].[Driver] ([Id], [DriverId], [FullName], [ReferralCode], [Username], [Email], [CountryCode], [Country], [Phone], [Password], [DateOfBirth], [Gender], [AccountPreferences], [TermsAndCondition], [Image], [CreatedAt], [UpdatedAt]) VALUES (7, N'61ad3a8f-9cd4-4f4f-9f58-e2c4b2b8876d', N'arlene cabrera', N'', N'user-001', N'arlenecabrera151@gmail.com', N'679', N'Fiji', N'', N'', CAST(N'2023-07-25 07:53:40.4000000' AS DateTime2), N'Male', N'', 1, N'https://autisticdating.net/imgs/profile-placeholder.jpg', CAST(N'2023-09-03 10:23:49.8500000' AS DateTime2), NULL)
INSERT [dbo].[Driver] ([Id], [DriverId], [FullName], [ReferralCode], [Username], [Email], [CountryCode], [Country], [Phone], [Password], [DateOfBirth], [Gender], [AccountPreferences], [TermsAndCondition], [Image], [CreatedAt], [UpdatedAt]) VALUES (8, N'a2675838-a21f-44ae-876b-d50833d9bea4', N'servicing platforms', N'', N'user-001', N'servicing.platforms@gmail.com', N'679', N'Fiji', N'', N'', CAST(N'2023-07-25 07:53:40.4000000' AS DateTime2), N'Male', N'', 1, N'https://lh3.googleusercontent.com/a/AAcHTtfps7zy7EsUZGg-F3RO1ynID9Cl4evsUIqfG-ImWwjlKg', CAST(N'2023-09-03 15:44:44.5000000' AS DateTime2), NULL)
INSERT [dbo].[Driver] ([Id], [DriverId], [FullName], [ReferralCode], [Username], [Email], [CountryCode], [Country], [Phone], [Password], [DateOfBirth], [Gender], [AccountPreferences], [TermsAndCondition], [Image], [CreatedAt], [UpdatedAt]) VALUES (9, N'64fd52b0-106d-4bdf-a21a-2165d04cce48', N'felisha tuiloma', N'', N'user-001', N'felisha.tuiloma@gmail.com', N'679', N'Fiji', N'999999', N'', CAST(N'2023-07-25 07:53:40.4000000' AS DateTime2), N'Male', N'', 1, N'https://lh3.googleusercontent.com/a/AAcHTtdJJdQJyBTnchiBijSO9tMJ5MK4FLTZ9tR85OnETZejWL8', CAST(N'2023-09-07 20:09:05.1166667' AS DateTime2), CAST(N'2023-09-12 14:31:11.6700000' AS DateTime2))
INSERT [dbo].[Driver] ([Id], [DriverId], [FullName], [ReferralCode], [Username], [Email], [CountryCode], [Country], [Phone], [Password], [DateOfBirth], [Gender], [AccountPreferences], [TermsAndCondition], [Image], [CreatedAt], [UpdatedAt]) VALUES (10, N'f60ab9d5-f39e-421e-a967-42e000e55bf3', N'Gracelyn Tuiloma', N'', N'user-001', N'gracelyn.tuiloma@gmail.com', N'679', N'Fiji', N'', N'', CAST(N'2023-07-25 07:53:40.4000000' AS DateTime2), N'Male', N'', 1, N'https://autisticdating.net/imgs/profile-placeholder.jpg', CAST(N'2023-09-10 18:22:54.3800000' AS DateTime2), NULL)
SET IDENTITY_INSERT [dbo].[Driver] OFF
SET IDENTITY_INSERT [dbo].[FeedBack] ON 

INSERT [dbo].[FeedBack] ([Id], [FeedbackId], [CustomerId], [OrderId], [Rating], [Comment], [IsFeedBackAvailable], [ActivityDate]) VALUES (1, N'f5d772b1-fec8-48ea-820d-a54de7357aa2', N'fa1ddca8-4ead-4799-ac9e-18ec51e72d8b', N'd24382f2-16ff-45c6-8e70-0b0a513c773c', NULL, N'', 1, CAST(N'2023-08-16 07:36:22.3333333' AS DateTime2))
INSERT [dbo].[FeedBack] ([Id], [FeedbackId], [CustomerId], [OrderId], [Rating], [Comment], [IsFeedBackAvailable], [ActivityDate]) VALUES (2, N'f72b8f09-a2ac-4376-9b08-403f50baa646', N'fa1ddca8-4ead-4799-ac9e-18ec51e72d8b', N'e3850c70-6765-4b45-9c5f-01f4ee2eaf58', NULL, N'', 1, CAST(N'2023-08-16 09:10:26.0100000' AS DateTime2))
INSERT [dbo].[FeedBack] ([Id], [FeedbackId], [CustomerId], [OrderId], [Rating], [Comment], [IsFeedBackAvailable], [ActivityDate]) VALUES (3, N'f1759722-6c99-4b0e-a598-cf93361e9f63', N'fa1ddca8-4ead-4799-ac9e-18ec51e72d8b', N'b5d99f03-eeb6-4c9c-9f16-b18a281a1826', NULL, N'', 1, CAST(N'2023-08-20 04:31:57.5333333' AS DateTime2))
INSERT [dbo].[FeedBack] ([Id], [FeedbackId], [CustomerId], [OrderId], [Rating], [Comment], [IsFeedBackAvailable], [ActivityDate]) VALUES (4, N'140e6f42-416b-43ac-a26b-74b4df73587f', N'fa1ddca8-4ead-4799-ac9e-18ec51e72d8b', N'd86b4c36-e9ec-4ff8-bcb7-507ffc036e4a', NULL, N'', 1, CAST(N'2023-08-20 04:38:34.0233333' AS DateTime2))
INSERT [dbo].[FeedBack] ([Id], [FeedbackId], [CustomerId], [OrderId], [Rating], [Comment], [IsFeedBackAvailable], [ActivityDate]) VALUES (5, N'c241d12c-3897-406f-b58d-98a4e5e2de39', N'fa1ddca8-4ead-4799-ac9e-18ec51e72d8b', N'9be3488d-8a36-4bb1-b21c-2201d1171324', NULL, N'', 1, CAST(N'2023-08-20 05:26:26.2633333' AS DateTime2))
INSERT [dbo].[FeedBack] ([Id], [FeedbackId], [CustomerId], [OrderId], [Rating], [Comment], [IsFeedBackAvailable], [ActivityDate]) VALUES (6, N'605d8663-fd3e-40de-ac2c-2fb924774b5f', N'5435f9ff-8096-401e-9178-fc1deab2a048', N'1f4641b4-6f3c-4538-af24-ec6ccb5a6c09', NULL, N'', 1, CAST(N'2023-08-20 16:18:57.5500000' AS DateTime2))
INSERT [dbo].[FeedBack] ([Id], [FeedbackId], [CustomerId], [OrderId], [Rating], [Comment], [IsFeedBackAvailable], [ActivityDate]) VALUES (7, N'113056e6-a741-4e64-b638-b6d1c9f87bfc', N'e3a08713-3d80-40ef-a464-9a3983b5c4cd', N'c66dd3af-908d-4713-9764-85163d74b5c5', NULL, N'', 1, CAST(N'2023-08-20 17:32:51.3466667' AS DateTime2))
INSERT [dbo].[FeedBack] ([Id], [FeedbackId], [CustomerId], [OrderId], [Rating], [Comment], [IsFeedBackAvailable], [ActivityDate]) VALUES (8, N'59027c13-49b5-4c28-9af2-67bbc2c35658', N'fa1ddca8-4ead-4799-ac9e-18ec51e72d8b', N'4bb79503-6655-499a-911a-2c7fcefd0df8', NULL, N'', 1, CAST(N'2023-08-20 22:55:16.5466667' AS DateTime2))
INSERT [dbo].[FeedBack] ([Id], [FeedbackId], [CustomerId], [OrderId], [Rating], [Comment], [IsFeedBackAvailable], [ActivityDate]) VALUES (9, N'string', N'string', N'string', 0, N'string', 1, CAST(N'2023-08-20 22:56:27.3400000' AS DateTime2))
INSERT [dbo].[FeedBack] ([Id], [FeedbackId], [CustomerId], [OrderId], [Rating], [Comment], [IsFeedBackAvailable], [ActivityDate]) VALUES (10, N'9423ec18-f1b9-418a-8c61-21f6947f6a51', N'fa1ddca8-4ead-4799-ac9e-18ec51e72d8b', N'f40f60ec-a179-42fd-8f49-69656572cd45', NULL, N'', 1, CAST(N'2023-08-21 11:42:21.9133333' AS DateTime2))
INSERT [dbo].[FeedBack] ([Id], [FeedbackId], [CustomerId], [OrderId], [Rating], [Comment], [IsFeedBackAvailable], [ActivityDate]) VALUES (11, N'811baf1d-aaff-4b39-922a-8d2484d2416a', N'fa1ddca8-4ead-4799-ac9e-18ec51e72d8b', N'f7bcb121-9074-4cbb-8565-9a32124bcbd2', NULL, N'', 1, CAST(N'2023-08-21 15:52:33.6100000' AS DateTime2))
INSERT [dbo].[FeedBack] ([Id], [FeedbackId], [CustomerId], [OrderId], [Rating], [Comment], [IsFeedBackAvailable], [ActivityDate]) VALUES (12, N'7b4b1db2-8c00-441a-bb53-d2a8bea998cb', N'fa1ddca8-4ead-4799-ac9e-18ec51e72d8b', N'1290ecac-00d5-4e1f-a07e-353e6eb095a6', NULL, N'', 0, CAST(N'2023-08-22 07:35:45.1266667' AS DateTime2))
INSERT [dbo].[FeedBack] ([Id], [FeedbackId], [CustomerId], [OrderId], [Rating], [Comment], [IsFeedBackAvailable], [ActivityDate]) VALUES (13, N'34a46edb-76f7-4576-9738-d33a95b774ee', N'fa1ddca8-4ead-4799-ac9e-18ec51e72d8b', N'df784f55-0118-4e66-b827-b7c7e353e648', NULL, N'', 1, CAST(N'2023-08-22 07:39:33.1233333' AS DateTime2))
INSERT [dbo].[FeedBack] ([Id], [FeedbackId], [CustomerId], [OrderId], [Rating], [Comment], [IsFeedBackAvailable], [ActivityDate]) VALUES (14, N'd956abba-b083-4af4-ad16-0e531a775a7f', N'fa1ddca8-4ead-4799-ac9e-18ec51e72d8b', N'a0544ca0-4544-4abf-b1fb-506d82bd34fb', NULL, N'', 1, CAST(N'2023-08-22 07:49:40.1000000' AS DateTime2))
INSERT [dbo].[FeedBack] ([Id], [FeedbackId], [CustomerId], [OrderId], [Rating], [Comment], [IsFeedBackAvailable], [ActivityDate]) VALUES (15, N'6c445ad4-8339-4de2-824d-caf5e8428e5d', N'fa1ddca8-4ead-4799-ac9e-18ec51e72d8b', N'be7f22e6-00d3-433c-91b0-e46e65e4fb33', NULL, N'', 1, CAST(N'2023-08-22 08:37:48.4066667' AS DateTime2))
INSERT [dbo].[FeedBack] ([Id], [FeedbackId], [CustomerId], [OrderId], [Rating], [Comment], [IsFeedBackAvailable], [ActivityDate]) VALUES (16, N'eaadc0ff-e58d-4c79-9561-280516795ad8', N'dfee830d-3cd1-4a3e-b928-9cc04acd2192', N'd14b5030-8645-4e23-9b25-c27f86b1bf8d', NULL, N'', 1, CAST(N'2023-08-22 18:43:59.8533333' AS DateTime2))
INSERT [dbo].[FeedBack] ([Id], [FeedbackId], [CustomerId], [OrderId], [Rating], [Comment], [IsFeedBackAvailable], [ActivityDate]) VALUES (17, N'1ce533b3-76c0-429b-8345-7837567925fd', N'dfee830d-3cd1-4a3e-b928-9cc04acd2192', N'3a8461da-1663-4ba1-9d90-e69b27ae0469', NULL, N'', 0, CAST(N'2023-08-22 18:46:59.0700000' AS DateTime2))
INSERT [dbo].[FeedBack] ([Id], [FeedbackId], [CustomerId], [OrderId], [Rating], [Comment], [IsFeedBackAvailable], [ActivityDate]) VALUES (18, N'887dd205-032d-45a2-8ea6-3859a50b0964', N'dfee830d-3cd1-4a3e-b928-9cc04acd2192', N'b2fc85af-5bcf-402d-b08d-2fda1d49759c', NULL, N'', 1, CAST(N'2023-08-22 18:48:09.6266667' AS DateTime2))
INSERT [dbo].[FeedBack] ([Id], [FeedbackId], [CustomerId], [OrderId], [Rating], [Comment], [IsFeedBackAvailable], [ActivityDate]) VALUES (19, N'd5778b29-bd51-47b0-8215-f139261a34be', N'fa1ddca8-4ead-4799-ac9e-18ec51e72d8b', N'42fdeb60-b2da-4456-a1fa-5907c2906dde', NULL, N'', 1, CAST(N'2023-08-23 05:10:19.3566667' AS DateTime2))
INSERT [dbo].[FeedBack] ([Id], [FeedbackId], [CustomerId], [OrderId], [Rating], [Comment], [IsFeedBackAvailable], [ActivityDate]) VALUES (20, N'18edd32b-c48c-4996-920c-43a72498758b', N'fa1ddca8-4ead-4799-ac9e-18ec51e72d8b', N'a68d234a-8e7e-4551-8886-0b1dae62e53f', NULL, N'', 1, CAST(N'2023-08-23 07:06:50.7500000' AS DateTime2))
INSERT [dbo].[FeedBack] ([Id], [FeedbackId], [CustomerId], [OrderId], [Rating], [Comment], [IsFeedBackAvailable], [ActivityDate]) VALUES (21, N'f75f8f5a-1052-4336-a268-02845b78de91', N'fa1ddca8-4ead-4799-ac9e-18ec51e72d8b', N'000d8896-7757-49a2-a623-799b57146958', NULL, N'', 1, CAST(N'2023-08-23 10:27:57.0333333' AS DateTime2))
INSERT [dbo].[FeedBack] ([Id], [FeedbackId], [CustomerId], [OrderId], [Rating], [Comment], [IsFeedBackAvailable], [ActivityDate]) VALUES (22, N'ed4fef93-5a57-4371-b91f-aff3a2be178d', N'fa1ddca8-4ead-4799-ac9e-18ec51e72d8b', N'3921f73c-7b33-43f4-bd44-6d792656a0a3', NULL, N'', 1, CAST(N'2023-08-23 10:30:30.4466667' AS DateTime2))
INSERT [dbo].[FeedBack] ([Id], [FeedbackId], [CustomerId], [OrderId], [Rating], [Comment], [IsFeedBackAvailable], [ActivityDate]) VALUES (23, N'f495661a-ee79-40eb-bbbd-0f2e0a60afde', N'fa1ddca8-4ead-4799-ac9e-18ec51e72d8b', N'438ffdc9-352e-4bb1-9bd6-e4f076c1b7c3', NULL, N'', 1, CAST(N'2023-08-23 12:34:58.7733333' AS DateTime2))
INSERT [dbo].[FeedBack] ([Id], [FeedbackId], [CustomerId], [OrderId], [Rating], [Comment], [IsFeedBackAvailable], [ActivityDate]) VALUES (24, N'c2363b0b-08dc-4a20-950f-7f1fd3c33821', N'fa1ddca8-4ead-4799-ac9e-18ec51e72d8b', N'5593710f-82d2-4e80-bd22-befdd9bdd44d', NULL, N'', 1, CAST(N'2023-08-24 16:49:59.5433333' AS DateTime2))
INSERT [dbo].[FeedBack] ([Id], [FeedbackId], [CustomerId], [OrderId], [Rating], [Comment], [IsFeedBackAvailable], [ActivityDate]) VALUES (25, N'06f53a96-5c8d-48bd-a711-1407df966980', N'dfee830d-3cd1-4a3e-b928-9cc04acd2192', N'4183d47d-3faf-4cb9-bcde-300555876943', 5, N'Nice', 1, CAST(N'2023-08-29 08:45:51.0133333' AS DateTime2))
INSERT [dbo].[FeedBack] ([Id], [FeedbackId], [CustomerId], [OrderId], [Rating], [Comment], [IsFeedBackAvailable], [ActivityDate]) VALUES (26, N'68ddf368-6989-472c-a3a3-1652dcc0fb31', N'fa1ddca8-4ead-4799-ac9e-18ec51e72d8b', N'02493b24-dcb5-43bc-8983-3dc24e7e2b92', NULL, N'', 1, CAST(N'2023-08-25 11:12:11.6133333' AS DateTime2))
INSERT [dbo].[FeedBack] ([Id], [FeedbackId], [CustomerId], [OrderId], [Rating], [Comment], [IsFeedBackAvailable], [ActivityDate]) VALUES (27, N'ad57855f-3be9-43a0-87d9-1714e366c1ce', N'fa1ddca8-4ead-4799-ac9e-18ec51e72d8b', N'1037d121-3fae-4692-ab19-83f44aaa7e01', NULL, N'', 1, CAST(N'2023-08-26 05:19:18.6566667' AS DateTime2))
INSERT [dbo].[FeedBack] ([Id], [FeedbackId], [CustomerId], [OrderId], [Rating], [Comment], [IsFeedBackAvailable], [ActivityDate]) VALUES (28, N'b3d54d36-d732-4a76-94c9-a3c8449f4d45', N'dfee830d-3cd1-4a3e-b928-9cc04acd2192', N'c2043015-829b-4b9a-aadf-c4bc8f9bef1c', NULL, N'', 1, CAST(N'2023-08-26 23:19:52.7100000' AS DateTime2))
INSERT [dbo].[FeedBack] ([Id], [FeedbackId], [CustomerId], [OrderId], [Rating], [Comment], [IsFeedBackAvailable], [ActivityDate]) VALUES (29, N'20731b68-a5d4-456a-83cb-5466cb1b1c19', N'fa1ddca8-4ead-4799-ac9e-18ec51e72d8b', N'9880133a-17e3-4fc0-88ed-26163c4566da', NULL, N'', 1, CAST(N'2023-08-27 00:25:53.7566667' AS DateTime2))
INSERT [dbo].[FeedBack] ([Id], [FeedbackId], [CustomerId], [OrderId], [Rating], [Comment], [IsFeedBackAvailable], [ActivityDate]) VALUES (30, N'c0cc6f5c-5f74-4661-9e3b-abe8a00f8fd1', N'fa1ddca8-4ead-4799-ac9e-18ec51e72d8b', N'8034aa27-19c6-4cbd-ad40-597b53859f23', NULL, N'', 1, CAST(N'2023-08-27 01:41:59.0933333' AS DateTime2))
INSERT [dbo].[FeedBack] ([Id], [FeedbackId], [CustomerId], [OrderId], [Rating], [Comment], [IsFeedBackAvailable], [ActivityDate]) VALUES (31, N'ee9b2615-c8ac-437c-aaa0-c63da7d15a63', N'fa1ddca8-4ead-4799-ac9e-18ec51e72d8b', N'b92b78cf-64d0-4c4a-a4ba-144b54a614d2', NULL, N'', 1, CAST(N'2023-08-27 07:07:06.2500000' AS DateTime2))
INSERT [dbo].[FeedBack] ([Id], [FeedbackId], [CustomerId], [OrderId], [Rating], [Comment], [IsFeedBackAvailable], [ActivityDate]) VALUES (32, N'309061b3-a864-47a9-b80a-317e374d0cf9', N'dfee830d-3cd1-4a3e-b928-9cc04acd2192', N'937934aa-5295-4f6e-87ab-e4cfa85d6a3e', NULL, N'', 1, CAST(N'2023-08-29 18:15:33.9500000' AS DateTime2))
INSERT [dbo].[FeedBack] ([Id], [FeedbackId], [CustomerId], [OrderId], [Rating], [Comment], [IsFeedBackAvailable], [ActivityDate]) VALUES (33, N'3b83d4bf-8821-417c-b1b0-518e6deedbce', N'dfee830d-3cd1-4a3e-b928-9cc04acd2192', N'f01c4371-6326-4082-b243-e5b6991df0ce', NULL, N'', 1, CAST(N'2023-08-30 16:44:15.7700000' AS DateTime2))
INSERT [dbo].[FeedBack] ([Id], [FeedbackId], [CustomerId], [OrderId], [Rating], [Comment], [IsFeedBackAvailable], [ActivityDate]) VALUES (34, N'ca7819b2-7855-4264-bd6a-8ca92cfae268', N'dfee830d-3cd1-4a3e-b928-9cc04acd2192', N'0cb1ae18-5b8d-4c98-b199-44b40ccc731d', NULL, N'', 0, CAST(N'2023-08-31 04:39:14.2800000' AS DateTime2))
INSERT [dbo].[FeedBack] ([Id], [FeedbackId], [CustomerId], [OrderId], [Rating], [Comment], [IsFeedBackAvailable], [ActivityDate]) VALUES (35, N'22d428e5-0537-4544-9748-3ad7d7d7faa0', N'fa1ddca8-4ead-4799-ac9e-18ec51e72d8b', N'311174e8-1133-4a22-8a0d-d1a609be3749', NULL, N'', 1, CAST(N'2023-08-31 08:22:15.2533333' AS DateTime2))
INSERT [dbo].[FeedBack] ([Id], [FeedbackId], [CustomerId], [OrderId], [Rating], [Comment], [IsFeedBackAvailable], [ActivityDate]) VALUES (36, N'6200d6cc-9fe0-49dc-9390-096f1444c9da', N'fa1ddca8-4ead-4799-ac9e-18ec51e72d8b', N'e0287748-c98b-465a-a227-32c3b866a009', NULL, N'', 1, CAST(N'2023-08-31 08:37:14.3000000' AS DateTime2))
INSERT [dbo].[FeedBack] ([Id], [FeedbackId], [CustomerId], [OrderId], [Rating], [Comment], [IsFeedBackAvailable], [ActivityDate]) VALUES (37, N'02e822b0-781d-4f34-b19a-e7ba81dd33a7', N'fa1ddca8-4ead-4799-ac9e-18ec51e72d8b', N'94bf7b58-9aa8-4b47-9ed2-eed0f91c5f04', NULL, N'', 1, CAST(N'2023-08-31 08:42:42.0833333' AS DateTime2))
INSERT [dbo].[FeedBack] ([Id], [FeedbackId], [CustomerId], [OrderId], [Rating], [Comment], [IsFeedBackAvailable], [ActivityDate]) VALUES (38, N'24416bed-4a6b-4e31-bbcb-02ba68ee579e', N'fa1ddca8-4ead-4799-ac9e-18ec51e72d8b', N'6d967bc2-a675-44b1-b68e-035fe467710e', NULL, N'', 1, CAST(N'2023-09-01 06:33:07.3566667' AS DateTime2))
INSERT [dbo].[FeedBack] ([Id], [FeedbackId], [CustomerId], [OrderId], [Rating], [Comment], [IsFeedBackAvailable], [ActivityDate]) VALUES (39, N'6d754aae-9949-4d26-82d3-e5b053cad319', N'fa1ddca8-4ead-4799-ac9e-18ec51e72d8b', N'70bda761-7163-44c3-8d64-65a6a3dcc5f9', NULL, N'', 1, CAST(N'2023-09-02 06:34:07.0100000' AS DateTime2))
INSERT [dbo].[FeedBack] ([Id], [FeedbackId], [CustomerId], [OrderId], [Rating], [Comment], [IsFeedBackAvailable], [ActivityDate]) VALUES (40, N'9796550f-f1a7-4a6c-b2e1-b9f0a44018be', N'fa1ddca8-4ead-4799-ac9e-18ec51e72d8b', N'35f9e5f5-1178-421a-8bbf-4f530c11963a', NULL, N'', 1, CAST(N'2023-09-02 07:54:16.9366667' AS DateTime2))
INSERT [dbo].[FeedBack] ([Id], [FeedbackId], [CustomerId], [OrderId], [Rating], [Comment], [IsFeedBackAvailable], [ActivityDate]) VALUES (41, N'24130a4c-91de-49c9-bd76-70171db1041b', N'805762d5-4f7d-4c1f-a5de-e15405ab73c1', N'f32d9310-b7fc-4506-a820-674d4d0a2b20', NULL, N'', 1, CAST(N'2023-09-03 17:01:58.4966667' AS DateTime2))
INSERT [dbo].[FeedBack] ([Id], [FeedbackId], [CustomerId], [OrderId], [Rating], [Comment], [IsFeedBackAvailable], [ActivityDate]) VALUES (42, N'137ed3fe-8ecb-4d40-9e4f-c5e0201dbddb', N'dfee830d-3cd1-4a3e-b928-9cc04acd2192', N'9004fa03-376d-451a-aca7-2d6ca20e82f2', NULL, N'', 1, CAST(N'2023-09-06 16:05:36.1400000' AS DateTime2))
INSERT [dbo].[FeedBack] ([Id], [FeedbackId], [CustomerId], [OrderId], [Rating], [Comment], [IsFeedBackAvailable], [ActivityDate]) VALUES (43, N'd1dbff46-78dd-442d-92ba-d97dc6edf31e', N'e3a08713-3d80-40ef-a464-9a3983b5c4cd', N'a8532241-b759-4515-b4f5-81a02b697e46', NULL, N'', 1, CAST(N'2023-09-07 09:22:20.7500000' AS DateTime2))
INSERT [dbo].[FeedBack] ([Id], [FeedbackId], [CustomerId], [OrderId], [Rating], [Comment], [IsFeedBackAvailable], [ActivityDate]) VALUES (44, N'81f39190-cfa8-4883-b1b8-95e57fc6b747', N'e3a08713-3d80-40ef-a464-9a3983b5c4cd', N'a30ed5ed-3491-4f1e-8875-745d2a34f42e', NULL, N'', 1, CAST(N'2023-09-07 20:19:37.7466667' AS DateTime2))
INSERT [dbo].[FeedBack] ([Id], [FeedbackId], [CustomerId], [OrderId], [Rating], [Comment], [IsFeedBackAvailable], [ActivityDate]) VALUES (45, N'85b59e3d-2257-4659-8e59-a7a715be6e86', N'e3a08713-3d80-40ef-a464-9a3983b5c4cd', N'941b36bc-cf9c-4518-8639-292860ea39cc', NULL, N'', 1, CAST(N'2023-09-09 06:48:23.6066667' AS DateTime2))
INSERT [dbo].[FeedBack] ([Id], [FeedbackId], [CustomerId], [OrderId], [Rating], [Comment], [IsFeedBackAvailable], [ActivityDate]) VALUES (46, N'77bc4a8c-70cb-4313-a201-80d97f5b6900', N'e3a08713-3d80-40ef-a464-9a3983b5c4cd', N'a801a81d-8b16-4d9f-9868-736b7609d2c0', NULL, N'', 1, CAST(N'2023-09-09 18:12:44.8533333' AS DateTime2))
INSERT [dbo].[FeedBack] ([Id], [FeedbackId], [CustomerId], [OrderId], [Rating], [Comment], [IsFeedBackAvailable], [ActivityDate]) VALUES (47, N'1b833aa6-764c-4931-b7ed-da5071ae7a1d', N'e3a08713-3d80-40ef-a464-9a3983b5c4cd', N'9f17217f-18cd-4bc3-a600-2401c76549bc', NULL, N'', 1, CAST(N'2023-09-10 18:25:45.4300000' AS DateTime2))
INSERT [dbo].[FeedBack] ([Id], [FeedbackId], [CustomerId], [OrderId], [Rating], [Comment], [IsFeedBackAvailable], [ActivityDate]) VALUES (48, N'8b3c8926-cdd3-48dd-828f-bc3df8e6cf43', N'e3a08713-3d80-40ef-a464-9a3983b5c4cd', N'0a878637-df9a-44a6-b8a8-191a3df96149', NULL, N'', 1, CAST(N'2023-09-11 19:51:55.6733333' AS DateTime2))
SET IDENTITY_INSERT [dbo].[FeedBack] OFF
SET IDENTITY_INSERT [dbo].[Item] ON 

INSERT [dbo].[Item] ([Id], [ItemId], [Name], [Description], [Price], [RegularPrice], [IsPopular], [IsFeatured], [IsFavorite], [Image], [CategoryId], [OnSale], [CreatedAt], [UpdatedAt], [IsDeleted]) VALUES (1, N'i001', N'Classic Burger Menu', N'Burger, Potato, Beverage', 18, 18, 1, 0, 0, N'mi_classic_burger_menu', 1, 1, CAST(N'2023-07-26 09:54:22.3166667' AS DateTime2), NULL, 0)
INSERT [dbo].[Item] ([Id], [ItemId], [Name], [Description], [Price], [RegularPrice], [IsPopular], [IsFeatured], [IsFavorite], [Image], [CategoryId], [OnSale], [CreatedAt], [UpdatedAt], [IsDeleted]) VALUES (2, N'i002', N'Classic Double Burger Menu', N'Burger, Potato, Beverage', 32, 38, 1, 0, 0, N'mi_classic_burger_menu', 1, 1, CAST(N'2023-07-26 09:56:02.2100000' AS DateTime2), NULL, 0)
INSERT [dbo].[Item] ([Id], [ItemId], [Name], [Description], [Price], [RegularPrice], [IsPopular], [IsFeatured], [IsFavorite], [Image], [CategoryId], [OnSale], [CreatedAt], [UpdatedAt], [IsDeleted]) VALUES (3, N'i005', N'Classic Burger', N'Beef, bread, pickles, ketchup, mayonnaise, lettuce, tomato, onion.', 8, 10, 1, 0, 0, N'mi_burger', 2, 1, CAST(N'2023-07-26 09:56:43.6166667' AS DateTime2), NULL, 0)
INSERT [dbo].[Item] ([Id], [ItemId], [Name], [Description], [Price], [RegularPrice], [IsPopular], [IsFeatured], [IsFavorite], [Image], [CategoryId], [OnSale], [CreatedAt], [UpdatedAt], [IsDeleted]) VALUES (4, N'i006', N'Double Burger', N'Beef, bread, pickles, ketchup, mayonnaise, lettuce, tomato, onion.', 14, 14, 1, 0, 0, N'mi_double_burger', 2, 1, CAST(N'2023-07-26 09:57:52.1400000' AS DateTime2), NULL, 0)
INSERT [dbo].[Item] ([Id], [ItemId], [Name], [Description], [Price], [RegularPrice], [IsPopular], [IsFeatured], [IsFavorite], [Image], [CategoryId], [OnSale], [CreatedAt], [UpdatedAt], [IsDeleted]) VALUES (5, N'i010', N'Tenderloin with Mushroom Sauce', N'Tenderloin, mushroom sauce, salad, pasta.', 14, 14, 1, 0, 0, N'mi_double_burger', 3, 1, CAST(N'2023-07-26 09:58:27.8866667' AS DateTime2), NULL, 0)
INSERT [dbo].[Item] ([Id], [ItemId], [Name], [Description], [Price], [RegularPrice], [IsPopular], [IsFeatured], [IsFavorite], [Image], [CategoryId], [OnSale], [CreatedAt], [UpdatedAt], [IsDeleted]) VALUES (6, N'i011', N'Grilled Meatball', N'Grilled meatball, salad, potato.', 25, 26, 0, 1, 0, N'mi_meatball', 3, 1, CAST(N'2023-07-26 09:59:19.3500000' AS DateTime2), NULL, 0)
INSERT [dbo].[Item] ([Id], [ItemId], [Name], [Description], [Price], [RegularPrice], [IsPopular], [IsFeatured], [IsFavorite], [Image], [CategoryId], [OnSale], [CreatedAt], [UpdatedAt], [IsDeleted]) VALUES (7, N'i012', N'Grilled Chicken Steak', N'Grilled chicken steak, pasta, salad', 16, 16, 0, 1, 0, N'mi_grilled_chicken_steak', 3, 1, CAST(N'2023-07-26 10:00:07.9466667' AS DateTime2), NULL, 0)
INSERT [dbo].[Item] ([Id], [ItemId], [Name], [Description], [Price], [RegularPrice], [IsPopular], [IsFeatured], [IsFavorite], [Image], [CategoryId], [OnSale], [CreatedAt], [UpdatedAt], [IsDeleted]) VALUES (8, N'i014', N'Alinazik Chicken', N'Chicken chop, yogurt, eggplant', 20, 22, 0, 1, 0, N'mi_alinazik_chicken', 3, 1, CAST(N'2023-07-26 10:00:52.3666667' AS DateTime2), NULL, 0)
INSERT [dbo].[Item] ([Id], [ItemId], [Name], [Description], [Price], [RegularPrice], [IsPopular], [IsFeatured], [IsFavorite], [Image], [CategoryId], [OnSale], [CreatedAt], [UpdatedAt], [IsDeleted]) VALUES (9, N'i019', N'Napolitan Pasta', N'Napolitan sauce, cheddar, pasta', 11, 12, 0, 1, 0, N'mi_alinazik_chicken', 3, 0, CAST(N'2023-07-26 10:01:42.5533333' AS DateTime2), NULL, 0)
INSERT [dbo].[Item] ([Id], [ItemId], [Name], [Description], [Price], [RegularPrice], [IsPopular], [IsFeatured], [IsFavorite], [Image], [CategoryId], [OnSale], [CreatedAt], [UpdatedAt], [IsDeleted]) VALUES (10, N'i020', N'Alfredo Pasta', N'Chicken with sauce, cheddar, mushroom, pasta, custard', 12, 14, 0, 1, 0, N'mi_alfredo_pasta', 3, 0, CAST(N'2023-07-26 10:02:24.6933333' AS DateTime2), NULL, 0)
SET IDENTITY_INSERT [dbo].[Item] OFF
SET IDENTITY_INSERT [dbo].[LoyaltyPointsHistory] ON 

INSERT [dbo].[LoyaltyPointsHistory] ([Id], [LoyaltyId], [TotalAmount], [AddedBalance], [AddedDate], [OrderId], [ActionType], [Description], [TransferId], [ReferenceId]) VALUES (1, N'b6004b32-fef2-4221-8025-d0af92411c29', 24, 2.4, CAST(N'2023-08-26 21:27:38.7233333' AS DateTime2), N'5593710f-82d2-4e80-bd22-befdd9bdd44d', N'Order', N'Added 2.4 points to wallet', NULL, 24)
INSERT [dbo].[LoyaltyPointsHistory] ([Id], [LoyaltyId], [TotalAmount], [AddedBalance], [AddedDate], [OrderId], [ActionType], [Description], [TransferId], [ReferenceId]) VALUES (2, N'b6004b32-fef2-4221-8025-d0af92411c29', 24, 2.4, CAST(N'2023-08-26 21:38:55.3166667' AS DateTime2), N'5593710f-82d2-4e80-bd22-befdd9bdd44d', N'Order', N'Added 2.4 points to wallet', NULL, 24)
INSERT [dbo].[LoyaltyPointsHistory] ([Id], [LoyaltyId], [TotalAmount], [AddedBalance], [AddedDate], [OrderId], [ActionType], [Description], [TransferId], [ReferenceId]) VALUES (3, N'b6004b32-fef2-4221-8025-d0af92411c29', 24, 2.4, CAST(N'2023-08-26 21:42:20.5466667' AS DateTime2), N'5593710f-82d2-4e80-bd22-befdd9bdd44d', N'Order', N'Added 2.4 points to wallet', NULL, 24)
INSERT [dbo].[LoyaltyPointsHistory] ([Id], [LoyaltyId], [TotalAmount], [AddedBalance], [AddedDate], [OrderId], [ActionType], [Description], [TransferId], [ReferenceId]) VALUES (4, N'b6004b32-fef2-4221-8025-d0af92411c29', 24, 2.4, CAST(N'2023-08-26 21:45:35.3866667' AS DateTime2), N'5593710f-82d2-4e80-bd22-befdd9bdd44d', N'Order', N'Added 2.4 points to wallet', NULL, 24)
INSERT [dbo].[LoyaltyPointsHistory] ([Id], [LoyaltyId], [TotalAmount], [AddedBalance], [AddedDate], [OrderId], [ActionType], [Description], [TransferId], [ReferenceId]) VALUES (5, N'b6004b32-fef2-4221-8025-d0af92411c29', 24, 2.4, CAST(N'2023-08-26 21:46:31.8266667' AS DateTime2), N'5593710f-82d2-4e80-bd22-befdd9bdd44d', N'Order', N'Added 2.4 points to wallet', NULL, 24)
INSERT [dbo].[LoyaltyPointsHistory] ([Id], [LoyaltyId], [TotalAmount], [AddedBalance], [AddedDate], [OrderId], [ActionType], [Description], [TransferId], [ReferenceId]) VALUES (6, N'b6004b32-fef2-4221-8025-d0af92411c29', 24, 2.4, CAST(N'2023-08-26 21:49:38.5500000' AS DateTime2), N'5593710f-82d2-4e80-bd22-befdd9bdd44d', N'Order', N'Added 2.4 points to wallet', NULL, 24)
INSERT [dbo].[LoyaltyPointsHistory] ([Id], [LoyaltyId], [TotalAmount], [AddedBalance], [AddedDate], [OrderId], [ActionType], [Description], [TransferId], [ReferenceId]) VALUES (7, N'b6004b32-fef2-4221-8025-d0af92411c29', 24, 2.4, CAST(N'2023-08-26 21:50:16.4733333' AS DateTime2), N'5593710f-82d2-4e80-bd22-befdd9bdd44d', N'Order', N'Added 2.4 points to wallet', NULL, 24)
INSERT [dbo].[LoyaltyPointsHistory] ([Id], [LoyaltyId], [TotalAmount], [AddedBalance], [AddedDate], [OrderId], [ActionType], [Description], [TransferId], [ReferenceId]) VALUES (8, N'd3be322d-1725-4a4c-b569-96620925c516', 14, 1.4, CAST(N'2023-08-26 23:12:30.2133333' AS DateTime2), N'4183d47d-3faf-4cb9-bcde-300555876943', N'Order', N'Added 1.4 points to wallet', NULL, 25)
INSERT [dbo].[LoyaltyPointsHistory] ([Id], [LoyaltyId], [TotalAmount], [AddedBalance], [AddedDate], [OrderId], [ActionType], [Description], [TransferId], [ReferenceId]) VALUES (9, N'b6004b32-fef2-4221-8025-d0af92411c29', 20, 2, CAST(N'2023-08-26 23:14:23.8333333' AS DateTime2), N'1037d121-3fae-4692-ab19-83f44aaa7e01', N'Order', N'Added 2 points to wallet', NULL, 27)
INSERT [dbo].[LoyaltyPointsHistory] ([Id], [LoyaltyId], [TotalAmount], [AddedBalance], [AddedDate], [OrderId], [ActionType], [Description], [TransferId], [ReferenceId]) VALUES (10, N'd3be322d-1725-4a4c-b569-96620925c516', 32, 3.2, CAST(N'2023-08-29 18:17:46.4866667' AS DateTime2), N'c2043015-829b-4b9a-aadf-c4bc8f9bef1c', N'Order', N'Added 3.2 points to wallet', NULL, 28)
INSERT [dbo].[LoyaltyPointsHistory] ([Id], [LoyaltyId], [TotalAmount], [AddedBalance], [AddedDate], [OrderId], [ActionType], [Description], [TransferId], [ReferenceId]) VALUES (11, N'd3be322d-1725-4a4c-b569-96620925c516', 25, 2.5, CAST(N'2023-08-30 05:11:12.5333333' AS DateTime2), N'937934aa-5295-4f6e-87ab-e4cfa85d6a3e', N'Order', N'Added 2.5 points to wallet', NULL, 32)
INSERT [dbo].[LoyaltyPointsHistory] ([Id], [LoyaltyId], [TotalAmount], [AddedBalance], [AddedDate], [OrderId], [ActionType], [Description], [TransferId], [ReferenceId]) VALUES (12, N'd3be322d-1725-4a4c-b569-96620925c516', 48, 4.8, CAST(N'2023-08-30 20:16:28.9766667' AS DateTime2), N'f01c4371-6326-4082-b243-e5b6991df0ce', N'Order', N'Added 4.8 points to wallet', NULL, 33)
INSERT [dbo].[LoyaltyPointsHistory] ([Id], [LoyaltyId], [TotalAmount], [AddedBalance], [AddedDate], [OrderId], [ActionType], [Description], [TransferId], [ReferenceId]) VALUES (13, N'b6004b32-fef2-4221-8025-d0af92411c29', 79, 7.9, CAST(N'2023-09-02 07:52:29.4100000' AS DateTime2), N'70bda761-7163-44c3-8d64-65a6a3dcc5f9', N'Order', N'Added 7.9 points to wallet', NULL, 39)
INSERT [dbo].[LoyaltyPointsHistory] ([Id], [LoyaltyId], [TotalAmount], [AddedBalance], [AddedDate], [OrderId], [ActionType], [Description], [TransferId], [ReferenceId]) VALUES (14, N'2fcc631e-3c7b-481a-b370-30e88c32dce6', 18, 1.8, CAST(N'2023-09-09 18:48:45.7266667' AS DateTime2), N'a30ed5ed-3491-4f1e-8875-745d2a34f42e', N'Order', N'Added 1.8 points to wallet', NULL, 44)
INSERT [dbo].[LoyaltyPointsHistory] ([Id], [LoyaltyId], [TotalAmount], [AddedBalance], [AddedDate], [OrderId], [ActionType], [Description], [TransferId], [ReferenceId]) VALUES (15, N'2fcc631e-3c7b-481a-b370-30e88c32dce6', 16, 1.6, CAST(N'2023-09-10 19:05:36.1066667' AS DateTime2), N'9f17217f-18cd-4bc3-a600-2401c76549bc', N'Order', N'Added 1.6 points to wallet', NULL, 47)
INSERT [dbo].[LoyaltyPointsHistory] ([Id], [LoyaltyId], [TotalAmount], [AddedBalance], [AddedDate], [OrderId], [ActionType], [Description], [TransferId], [ReferenceId]) VALUES (16, N'b6004b32-fef2-4221-8025-d0af92411c29', 16, 1.6, CAST(N'2023-09-10 20:43:08.9800000' AS DateTime2), N'311174e8-1133-4a22-8a0d-d1a609be3749', N'Order', N'Added 1.6 points to wallet', NULL, 35)
INSERT [dbo].[LoyaltyPointsHistory] ([Id], [LoyaltyId], [TotalAmount], [AddedBalance], [AddedDate], [OrderId], [ActionType], [Description], [TransferId], [ReferenceId]) VALUES (17, N'2fcc631e-3c7b-481a-b370-30e88c32dce6', 25, 2.5, CAST(N'2023-09-10 20:43:31.0400000' AS DateTime2), N'a8532241-b759-4515-b4f5-81a02b697e46', N'Order', N'Added 2.5 points to wallet', NULL, 43)
INSERT [dbo].[LoyaltyPointsHistory] ([Id], [LoyaltyId], [TotalAmount], [AddedBalance], [AddedDate], [OrderId], [ActionType], [Description], [TransferId], [ReferenceId]) VALUES (18, N'd3be322d-1725-4a4c-b569-96620925c516', 131, 13.1, CAST(N'2023-09-10 20:43:57.1866667' AS DateTime2), N'9004fa03-376d-451a-aca7-2d6ca20e82f2', N'Order', N'Added 13.1 points to wallet', NULL, 42)
INSERT [dbo].[LoyaltyPointsHistory] ([Id], [LoyaltyId], [TotalAmount], [AddedBalance], [AddedDate], [OrderId], [ActionType], [Description], [TransferId], [ReferenceId]) VALUES (19, N'b6004b32-fef2-4221-8025-d0af92411c29', 16, 1.6, CAST(N'2023-09-11 07:05:34.4166667' AS DateTime2), N'35f9e5f5-1178-421a-8bbf-4f530c11963a', N'Order', N'Added 1.6 points to wallet', NULL, 40)
INSERT [dbo].[LoyaltyPointsHistory] ([Id], [LoyaltyId], [TotalAmount], [AddedBalance], [AddedDate], [OrderId], [ActionType], [Description], [TransferId], [ReferenceId]) VALUES (20, N'2fcc631e-3c7b-481a-b370-30e88c32dce6', 20, 2, CAST(N'2023-09-12 06:52:53.8800000' AS DateTime2), N'c66dd3af-908d-4713-9764-85163d74b5c5', N'Order', N'Added 2 points to wallet', NULL, 7)
SET IDENTITY_INSERT [dbo].[LoyaltyPointsHistory] OFF
SET IDENTITY_INSERT [dbo].[Order] ON 

INSERT [dbo].[Order] ([Id], [OrderId], [CustomerId], [DateGmt], [Address], [Shipping], [Total], [ModeOfPayment], [IsOngoingOrder], [Status], [PlacedTime], [ProcessingTime], [OnTheWayTime], [DeliveredTime], [CanceledTime], [GrandTotal], [CreatedAt], [UpdatedAt], [Lat], [Lon], [AddressTitle], [ReferrerId], [ForPickUpTime], [Discount], [DriverId], [DriverLat], [DriverLon], [AdditionalFee], [ChangeAddress], [ChangeAddressLat], [ChangeAddressLon], [ChangeAddressTitle], [IsChangeAddress], [IsChangeAddressAccepted], [IsArchive], [IsDriverArchive]) VALUES (1, N'd24382f2-16ff-45c6-8e70-0b0a513c773c', N'fa1ddca8-4ead-4799-ac9e-18ec51e72d8b', CAST(N'2023-08-16 07:36:22.3400000' AS DateTime2), N'home', 5, 32, 0, 0, N'Cancelled', CAST(N'2023-08-16 07:36:22.3400000' AS DateTime2), NULL, CAST(N'2023-08-18 14:27:23.2166667' AS DateTime2), CAST(N'2023-08-18 14:27:41.2033333' AS DateTime2), NULL, 33.8, CAST(N'2023-08-16 07:36:22.3100000' AS DateTime2), CAST(N'2023-08-18 14:27:41.2033333' AS DateTime2), N'-18.097366', N'178.468690', N'Home', NULL, NULL, -3.2, N'c471f0bf-92e6-466d-a38a-8df5a88832ff', N'-18.1202548573504', N'178.459978803537', NULL, NULL, NULL, NULL, NULL, 0, 0, 1, 1)
INSERT [dbo].[Order] ([Id], [OrderId], [CustomerId], [DateGmt], [Address], [Shipping], [Total], [ModeOfPayment], [IsOngoingOrder], [Status], [PlacedTime], [ProcessingTime], [OnTheWayTime], [DeliveredTime], [CanceledTime], [GrandTotal], [CreatedAt], [UpdatedAt], [Lat], [Lon], [AddressTitle], [ReferrerId], [ForPickUpTime], [Discount], [DriverId], [DriverLat], [DriverLon], [AdditionalFee], [ChangeAddress], [ChangeAddressLat], [ChangeAddressLon], [ChangeAddressTitle], [IsChangeAddress], [IsChangeAddressAccepted], [IsArchive], [IsDriverArchive]) VALUES (2, N'e3850c70-6765-4b45-9c5f-01f4ee2eaf58', N'fa1ddca8-4ead-4799-ac9e-18ec51e72d8b', CAST(N'2023-08-16 09:10:25.9666667' AS DateTime2), N'school', 5, 32, 0, 0, N'Delivered', CAST(N'2023-08-16 09:10:25.9700000' AS DateTime2), NULL, CAST(N'2023-08-18 14:27:23.5500000' AS DateTime2), CAST(N'2023-08-18 14:27:53.4233333' AS DateTime2), NULL, 37, CAST(N'2023-08-16 09:10:25.9733333' AS DateTime2), CAST(N'2023-08-18 14:31:16.4266667' AS DateTime2), N'-18.062808', N'178.524187', N'School', NULL, NULL, 0, N'c471f0bf-92e6-466d-a38a-8df5a88832ff', N'-18.12021507956', N'178.459985603854', NULL, NULL, NULL, NULL, NULL, 0, 0, 1, 0)
INSERT [dbo].[Order] ([Id], [OrderId], [CustomerId], [DateGmt], [Address], [Shipping], [Total], [ModeOfPayment], [IsOngoingOrder], [Status], [PlacedTime], [ProcessingTime], [OnTheWayTime], [DeliveredTime], [CanceledTime], [GrandTotal], [CreatedAt], [UpdatedAt], [Lat], [Lon], [AddressTitle], [ReferrerId], [ForPickUpTime], [Discount], [DriverId], [DriverLat], [DriverLon], [AdditionalFee], [ChangeAddress], [ChangeAddressLat], [ChangeAddressLon], [ChangeAddressTitle], [IsChangeAddress], [IsChangeAddressAccepted], [IsArchive], [IsDriverArchive]) VALUES (3, N'b5d99f03-eeb6-4c9c-9f16-b18a281a1826', N'fa1ddca8-4ead-4799-ac9e-18ec51e72d8b', CAST(N'2023-08-20 04:31:55.0800000' AS DateTime2), N'home', 16.49, 32, 0, 0, N'Delivered', CAST(N'2023-08-20 04:31:55.0833333' AS DateTime2), NULL, CAST(N'2023-08-20 04:33:29.8833333' AS DateTime2), CAST(N'2023-08-20 04:33:41.7200000' AS DateTime2), NULL, 48.49, CAST(N'2023-08-20 04:31:57.4866667' AS DateTime2), CAST(N'2023-08-20 04:33:43.6166667' AS DateTime2), N'-18.1189842509823', N'178.463611230254', N'Home', NULL, NULL, 0, N'c471f0bf-92e6-466d-a38a-8df5a88832ff', N'-18.1219828803313', N'178.459807026956', NULL, NULL, NULL, NULL, NULL, 0, 0, 0, 0)
INSERT [dbo].[Order] ([Id], [OrderId], [CustomerId], [DateGmt], [Address], [Shipping], [Total], [ModeOfPayment], [IsOngoingOrder], [Status], [PlacedTime], [ProcessingTime], [OnTheWayTime], [DeliveredTime], [CanceledTime], [GrandTotal], [CreatedAt], [UpdatedAt], [Lat], [Lon], [AddressTitle], [ReferrerId], [ForPickUpTime], [Discount], [DriverId], [DriverLat], [DriverLon], [AdditionalFee], [ChangeAddress], [ChangeAddressLat], [ChangeAddressLon], [ChangeAddressTitle], [IsChangeAddress], [IsChangeAddressAccepted], [IsArchive], [IsDriverArchive]) VALUES (4, N'd86b4c36-e9ec-4ff8-bcb7-507ffc036e4a', N'fa1ddca8-4ead-4799-ac9e-18ec51e72d8b', CAST(N'2023-08-20 04:38:32.0066667' AS DateTime2), N'home', 16.49, 32, 0, 0, N'Delivered', CAST(N'2023-08-20 04:38:32.0066667' AS DateTime2), NULL, CAST(N'2023-08-20 06:34:24.6933333' AS DateTime2), CAST(N'2023-08-20 06:35:37.6000000' AS DateTime2), NULL, 48.49, CAST(N'2023-08-20 04:38:34.0000000' AS DateTime2), CAST(N'2023-08-20 06:35:37.6466667' AS DateTime2), N'-18.1189842509823', N'178.463611230254', N'Home', NULL, NULL, 0, N'c471f0bf-92e6-466d-a38a-8df5a88832ff', N'-18.1190315875799', N'178.46364870175', NULL, NULL, NULL, NULL, NULL, 0, 0, 0, 0)
INSERT [dbo].[Order] ([Id], [OrderId], [CustomerId], [DateGmt], [Address], [Shipping], [Total], [ModeOfPayment], [IsOngoingOrder], [Status], [PlacedTime], [ProcessingTime], [OnTheWayTime], [DeliveredTime], [CanceledTime], [GrandTotal], [CreatedAt], [UpdatedAt], [Lat], [Lon], [AddressTitle], [ReferrerId], [ForPickUpTime], [Discount], [DriverId], [DriverLat], [DriverLon], [AdditionalFee], [ChangeAddress], [ChangeAddressLat], [ChangeAddressLon], [ChangeAddressTitle], [IsChangeAddress], [IsChangeAddressAccepted], [IsArchive], [IsDriverArchive]) VALUES (5, N'9be3488d-8a36-4bb1-b21c-2201d1171324', N'fa1ddca8-4ead-4799-ac9e-18ec51e72d8b', CAST(N'2023-08-20 05:26:23.8933333' AS DateTime2), N'other', 22.67, 22, 0, 0, N'Cancelled', CAST(N'2023-08-20 05:26:23.8933333' AS DateTime2), NULL, CAST(N'2023-08-20 06:34:24.9733333' AS DateTime2), CAST(N'2023-08-20 06:37:34.0100000' AS DateTime2), NULL, 44.67, CAST(N'2023-08-20 05:26:26.2333333' AS DateTime2), CAST(N'2023-08-20 06:37:34.0100000' AS DateTime2), N'-18.121447722234', N'178.4594816342', N'Others', NULL, NULL, 0, N'c471f0bf-92e6-466d-a38a-8df5a88832ff', N'-18.1213771814727', N'178.459534703256', NULL, NULL, NULL, NULL, NULL, 0, 0, 0, 0)
INSERT [dbo].[Order] ([Id], [OrderId], [CustomerId], [DateGmt], [Address], [Shipping], [Total], [ModeOfPayment], [IsOngoingOrder], [Status], [PlacedTime], [ProcessingTime], [OnTheWayTime], [DeliveredTime], [CanceledTime], [GrandTotal], [CreatedAt], [UpdatedAt], [Lat], [Lon], [AddressTitle], [ReferrerId], [ForPickUpTime], [Discount], [DriverId], [DriverLat], [DriverLon], [AdditionalFee], [ChangeAddress], [ChangeAddressLat], [ChangeAddressLon], [ChangeAddressTitle], [IsChangeAddress], [IsChangeAddressAccepted], [IsArchive], [IsDriverArchive]) VALUES (6, N'1f4641b4-6f3c-4538-af24-ec6ccb5a6c09', N'5435f9ff-8096-401e-9178-fc1deab2a048', CAST(N'2023-08-20 16:18:54.4266667' AS DateTime2), N'golf coure, ab 13', 26.59, 32, 0, 0, N'Cancelled', CAST(N'2023-08-20 16:18:54.4366667' AS DateTime2), NULL, CAST(N'2023-08-20 16:23:20.4333333' AS DateTime2), CAST(N'2023-08-20 16:23:29.3600000' AS DateTime2), NULL, 55.39, CAST(N'2023-08-20 16:18:57.5133333' AS DateTime2), CAST(N'2023-08-20 16:23:29.3600000' AS DateTime2), N'-18.1237613971431', N'178.461611308157', N'Others', N'fa1ddca8-4ead-4799-ac9e-18ec51e72d8b', NULL, -3.2, N'c471f0bf-92e6-466d-a38a-8df5a88832ff', N'-18.1234286190402', N'178.458945798706', NULL, NULL, NULL, NULL, NULL, 0, 0, 0, 0)
INSERT [dbo].[Order] ([Id], [OrderId], [CustomerId], [DateGmt], [Address], [Shipping], [Total], [ModeOfPayment], [IsOngoingOrder], [Status], [PlacedTime], [ProcessingTime], [OnTheWayTime], [DeliveredTime], [CanceledTime], [GrandTotal], [CreatedAt], [UpdatedAt], [Lat], [Lon], [AddressTitle], [ReferrerId], [ForPickUpTime], [Discount], [DriverId], [DriverLat], [DriverLon], [AdditionalFee], [ChangeAddress], [ChangeAddressLat], [ChangeAddressLon], [ChangeAddressTitle], [IsChangeAddress], [IsChangeAddressAccepted], [IsArchive], [IsDriverArchive]) VALUES (7, N'c66dd3af-908d-4713-9764-85163d74b5c5', N'e3a08713-3d80-40ef-a464-9a3983b5c4cd', CAST(N'2023-08-20 17:32:50.9700000' AS DateTime2), N'kalabu tax free zone', 35.96, 20, 0, 0, N'Delivered', CAST(N'2023-08-20 17:32:50.9700000' AS DateTime2), NULL, CAST(N'2023-09-12 06:35:08.9133333' AS DateTime2), CAST(N'2023-09-12 06:52:53.8966667' AS DateTime2), NULL, 53.96, CAST(N'2023-08-20 17:32:51.3133333' AS DateTime2), CAST(N'2023-09-12 06:53:15.9766667' AS DateTime2), N'-18.0912575340338', N'178.481916636229', N'Work', NULL, NULL, -2, N'20d4a3a5-056e-4efe-ad36-4c913257a3bc', N'-18.10668', N'178.4502714', NULL, NULL, NULL, NULL, NULL, 0, 0, 0, 0)
INSERT [dbo].[Order] ([Id], [OrderId], [CustomerId], [DateGmt], [Address], [Shipping], [Total], [ModeOfPayment], [IsOngoingOrder], [Status], [PlacedTime], [ProcessingTime], [OnTheWayTime], [DeliveredTime], [CanceledTime], [GrandTotal], [CreatedAt], [UpdatedAt], [Lat], [Lon], [AddressTitle], [ReferrerId], [ForPickUpTime], [Discount], [DriverId], [DriverLat], [DriverLon], [AdditionalFee], [ChangeAddress], [ChangeAddressLat], [ChangeAddressLon], [ChangeAddressTitle], [IsChangeAddress], [IsChangeAddressAccepted], [IsArchive], [IsDriverArchive]) VALUES (8, N'4bb79503-6655-499a-911a-2c7fcefd0df8', N'fa1ddca8-4ead-4799-ac9e-18ec51e72d8b', CAST(N'2023-08-20 22:55:09.4500000' AS DateTime2), N'home', 16.49, 11, 0, 0, N'Delivered', CAST(N'2023-08-20 22:55:09.4566667' AS DateTime2), NULL, CAST(N'2023-08-21 15:51:27.9700000' AS DateTime2), CAST(N'2023-08-21 15:51:35.3266667' AS DateTime2), NULL, 37.489999999999995, CAST(N'2023-08-20 22:55:16.5033333' AS DateTime2), CAST(N'2023-08-21 15:51:35.3266667' AS DateTime2), N'-18.1189842509823', N'178.463611230254', N'Home', NULL, NULL, 0, N'c471f0bf-92e6-466d-a38a-8df5a88832ff', N'-18.1235467053602', N'178.459256483643', 10, N'school', N'-18.1236473232671', N'178.459183908999', N'School', 1, 1, 0, 0)
INSERT [dbo].[Order] ([Id], [OrderId], [CustomerId], [DateGmt], [Address], [Shipping], [Total], [ModeOfPayment], [IsOngoingOrder], [Status], [PlacedTime], [ProcessingTime], [OnTheWayTime], [DeliveredTime], [CanceledTime], [GrandTotal], [CreatedAt], [UpdatedAt], [Lat], [Lon], [AddressTitle], [ReferrerId], [ForPickUpTime], [Discount], [DriverId], [DriverLat], [DriverLon], [AdditionalFee], [ChangeAddress], [ChangeAddressLat], [ChangeAddressLon], [ChangeAddressTitle], [IsChangeAddress], [IsChangeAddressAccepted], [IsArchive], [IsDriverArchive]) VALUES (10, N'f40f60ec-a179-42fd-8f49-69656572cd45', N'fa1ddca8-4ead-4799-ac9e-18ec51e72d8b', CAST(N'2023-08-21 11:42:18.5233333' AS DateTime2), N'home', 16.49, 11, 0, 0, N'Delivered', CAST(N'2023-08-21 11:42:18.5233333' AS DateTime2), NULL, CAST(N'2023-08-21 15:51:28.2466667' AS DateTime2), CAST(N'2023-08-21 15:51:45.1366667' AS DateTime2), NULL, 37.489999999999995, CAST(N'2023-08-21 11:42:21.8866667' AS DateTime2), CAST(N'2023-08-21 15:51:45.7133333' AS DateTime2), N'-18.1189842509823', N'178.463611230254', N'Home', NULL, NULL, 0, N'c471f0bf-92e6-466d-a38a-8df5a88832ff', N'-18.1235525648', N'178.459255790043', 10, N'other', N'-18.121447722234', N'178.4594816342', N'Others', 1, 1, 0, 0)
INSERT [dbo].[Order] ([Id], [OrderId], [CustomerId], [DateGmt], [Address], [Shipping], [Total], [ModeOfPayment], [IsOngoingOrder], [Status], [PlacedTime], [ProcessingTime], [OnTheWayTime], [DeliveredTime], [CanceledTime], [GrandTotal], [CreatedAt], [UpdatedAt], [Lat], [Lon], [AddressTitle], [ReferrerId], [ForPickUpTime], [Discount], [DriverId], [DriverLat], [DriverLon], [AdditionalFee], [ChangeAddress], [ChangeAddressLat], [ChangeAddressLon], [ChangeAddressTitle], [IsChangeAddress], [IsChangeAddressAccepted], [IsArchive], [IsDriverArchive]) VALUES (11, N'f7bcb121-9074-4cbb-8565-9a32124bcbd2', N'fa1ddca8-4ead-4799-ac9e-18ec51e72d8b', CAST(N'2023-08-21 15:52:29.7266667' AS DateTime2), N'other', 22.67, 24, 0, 0, N'Delivered', CAST(N'2023-08-21 15:52:29.7266667' AS DateTime2), NULL, CAST(N'2023-08-21 21:21:37.4533333' AS DateTime2), CAST(N'2023-08-22 07:33:02.3333333' AS DateTime2), NULL, 56.67, CAST(N'2023-08-21 15:52:33.5900000' AS DateTime2), CAST(N'2023-08-22 07:33:07.7500000' AS DateTime2), N'-18.121447722234', N'178.4594816342', N'Others', NULL, NULL, 0, N'c471f0bf-92e6-466d-a38a-8df5a88832ff', N'-18.1235148108714', N'178.459183770193', 10, N'school', N'-18.1236473232671', N'178.459183908999', N'School', 1, 1, 0, 0)
INSERT [dbo].[Order] ([Id], [OrderId], [CustomerId], [DateGmt], [Address], [Shipping], [Total], [ModeOfPayment], [IsOngoingOrder], [Status], [PlacedTime], [ProcessingTime], [OnTheWayTime], [DeliveredTime], [CanceledTime], [GrandTotal], [CreatedAt], [UpdatedAt], [Lat], [Lon], [AddressTitle], [ReferrerId], [ForPickUpTime], [Discount], [DriverId], [DriverLat], [DriverLon], [AdditionalFee], [ChangeAddress], [ChangeAddressLat], [ChangeAddressLon], [ChangeAddressTitle], [IsChangeAddress], [IsChangeAddressAccepted], [IsArchive], [IsDriverArchive]) VALUES (12, N'1290ecac-00d5-4e1f-a07e-353e6eb095a6', N'fa1ddca8-4ead-4799-ac9e-18ec51e72d8b', CAST(N'2023-08-22 07:35:40.7100000' AS DateTime2), N'school', 26.47, 22, 0, 0, N'Placed', CAST(N'2023-08-22 07:35:40.7200000' AS DateTime2), NULL, NULL, NULL, NULL, 48.47, CAST(N'2023-08-22 07:35:45.0766667' AS DateTime2), CAST(N'2023-08-22 07:36:30.0733333' AS DateTime2), N'-18.1236473232671', N'178.459183908999', N'School', NULL, NULL, 0, N'c471f0bf-92e6-466d-a38a-8df5a88832ff', N'-18.1235123432571', N'178.459187487492', NULL, NULL, NULL, NULL, NULL, 0, 0, 0, 0)
INSERT [dbo].[Order] ([Id], [OrderId], [CustomerId], [DateGmt], [Address], [Shipping], [Total], [ModeOfPayment], [IsOngoingOrder], [Status], [PlacedTime], [ProcessingTime], [OnTheWayTime], [DeliveredTime], [CanceledTime], [GrandTotal], [CreatedAt], [UpdatedAt], [Lat], [Lon], [AddressTitle], [ReferrerId], [ForPickUpTime], [Discount], [DriverId], [DriverLat], [DriverLon], [AdditionalFee], [ChangeAddress], [ChangeAddressLat], [ChangeAddressLon], [ChangeAddressTitle], [IsChangeAddress], [IsChangeAddressAccepted], [IsArchive], [IsDriverArchive]) VALUES (13, N'df784f55-0118-4e66-b827-b7c7e353e648', N'fa1ddca8-4ead-4799-ac9e-18ec51e72d8b', CAST(N'2023-08-22 07:39:29.4566667' AS DateTime2), N'school', 26.47, 22, 0, 0, N'Cancelled', CAST(N'2023-08-22 07:39:29.4566667' AS DateTime2), NULL, CAST(N'2023-08-22 07:41:55.3200000' AS DateTime2), CAST(N'2023-08-22 07:42:02.0100000' AS DateTime2), NULL, 58.47, CAST(N'2023-08-22 07:39:33.1000000' AS DateTime2), CAST(N'2023-08-22 07:42:02.0100000' AS DateTime2), N'-18.1236473232671', N'178.459183908999', N'School', NULL, NULL, 0, N'c471f0bf-92e6-466d-a38a-8df5a88832ff', N'-18.1234669179844', N'178.459178640329', 10, N'home', N'-18.1189842509823', N'178.463611230254', N'Home', 1, 1, 0, 0)
INSERT [dbo].[Order] ([Id], [OrderId], [CustomerId], [DateGmt], [Address], [Shipping], [Total], [ModeOfPayment], [IsOngoingOrder], [Status], [PlacedTime], [ProcessingTime], [OnTheWayTime], [DeliveredTime], [CanceledTime], [GrandTotal], [CreatedAt], [UpdatedAt], [Lat], [Lon], [AddressTitle], [ReferrerId], [ForPickUpTime], [Discount], [DriverId], [DriverLat], [DriverLon], [AdditionalFee], [ChangeAddress], [ChangeAddressLat], [ChangeAddressLon], [ChangeAddressTitle], [IsChangeAddress], [IsChangeAddressAccepted], [IsArchive], [IsDriverArchive]) VALUES (14, N'a0544ca0-4544-4abf-b1fb-506d82bd34fb', N'fa1ddca8-4ead-4799-ac9e-18ec51e72d8b', CAST(N'2023-08-22 07:49:36.3266667' AS DateTime2), N'home', 16.49, 77, 0, 0, N'Cancelled', CAST(N'2023-08-22 07:49:36.3333333' AS DateTime2), NULL, CAST(N'2023-08-22 07:52:06.3033333' AS DateTime2), CAST(N'2023-08-22 08:15:46.5133333' AS DateTime2), NULL, 103.49, CAST(N'2023-08-22 07:49:40.0466667' AS DateTime2), CAST(N'2023-08-22 08:15:46.5133333' AS DateTime2), N'-18.1189842509823', N'178.463611230254', N'Home', NULL, NULL, 0, N'c471f0bf-92e6-466d-a38a-8df5a88832ff', N'-18.1235419745564', N'178.459167902277', 10, N'school', N'-18.1236473232671', N'178.459183908999', N'School', 1, 1, 0, 0)
INSERT [dbo].[Order] ([Id], [OrderId], [CustomerId], [DateGmt], [Address], [Shipping], [Total], [ModeOfPayment], [IsOngoingOrder], [Status], [PlacedTime], [ProcessingTime], [OnTheWayTime], [DeliveredTime], [CanceledTime], [GrandTotal], [CreatedAt], [UpdatedAt], [Lat], [Lon], [AddressTitle], [ReferrerId], [ForPickUpTime], [Discount], [DriverId], [DriverLat], [DriverLon], [AdditionalFee], [ChangeAddress], [ChangeAddressLat], [ChangeAddressLon], [ChangeAddressTitle], [IsChangeAddress], [IsChangeAddressAccepted], [IsArchive], [IsDriverArchive]) VALUES (15, N'be7f22e6-00d3-433c-91b0-e46e65e4fb33', N'fa1ddca8-4ead-4799-ac9e-18ec51e72d8b', CAST(N'2023-08-22 08:37:44.2900000' AS DateTime2), N'home', 16.49, 140, 0, 0, N'Delivered', CAST(N'2023-08-22 08:37:44.2900000' AS DateTime2), NULL, CAST(N'2023-08-23 10:28:55.8566667' AS DateTime2), CAST(N'2023-08-23 10:29:12.2400000' AS DateTime2), NULL, 156.49, CAST(N'2023-08-22 08:37:48.2900000' AS DateTime2), CAST(N'2023-08-23 10:29:12.2400000' AS DateTime2), N'-18.1189842509823', N'178.463611230254', N'Home', NULL, NULL, 0, N'c471f0bf-92e6-466d-a38a-8df5a88832ff', N'-18.1233880519354', N'178.458958320379', NULL, NULL, NULL, NULL, NULL, 0, 0, 0, 0)
INSERT [dbo].[Order] ([Id], [OrderId], [CustomerId], [DateGmt], [Address], [Shipping], [Total], [ModeOfPayment], [IsOngoingOrder], [Status], [PlacedTime], [ProcessingTime], [OnTheWayTime], [DeliveredTime], [CanceledTime], [GrandTotal], [CreatedAt], [UpdatedAt], [Lat], [Lon], [AddressTitle], [ReferrerId], [ForPickUpTime], [Discount], [DriverId], [DriverLat], [DriverLon], [AdditionalFee], [ChangeAddress], [ChangeAddressLat], [ChangeAddressLon], [ChangeAddressTitle], [IsChangeAddress], [IsChangeAddressAccepted], [IsArchive], [IsDriverArchive]) VALUES (16, N'd14b5030-8645-4e23-9b25-c27f86b1bf8d', N'dfee830d-3cd1-4a3e-b928-9cc04acd2192', CAST(N'2023-08-22 18:43:59.3333333' AS DateTime2), N'kalabu tax free zone', 35.47, 8, 0, 0, N'Cancelled', CAST(N'2023-08-22 18:43:59.3333333' AS DateTime2), NULL, CAST(N'2023-08-26 23:13:37.9000000' AS DateTime2), CAST(N'2023-08-26 23:14:34.4166667' AS DateTime2), NULL, 52.67, CAST(N'2023-08-22 18:43:59.8300000' AS DateTime2), CAST(N'2023-08-26 23:14:34.4166667' AS DateTime2), N'-18.0908527831406', N'178.482055440545', N'Work', NULL, NULL, -0.8, N'b1df6432-282c-4e47-a16e-fa940c9c5f29', N'-18.106674', N'178.4501662', 10, N'Statham campus', N'-18.0908527831406', N'178.482055440545', N'Others', 1, 1, 1, 1)
INSERT [dbo].[Order] ([Id], [OrderId], [CustomerId], [DateGmt], [Address], [Shipping], [Total], [ModeOfPayment], [IsOngoingOrder], [Status], [PlacedTime], [ProcessingTime], [OnTheWayTime], [DeliveredTime], [CanceledTime], [GrandTotal], [CreatedAt], [UpdatedAt], [Lat], [Lon], [AddressTitle], [ReferrerId], [ForPickUpTime], [Discount], [DriverId], [DriverLat], [DriverLon], [AdditionalFee], [ChangeAddress], [ChangeAddressLat], [ChangeAddressLon], [ChangeAddressTitle], [IsChangeAddress], [IsChangeAddressAccepted], [IsArchive], [IsDriverArchive]) VALUES (17, N'3a8461da-1663-4ba1-9d90-e69b27ae0469', N'dfee830d-3cd1-4a3e-b928-9cc04acd2192', CAST(N'2023-08-22 18:46:58.8900000' AS DateTime2), N'Sevuka place', 0, 25, 3, 1, N'Placed', CAST(N'2023-08-22 18:46:58.8900000' AS DateTime2), NULL, NULL, NULL, NULL, 35, CAST(N'2023-08-22 18:46:59.0400000' AS DateTime2), CAST(N'2023-08-24 19:55:15.9400000' AS DateTime2), N'-18.1065481471576', N'178.450278304517', N'Home', NULL, NULL, 0, NULL, NULL, NULL, 10, N'kalabu tax free zone', N'-18.0908527831406', N'178.482055440545', N'Work', 1, 0, 0, 0)
INSERT [dbo].[Order] ([Id], [OrderId], [CustomerId], [DateGmt], [Address], [Shipping], [Total], [ModeOfPayment], [IsOngoingOrder], [Status], [PlacedTime], [ProcessingTime], [OnTheWayTime], [DeliveredTime], [CanceledTime], [GrandTotal], [CreatedAt], [UpdatedAt], [Lat], [Lon], [AddressTitle], [ReferrerId], [ForPickUpTime], [Discount], [DriverId], [DriverLat], [DriverLon], [AdditionalFee], [ChangeAddress], [ChangeAddressLat], [ChangeAddressLon], [ChangeAddressTitle], [IsChangeAddress], [IsChangeAddressAccepted], [IsArchive], [IsDriverArchive]) VALUES (18, N'b2fc85af-5bcf-402d-b08d-2fda1d49759c', N'dfee830d-3cd1-4a3e-b928-9cc04acd2192', CAST(N'2023-08-22 18:48:09.4266667' AS DateTime2), N'Sevuka place', 50.86, 32, 0, 0, N'Cancelled', CAST(N'2023-08-22 18:48:09.4266667' AS DateTime2), NULL, CAST(N'2023-08-24 19:39:53.0300000' AS DateTime2), CAST(N'2023-08-24 19:40:08.8566667' AS DateTime2), NULL, 92.86, CAST(N'2023-08-22 18:48:09.5866667' AS DateTime2), CAST(N'2023-08-24 19:40:08.8566667' AS DateTime2), N'-18.1065481471576', N'178.450278304517', N'Home', NULL, NULL, 0, N'b1df6432-282c-4e47-a16e-fa940c9c5f29', N'-18.1066724', N'178.4501592', 10, N'kalabu tax free zone', N'-18.0908527831406', N'178.482055440545', N'Work', 1, 1, 1, 1)
INSERT [dbo].[Order] ([Id], [OrderId], [CustomerId], [DateGmt], [Address], [Shipping], [Total], [ModeOfPayment], [IsOngoingOrder], [Status], [PlacedTime], [ProcessingTime], [OnTheWayTime], [DeliveredTime], [CanceledTime], [GrandTotal], [CreatedAt], [UpdatedAt], [Lat], [Lon], [AddressTitle], [ReferrerId], [ForPickUpTime], [Discount], [DriverId], [DriverLat], [DriverLon], [AdditionalFee], [ChangeAddress], [ChangeAddressLat], [ChangeAddressLon], [ChangeAddressTitle], [IsChangeAddress], [IsChangeAddressAccepted], [IsArchive], [IsDriverArchive]) VALUES (19, N'42fdeb60-b2da-4456-a1fa-5907c2906dde', N'fa1ddca8-4ead-4799-ac9e-18ec51e72d8b', CAST(N'2023-08-23 05:10:14.2133333' AS DateTime2), N'other', 22.67, 22, 0, 0, N'Cancelled', CAST(N'2023-08-23 05:10:14.2133333' AS DateTime2), NULL, CAST(N'2023-08-23 10:28:56.1200000' AS DateTime2), CAST(N'2023-08-23 10:29:20.6700000' AS DateTime2), NULL, 44.67, CAST(N'2023-08-23 05:10:19.3033333' AS DateTime2), CAST(N'2023-08-23 10:29:20.6700000' AS DateTime2), N'-18.121447722234', N'178.4594816342', N'Others', NULL, NULL, 0, N'c471f0bf-92e6-466d-a38a-8df5a88832ff', N'-18.1233872976462', N'178.458959307652', NULL, NULL, NULL, NULL, NULL, 0, 0, 0, 0)
INSERT [dbo].[Order] ([Id], [OrderId], [CustomerId], [DateGmt], [Address], [Shipping], [Total], [ModeOfPayment], [IsOngoingOrder], [Status], [PlacedTime], [ProcessingTime], [OnTheWayTime], [DeliveredTime], [CanceledTime], [GrandTotal], [CreatedAt], [UpdatedAt], [Lat], [Lon], [AddressTitle], [ReferrerId], [ForPickUpTime], [Discount], [DriverId], [DriverLat], [DriverLon], [AdditionalFee], [ChangeAddress], [ChangeAddressLat], [ChangeAddressLon], [ChangeAddressTitle], [IsChangeAddress], [IsChangeAddressAccepted], [IsArchive], [IsDriverArchive]) VALUES (20, N'a68d234a-8e7e-4551-8886-0b1dae62e53f', N'fa1ddca8-4ead-4799-ac9e-18ec51e72d8b', CAST(N'2023-08-23 07:06:45.8566667' AS DateTime2), N'school', 26.47, 12, 0, 0, N'Cancelled', CAST(N'2023-08-23 07:06:45.8566667' AS DateTime2), NULL, CAST(N'2023-08-23 10:28:56.3800000' AS DateTime2), CAST(N'2023-08-23 10:29:27.2633333' AS DateTime2), NULL, 38.47, CAST(N'2023-08-23 07:06:50.6933333' AS DateTime2), CAST(N'2023-08-23 10:29:27.2633333' AS DateTime2), N'-18.1236473232671', N'178.459183908999', N'School', NULL, NULL, 0, N'c471f0bf-92e6-466d-a38a-8df5a88832ff', N'-18.1233917737844', N'178.458956826761', NULL, NULL, NULL, NULL, NULL, 0, 0, 0, 0)
INSERT [dbo].[Order] ([Id], [OrderId], [CustomerId], [DateGmt], [Address], [Shipping], [Total], [ModeOfPayment], [IsOngoingOrder], [Status], [PlacedTime], [ProcessingTime], [OnTheWayTime], [DeliveredTime], [CanceledTime], [GrandTotal], [CreatedAt], [UpdatedAt], [Lat], [Lon], [AddressTitle], [ReferrerId], [ForPickUpTime], [Discount], [DriverId], [DriverLat], [DriverLon], [AdditionalFee], [ChangeAddress], [ChangeAddressLat], [ChangeAddressLon], [ChangeAddressTitle], [IsChangeAddress], [IsChangeAddressAccepted], [IsArchive], [IsDriverArchive]) VALUES (21, N'000d8896-7757-49a2-a623-799b57146958', N'fa1ddca8-4ead-4799-ac9e-18ec51e72d8b', CAST(N'2023-08-23 10:27:51.6900000' AS DateTime2), N'other', 22.67, 11, 0, 0, N'Cancelled', CAST(N'2023-08-23 10:27:51.6900000' AS DateTime2), NULL, CAST(N'2023-08-23 10:28:56.6366667' AS DateTime2), CAST(N'2023-08-23 10:29:37.0333333' AS DateTime2), NULL, 33.67, CAST(N'2023-08-23 10:27:57.0100000' AS DateTime2), CAST(N'2023-08-23 10:29:38.3400000' AS DateTime2), N'-18.121447722234', N'178.4594816342', N'Others', NULL, NULL, 0, N'c471f0bf-92e6-466d-a38a-8df5a88832ff', N'-18.1233965256379', N'178.458959163759', NULL, NULL, NULL, NULL, NULL, 0, 0, 0, 0)
INSERT [dbo].[Order] ([Id], [OrderId], [CustomerId], [DateGmt], [Address], [Shipping], [Total], [ModeOfPayment], [IsOngoingOrder], [Status], [PlacedTime], [ProcessingTime], [OnTheWayTime], [DeliveredTime], [CanceledTime], [GrandTotal], [CreatedAt], [UpdatedAt], [Lat], [Lon], [AddressTitle], [ReferrerId], [ForPickUpTime], [Discount], [DriverId], [DriverLat], [DriverLon], [AdditionalFee], [ChangeAddress], [ChangeAddressLat], [ChangeAddressLon], [ChangeAddressTitle], [IsChangeAddress], [IsChangeAddressAccepted], [IsArchive], [IsDriverArchive]) VALUES (22, N'3921f73c-7b33-43f4-bd44-6d792656a0a3', N'fa1ddca8-4ead-4799-ac9e-18ec51e72d8b', CAST(N'2023-08-23 10:30:25.0566667' AS DateTime2), N'home', 16.49, 12, 0, 0, N'Delivered', CAST(N'2023-08-23 10:30:25.0566667' AS DateTime2), NULL, CAST(N'2023-08-24 04:36:08.4800000' AS DateTime2), CAST(N'2023-08-24 04:39:49.6700000' AS DateTime2), NULL, 28.49, CAST(N'2023-08-23 10:30:30.4033333' AS DateTime2), CAST(N'2023-08-24 04:39:49.6700000' AS DateTime2), N'-18.1189842509823', N'178.463611230254', N'Home', NULL, NULL, 0, N'c471f0bf-92e6-466d-a38a-8df5a88832ff', N'-18.1235802600461', N'178.459110537713', NULL, NULL, NULL, NULL, NULL, 0, 0, 0, 0)
INSERT [dbo].[Order] ([Id], [OrderId], [CustomerId], [DateGmt], [Address], [Shipping], [Total], [ModeOfPayment], [IsOngoingOrder], [Status], [PlacedTime], [ProcessingTime], [OnTheWayTime], [DeliveredTime], [CanceledTime], [GrandTotal], [CreatedAt], [UpdatedAt], [Lat], [Lon], [AddressTitle], [ReferrerId], [ForPickUpTime], [Discount], [DriverId], [DriverLat], [DriverLon], [AdditionalFee], [ChangeAddress], [ChangeAddressLat], [ChangeAddressLon], [ChangeAddressTitle], [IsChangeAddress], [IsChangeAddressAccepted], [IsArchive], [IsDriverArchive]) VALUES (23, N'438ffdc9-352e-4bb1-9bd6-e4f076c1b7c3', N'fa1ddca8-4ead-4799-ac9e-18ec51e72d8b', CAST(N'2023-08-23 12:34:53.1066667' AS DateTime2), N'home', 16.49, 12, 0, 0, N'Delivered', CAST(N'2023-08-23 12:34:53.1066667' AS DateTime2), NULL, CAST(N'2023-08-24 16:51:58.3266667' AS DateTime2), CAST(N'2023-08-24 16:52:02.9933333' AS DateTime2), NULL, 38.489999999999995, CAST(N'2023-08-23 12:34:58.7466667' AS DateTime2), CAST(N'2023-08-24 16:52:05.3566667' AS DateTime2), N'-18.1189842509823', N'178.463611230254', N'Home', NULL, NULL, 0, N'c471f0bf-92e6-466d-a38a-8df5a88832ff', N'-18.1235920086816', N'178.459129789763', 10, N'school', N'-18.1236473232671', N'178.459183908999', N'School', 1, 1, 0, 0)
INSERT [dbo].[Order] ([Id], [OrderId], [CustomerId], [DateGmt], [Address], [Shipping], [Total], [ModeOfPayment], [IsOngoingOrder], [Status], [PlacedTime], [ProcessingTime], [OnTheWayTime], [DeliveredTime], [CanceledTime], [GrandTotal], [CreatedAt], [UpdatedAt], [Lat], [Lon], [AddressTitle], [ReferrerId], [ForPickUpTime], [Discount], [DriverId], [DriverLat], [DriverLon], [AdditionalFee], [ChangeAddress], [ChangeAddressLat], [ChangeAddressLon], [ChangeAddressTitle], [IsChangeAddress], [IsChangeAddressAccepted], [IsArchive], [IsDriverArchive]) VALUES (24, N'5593710f-82d2-4e80-bd22-befdd9bdd44d', N'fa1ddca8-4ead-4799-ac9e-18ec51e72d8b', CAST(N'2023-08-24 16:49:54.8600000' AS DateTime2), N'other', 22.67, 24, 0, 0, N'Delivered', CAST(N'2023-08-24 16:49:54.8600000' AS DateTime2), NULL, CAST(N'2023-08-26 21:50:06.6933333' AS DateTime2), CAST(N'2023-08-26 21:50:16.4800000' AS DateTime2), NULL, 46.67, CAST(N'2023-08-24 16:49:59.5233333' AS DateTime2), CAST(N'2023-08-26 21:50:16.4800000' AS DateTime2), N'-18.121447722234', N'178.4594816342', N'Others', NULL, NULL, 0, N'c471f0bf-92e6-466d-a38a-8df5a88832ff', N'-18.1214344974678', N'178.459488717044', NULL, NULL, NULL, NULL, NULL, 0, 0, 0, 0)
INSERT [dbo].[Order] ([Id], [OrderId], [CustomerId], [DateGmt], [Address], [Shipping], [Total], [ModeOfPayment], [IsOngoingOrder], [Status], [PlacedTime], [ProcessingTime], [OnTheWayTime], [DeliveredTime], [CanceledTime], [GrandTotal], [CreatedAt], [UpdatedAt], [Lat], [Lon], [AddressTitle], [ReferrerId], [ForPickUpTime], [Discount], [DriverId], [DriverLat], [DriverLon], [AdditionalFee], [ChangeAddress], [ChangeAddressLat], [ChangeAddressLon], [ChangeAddressTitle], [IsChangeAddress], [IsChangeAddressAccepted], [IsArchive], [IsDriverArchive]) VALUES (25, N'4183d47d-3faf-4cb9-bcde-300555876943', N'dfee830d-3cd1-4a3e-b928-9cc04acd2192', CAST(N'2023-08-24 19:38:52.7733333' AS DateTime2), N'Statham campus', 35.47, 14, 0, 0, N'Delivered', CAST(N'2023-08-24 19:38:52.7733333' AS DateTime2), NULL, CAST(N'2023-08-26 23:11:46.5000000' AS DateTime2), CAST(N'2023-08-26 23:12:30.2366667' AS DateTime2), NULL, 59.47, CAST(N'2023-08-24 19:38:54.3866667' AS DateTime2), CAST(N'2023-08-26 23:12:30.2366667' AS DateTime2), N'-18.0908527831406', N'178.482055440545', N'Others', NULL, NULL, 0, N'b1df6432-282c-4e47-a16e-fa940c9c5f29', N'-18.1066713', N'178.4501657', 10, N'Statham Home', N'-18.0908527831406', N'178.482055440545', N'School', 1, 1, 1, 1)
INSERT [dbo].[Order] ([Id], [OrderId], [CustomerId], [DateGmt], [Address], [Shipping], [Total], [ModeOfPayment], [IsOngoingOrder], [Status], [PlacedTime], [ProcessingTime], [OnTheWayTime], [DeliveredTime], [CanceledTime], [GrandTotal], [CreatedAt], [UpdatedAt], [Lat], [Lon], [AddressTitle], [ReferrerId], [ForPickUpTime], [Discount], [DriverId], [DriverLat], [DriverLon], [AdditionalFee], [ChangeAddress], [ChangeAddressLat], [ChangeAddressLon], [ChangeAddressTitle], [IsChangeAddress], [IsChangeAddressAccepted], [IsArchive], [IsDriverArchive]) VALUES (26, N'02493b24-dcb5-43bc-8983-3dc24e7e2b92', N'fa1ddca8-4ead-4799-ac9e-18ec51e72d8b', CAST(N'2023-08-25 11:12:03.1900000' AS DateTime2), N'home', 16.49, 41, 0, 0, N'Cancelled', CAST(N'2023-08-25 11:12:03.1900000' AS DateTime2), NULL, CAST(N'2023-08-26 21:50:06.9600000' AS DateTime2), CAST(N'2023-08-26 21:50:26.4700000' AS DateTime2), NULL, 67.490000000000009, CAST(N'2023-08-25 11:12:11.5800000' AS DateTime2), CAST(N'2023-08-26 21:50:26.4700000' AS DateTime2), N'-18.1189842509823', N'178.463611230254', N'Home', NULL, NULL, 0, N'c471f0bf-92e6-466d-a38a-8df5a88832ff', N'-18.1214347454746', N'178.45948652269', 10, N'school', N'-18.1236473232671', N'178.459183908999', N'School', 1, 1, 0, 0)
INSERT [dbo].[Order] ([Id], [OrderId], [CustomerId], [DateGmt], [Address], [Shipping], [Total], [ModeOfPayment], [IsOngoingOrder], [Status], [PlacedTime], [ProcessingTime], [OnTheWayTime], [DeliveredTime], [CanceledTime], [GrandTotal], [CreatedAt], [UpdatedAt], [Lat], [Lon], [AddressTitle], [ReferrerId], [ForPickUpTime], [Discount], [DriverId], [DriverLat], [DriverLon], [AdditionalFee], [ChangeAddress], [ChangeAddressLat], [ChangeAddressLon], [ChangeAddressTitle], [IsChangeAddress], [IsChangeAddressAccepted], [IsArchive], [IsDriverArchive]) VALUES (27, N'1037d121-3fae-4692-ab19-83f44aaa7e01', N'fa1ddca8-4ead-4799-ac9e-18ec51e72d8b', CAST(N'2023-08-26 05:19:12.6700000' AS DateTime2), N'otherz', 22.67, 20, 0, 0, N'Delivered', CAST(N'2023-08-26 05:19:12.6700000' AS DateTime2), NULL, CAST(N'2023-08-26 23:13:38.2666667' AS DateTime2), CAST(N'2023-08-26 23:14:23.8400000' AS DateTime2), NULL, 42.67, CAST(N'2023-08-26 05:19:18.6233333' AS DateTime2), CAST(N'2023-08-26 23:14:23.8400000' AS DateTime2), N'-18.121447722234', N'178.4594816342', N'Others', NULL, NULL, 0, N'b1df6432-282c-4e47-a16e-fa940c9c5f29', N'-18.1066718', N'178.4501656', NULL, NULL, NULL, NULL, NULL, 0, 0, 0, 1)
INSERT [dbo].[Order] ([Id], [OrderId], [CustomerId], [DateGmt], [Address], [Shipping], [Total], [ModeOfPayment], [IsOngoingOrder], [Status], [PlacedTime], [ProcessingTime], [OnTheWayTime], [DeliveredTime], [CanceledTime], [GrandTotal], [CreatedAt], [UpdatedAt], [Lat], [Lon], [AddressTitle], [ReferrerId], [ForPickUpTime], [Discount], [DriverId], [DriverLat], [DriverLon], [AdditionalFee], [ChangeAddress], [ChangeAddressLat], [ChangeAddressLon], [ChangeAddressTitle], [IsChangeAddress], [IsChangeAddressAccepted], [IsArchive], [IsDriverArchive]) VALUES (28, N'c2043015-829b-4b9a-aadf-c4bc8f9bef1c', N'dfee830d-3cd1-4a3e-b928-9cc04acd2192', CAST(N'2023-08-26 23:19:52.0133333' AS DateTime2), N'Kids School', 35.47, 32, 0, 0, N'Delivered', CAST(N'2023-08-26 23:19:52.0133333' AS DateTime2), NULL, CAST(N'2023-08-29 18:16:59.7666667' AS DateTime2), CAST(N'2023-08-29 18:17:46.4966667' AS DateTime2), NULL, 67.47, CAST(N'2023-08-26 23:19:52.6700000' AS DateTime2), CAST(N'2023-08-29 18:17:46.4966667' AS DateTime2), N'-18.1455035396092', N'178.436988964677', N'School', NULL, NULL, 0, N'b1df6432-282c-4e47-a16e-fa940c9c5f29', N'-18.106671', N'178.4501623', NULL, NULL, NULL, NULL, NULL, 0, 0, 1, 1)
INSERT [dbo].[Order] ([Id], [OrderId], [CustomerId], [DateGmt], [Address], [Shipping], [Total], [ModeOfPayment], [IsOngoingOrder], [Status], [PlacedTime], [ProcessingTime], [OnTheWayTime], [DeliveredTime], [CanceledTime], [GrandTotal], [CreatedAt], [UpdatedAt], [Lat], [Lon], [AddressTitle], [ReferrerId], [ForPickUpTime], [Discount], [DriverId], [DriverLat], [DriverLon], [AdditionalFee], [ChangeAddress], [ChangeAddressLat], [ChangeAddressLon], [ChangeAddressTitle], [IsChangeAddress], [IsChangeAddressAccepted], [IsArchive], [IsDriverArchive]) VALUES (29, N'9880133a-17e3-4fc0-88ed-26163c4566da', N'fa1ddca8-4ead-4799-ac9e-18ec51e72d8b', CAST(N'2023-08-27 00:25:45.9066667' AS DateTime2), N'otherz', 22.67, 16, 0, 0, N'Cancelled', CAST(N'2023-08-27 00:25:45.9066667' AS DateTime2), NULL, CAST(N'2023-08-27 02:07:35.6900000' AS DateTime2), CAST(N'2023-08-27 02:07:47.6666667' AS DateTime2), NULL, 38.67, CAST(N'2023-08-27 00:25:53.7033333' AS DateTime2), CAST(N'2023-08-27 02:07:47.6666667' AS DateTime2), N'-18.121447722234', N'178.4594816342', N'Others', NULL, NULL, 0, N'c471f0bf-92e6-466d-a38a-8df5a88832ff', N'-18.1215519426549', N'178.459518194466', NULL, NULL, NULL, NULL, NULL, 0, 0, 0, 0)
INSERT [dbo].[Order] ([Id], [OrderId], [CustomerId], [DateGmt], [Address], [Shipping], [Total], [ModeOfPayment], [IsOngoingOrder], [Status], [PlacedTime], [ProcessingTime], [OnTheWayTime], [DeliveredTime], [CanceledTime], [GrandTotal], [CreatedAt], [UpdatedAt], [Lat], [Lon], [AddressTitle], [ReferrerId], [ForPickUpTime], [Discount], [DriverId], [DriverLat], [DriverLon], [AdditionalFee], [ChangeAddress], [ChangeAddressLat], [ChangeAddressLon], [ChangeAddressTitle], [IsChangeAddress], [IsChangeAddressAccepted], [IsArchive], [IsDriverArchive]) VALUES (30, N'8034aa27-19c6-4cbd-ad40-597b53859f23', N'fa1ddca8-4ead-4799-ac9e-18ec51e72d8b', CAST(N'2023-08-27 01:41:51.2933333' AS DateTime2), N'homex', 25.02, 11, 0, 0, N'Cancelled', CAST(N'2023-08-27 01:41:51.2933333' AS DateTime2), NULL, CAST(N'2023-08-27 02:16:28.5200000' AS DateTime2), CAST(N'2023-08-27 02:16:38.9266667' AS DateTime2), NULL, 36.02, CAST(N'2023-08-27 01:41:59.0600000' AS DateTime2), CAST(N'2023-08-27 02:16:38.9266667' AS DateTime2), N'-18.1145046021085', N'178.462183959782', N'Home', NULL, NULL, 0, N'c471f0bf-92e6-466d-a38a-8df5a88832ff', N'-18.1215553061286', N'178.459528814397', NULL, NULL, NULL, NULL, NULL, 0, 0, 0, 0)
INSERT [dbo].[Order] ([Id], [OrderId], [CustomerId], [DateGmt], [Address], [Shipping], [Total], [ModeOfPayment], [IsOngoingOrder], [Status], [PlacedTime], [ProcessingTime], [OnTheWayTime], [DeliveredTime], [CanceledTime], [GrandTotal], [CreatedAt], [UpdatedAt], [Lat], [Lon], [AddressTitle], [ReferrerId], [ForPickUpTime], [Discount], [DriverId], [DriverLat], [DriverLon], [AdditionalFee], [ChangeAddress], [ChangeAddressLat], [ChangeAddressLon], [ChangeAddressTitle], [IsChangeAddress], [IsChangeAddressAccepted], [IsArchive], [IsDriverArchive]) VALUES (31, N'b92b78cf-64d0-4c4a-a4ba-144b54a614d2', N'fa1ddca8-4ead-4799-ac9e-18ec51e72d8b', CAST(N'2023-08-27 07:06:56.4200000' AS DateTime2), N'homex', 25.02, 22, 0, 0, N'Cancelled', CAST(N'2023-08-27 07:06:56.4300000' AS DateTime2), NULL, CAST(N'2023-08-31 14:07:37.2733333' AS DateTime2), CAST(N'2023-08-31 14:07:47.2366667' AS DateTime2), NULL, 47.02, CAST(N'2023-08-27 07:07:06.1766667' AS DateTime2), CAST(N'2023-08-31 14:07:47.2366667' AS DateTime2), N'-18.1145046021085', N'178.462183959782', N'Home', NULL, NULL, 0, N'c471f0bf-92e6-466d-a38a-8df5a88832ff', N'-18.1121700136269', N'178.469244041677', NULL, NULL, NULL, NULL, NULL, 0, 0, 0, 0)
INSERT [dbo].[Order] ([Id], [OrderId], [CustomerId], [DateGmt], [Address], [Shipping], [Total], [ModeOfPayment], [IsOngoingOrder], [Status], [PlacedTime], [ProcessingTime], [OnTheWayTime], [DeliveredTime], [CanceledTime], [GrandTotal], [CreatedAt], [UpdatedAt], [Lat], [Lon], [AddressTitle], [ReferrerId], [ForPickUpTime], [Discount], [DriverId], [DriverLat], [DriverLon], [AdditionalFee], [ChangeAddress], [ChangeAddressLat], [ChangeAddressLon], [ChangeAddressTitle], [IsChangeAddress], [IsChangeAddressAccepted], [IsArchive], [IsDriverArchive]) VALUES (32, N'937934aa-5295-4f6e-87ab-e4cfa85d6a3e', N'dfee830d-3cd1-4a3e-b928-9cc04acd2192', CAST(N'2023-08-29 18:15:33.2100000' AS DateTime2), N'kalabu tax free zone', 35.47, 25, 0, 0, N'Delivered', CAST(N'2023-08-29 18:15:33.2100000' AS DateTime2), NULL, CAST(N'2023-08-30 05:10:50.0033333' AS DateTime2), CAST(N'2023-08-30 05:11:12.5566667' AS DateTime2), NULL, 60.47, CAST(N'2023-08-29 18:15:33.8966667' AS DateTime2), CAST(N'2023-08-30 05:11:13.2066667' AS DateTime2), N'-18.0908527831406', N'178.482055440545', N'Work', NULL, NULL, 0, N'b1df6432-282c-4e47-a16e-fa940c9c5f29', N'-18.0914868', N'178.4818974', NULL, NULL, NULL, NULL, NULL, 0, 0, 1, 1)
INSERT [dbo].[Order] ([Id], [OrderId], [CustomerId], [DateGmt], [Address], [Shipping], [Total], [ModeOfPayment], [IsOngoingOrder], [Status], [PlacedTime], [ProcessingTime], [OnTheWayTime], [DeliveredTime], [CanceledTime], [GrandTotal], [CreatedAt], [UpdatedAt], [Lat], [Lon], [AddressTitle], [ReferrerId], [ForPickUpTime], [Discount], [DriverId], [DriverLat], [DriverLon], [AdditionalFee], [ChangeAddress], [ChangeAddressLat], [ChangeAddressLon], [ChangeAddressTitle], [IsChangeAddress], [IsChangeAddressAccepted], [IsArchive], [IsDriverArchive]) VALUES (33, N'f01c4371-6326-4082-b243-e5b6991df0ce', N'dfee830d-3cd1-4a3e-b928-9cc04acd2192', CAST(N'2023-08-30 16:44:15.9966667' AS DateTime2), N'kalabu tax free zone', 35.47, 48, 0, 0, N'Delivered', CAST(N'2023-08-30 16:44:15.9966667' AS DateTime2), NULL, CAST(N'2023-08-30 20:15:14.4000000' AS DateTime2), CAST(N'2023-08-30 20:16:29.0100000' AS DateTime2), NULL, 83.47, CAST(N'2023-08-30 16:44:15.7200000' AS DateTime2), CAST(N'2023-08-30 20:16:30.4000000' AS DateTime2), N'-18.0908527831406', N'178.482055440545', N'Work', NULL, NULL, 0, N'b1df6432-282c-4e47-a16e-fa940c9c5f29', N'-18.0917848932342', N'178.48171624554', NULL, NULL, NULL, NULL, NULL, 0, 0, 1, 1)
INSERT [dbo].[Order] ([Id], [OrderId], [CustomerId], [DateGmt], [Address], [Shipping], [Total], [ModeOfPayment], [IsOngoingOrder], [Status], [PlacedTime], [ProcessingTime], [OnTheWayTime], [DeliveredTime], [CanceledTime], [GrandTotal], [CreatedAt], [UpdatedAt], [Lat], [Lon], [AddressTitle], [ReferrerId], [ForPickUpTime], [Discount], [DriverId], [DriverLat], [DriverLon], [AdditionalFee], [ChangeAddress], [ChangeAddressLat], [ChangeAddressLon], [ChangeAddressTitle], [IsChangeAddress], [IsChangeAddressAccepted], [IsArchive], [IsDriverArchive]) VALUES (34, N'0cb1ae18-5b8d-4c98-b199-44b40ccc731d', N'dfee830d-3cd1-4a3e-b928-9cc04acd2192', CAST(N'2023-08-31 04:39:13.7033333' AS DateTime2), N'Statham campus', 0, 16, 3, 1, N'Placed', CAST(N'2023-08-31 04:39:13.7033333' AS DateTime2), NULL, NULL, NULL, NULL, 26, CAST(N'2023-08-31 04:39:14.2100000' AS DateTime2), CAST(N'2023-08-31 04:39:56.5166667' AS DateTime2), N'-18.0908527831406', N'178.482055440545', N'Others', NULL, NULL, 0, NULL, NULL, NULL, 10, N'Sevuka place', N'-18.0908527831406', N'178.482055440545', N'Home', 1, 0, 1, 0)
INSERT [dbo].[Order] ([Id], [OrderId], [CustomerId], [DateGmt], [Address], [Shipping], [Total], [ModeOfPayment], [IsOngoingOrder], [Status], [PlacedTime], [ProcessingTime], [OnTheWayTime], [DeliveredTime], [CanceledTime], [GrandTotal], [CreatedAt], [UpdatedAt], [Lat], [Lon], [AddressTitle], [ReferrerId], [ForPickUpTime], [Discount], [DriverId], [DriverLat], [DriverLon], [AdditionalFee], [ChangeAddress], [ChangeAddressLat], [ChangeAddressLon], [ChangeAddressTitle], [IsChangeAddress], [IsChangeAddressAccepted], [IsArchive], [IsDriverArchive]) VALUES (35, N'311174e8-1133-4a22-8a0d-d1a609be3749', N'fa1ddca8-4ead-4799-ac9e-18ec51e72d8b', CAST(N'2023-08-31 08:22:15.5466667' AS DateTime2), N'blk 12 l22 halway', 26.19, 16, 0, 0, N'Delivered', CAST(N'2023-08-31 08:22:15.5466667' AS DateTime2), NULL, CAST(N'2023-09-01 06:35:45.0533333' AS DateTime2), CAST(N'2023-09-10 20:43:09.0133333' AS DateTime2), NULL, 52.19, CAST(N'2023-08-31 08:22:15.2100000' AS DateTime2), CAST(N'2023-09-10 20:43:09.0133333' AS DateTime2), N'-18.123392409309', N'178.459092378616', N'School', NULL, NULL, 0, N'b1df6432-282c-4e47-a16e-fa940c9c5f29', N'-18.0915106', N'178.4819135', 10, N'blk 13 l21 wamee', N'-18.1145046021085', N'178.462183959782', N'Home', 1, 1, 0, 1)
INSERT [dbo].[Order] ([Id], [OrderId], [CustomerId], [DateGmt], [Address], [Shipping], [Total], [ModeOfPayment], [IsOngoingOrder], [Status], [PlacedTime], [ProcessingTime], [OnTheWayTime], [DeliveredTime], [CanceledTime], [GrandTotal], [CreatedAt], [UpdatedAt], [Lat], [Lon], [AddressTitle], [ReferrerId], [ForPickUpTime], [Discount], [DriverId], [DriverLat], [DriverLon], [AdditionalFee], [ChangeAddress], [ChangeAddressLat], [ChangeAddressLon], [ChangeAddressTitle], [IsChangeAddress], [IsChangeAddressAccepted], [IsArchive], [IsDriverArchive]) VALUES (36, N'e0287748-c98b-465a-a227-32c3b866a009', N'fa1ddca8-4ead-4799-ac9e-18ec51e72d8b', CAST(N'2023-08-31 08:37:14.7500000' AS DateTime2), N'Work13321 111', 25.91, 11, 0, 0, N'Cancelled', CAST(N'2023-08-31 08:37:14.7500000' AS DateTime2), NULL, CAST(N'2023-09-01 06:35:45.3533333' AS DateTime2), CAST(N'2023-09-10 20:44:58.1900000' AS DateTime2), NULL, 46.91, CAST(N'2023-08-31 08:37:14.2766667' AS DateTime2), CAST(N'2023-09-10 20:45:00.6633333' AS DateTime2), N'-18.1234854529468', N'178.458646461368', N'Work', NULL, NULL, 0, N'b1df6432-282c-4e47-a16e-fa940c9c5f29', N'-18.0915009', N'178.4819154', 10, N'otherz 123123', N'-18.121447722234', N'178.4594816342', N'Others', 1, 1, 0, 1)
INSERT [dbo].[Order] ([Id], [OrderId], [CustomerId], [DateGmt], [Address], [Shipping], [Total], [ModeOfPayment], [IsOngoingOrder], [Status], [PlacedTime], [ProcessingTime], [OnTheWayTime], [DeliveredTime], [CanceledTime], [GrandTotal], [CreatedAt], [UpdatedAt], [Lat], [Lon], [AddressTitle], [ReferrerId], [ForPickUpTime], [Discount], [DriverId], [DriverLat], [DriverLon], [AdditionalFee], [ChangeAddress], [ChangeAddressLat], [ChangeAddressLon], [ChangeAddressTitle], [IsChangeAddress], [IsChangeAddressAccepted], [IsArchive], [IsDriverArchive]) VALUES (37, N'94bf7b58-9aa8-4b47-9ed2-eed0f91c5f04', N'fa1ddca8-4ead-4799-ac9e-18ec51e72d8b', CAST(N'2023-08-31 08:42:42.4100000' AS DateTime2), N'otherz 123123', 22.67, 54, 0, 0, N'Cancelled', CAST(N'2023-08-31 08:42:42.4100000' AS DateTime2), NULL, CAST(N'2023-08-31 14:16:17.4433333' AS DateTime2), CAST(N'2023-08-31 14:16:27.4033333' AS DateTime2), NULL, 86.67, CAST(N'2023-08-31 08:42:42.0600000' AS DateTime2), CAST(N'2023-08-31 14:16:27.5866667' AS DateTime2), N'-18.121447722234', N'178.4594816342', N'Others', NULL, NULL, 0, N'c471f0bf-92e6-466d-a38a-8df5a88832ff', N'-18.1121755974479', N'178.469240092027', 10, N'Work13321 111', N'-18.1234854529468', N'178.458646461368', N'Work', 1, 1, 0, 0)
INSERT [dbo].[Order] ([Id], [OrderId], [CustomerId], [DateGmt], [Address], [Shipping], [Total], [ModeOfPayment], [IsOngoingOrder], [Status], [PlacedTime], [ProcessingTime], [OnTheWayTime], [DeliveredTime], [CanceledTime], [GrandTotal], [CreatedAt], [UpdatedAt], [Lat], [Lon], [AddressTitle], [ReferrerId], [ForPickUpTime], [Discount], [DriverId], [DriverLat], [DriverLon], [AdditionalFee], [ChangeAddress], [ChangeAddressLat], [ChangeAddressLon], [ChangeAddressTitle], [IsChangeAddress], [IsChangeAddressAccepted], [IsArchive], [IsDriverArchive]) VALUES (38, N'6d967bc2-a675-44b1-b68e-035fe467710e', N'fa1ddca8-4ead-4799-ac9e-18ec51e72d8b', CAST(N'2023-09-01 06:33:07.1133333' AS DateTime2), N'blk 13 l21 wamee', 25.02, 32, 0, 0, N'Cancelled', CAST(N'2023-09-01 06:33:07.1133333' AS DateTime2), NULL, CAST(N'2023-09-01 10:55:32.0866667' AS DateTime2), CAST(N'2023-09-02 06:23:23.3833333' AS DateTime2), NULL, 57.02, CAST(N'2023-09-01 06:33:07.2966667' AS DateTime2), CAST(N'2023-09-02 06:23:26.3366667' AS DateTime2), N'-18.1145046021085', N'178.462183959782', N'Home', NULL, NULL, 0, N'c471f0bf-92e6-466d-a38a-8df5a88832ff', N'-18.1122795395731', N'178.469367464241', NULL, NULL, NULL, NULL, NULL, 0, 0, 0, 0)
INSERT [dbo].[Order] ([Id], [OrderId], [CustomerId], [DateGmt], [Address], [Shipping], [Total], [ModeOfPayment], [IsOngoingOrder], [Status], [PlacedTime], [ProcessingTime], [OnTheWayTime], [DeliveredTime], [CanceledTime], [GrandTotal], [CreatedAt], [UpdatedAt], [Lat], [Lon], [AddressTitle], [ReferrerId], [ForPickUpTime], [Discount], [DriverId], [DriverLat], [DriverLon], [AdditionalFee], [ChangeAddress], [ChangeAddressLat], [ChangeAddressLon], [ChangeAddressTitle], [IsChangeAddress], [IsChangeAddressAccepted], [IsArchive], [IsDriverArchive]) VALUES (39, N'70bda761-7163-44c3-8d64-65a6a3dcc5f9', N'fa1ddca8-4ead-4799-ac9e-18ec51e72d8b', CAST(N'2023-09-02 06:34:06.2333333' AS DateTime2), N'blk 13 l21 wamee', 25.02, 79, 0, 0, N'Delivered', CAST(N'2023-09-02 06:34:06.2333333' AS DateTime2), NULL, CAST(N'2023-09-02 07:34:28.2600000' AS DateTime2), CAST(N'2023-09-02 07:52:29.4233333' AS DateTime2), NULL, 104.02, CAST(N'2023-09-02 06:34:06.9366667' AS DateTime2), CAST(N'2023-09-02 07:52:31.6200000' AS DateTime2), N'-18.1145046021085', N'178.462183959782', N'Home', NULL, NULL, 0, N'c471f0bf-92e6-466d-a38a-8df5a88832ff', N'-18.1152336083079', N'178.461779265949', NULL, NULL, NULL, NULL, NULL, 0, 0, 0, 0)
INSERT [dbo].[Order] ([Id], [OrderId], [CustomerId], [DateGmt], [Address], [Shipping], [Total], [ModeOfPayment], [IsOngoingOrder], [Status], [PlacedTime], [ProcessingTime], [OnTheWayTime], [DeliveredTime], [CanceledTime], [GrandTotal], [CreatedAt], [UpdatedAt], [Lat], [Lon], [AddressTitle], [ReferrerId], [ForPickUpTime], [Discount], [DriverId], [DriverLat], [DriverLon], [AdditionalFee], [ChangeAddress], [ChangeAddressLat], [ChangeAddressLon], [ChangeAddressTitle], [IsChangeAddress], [IsChangeAddressAccepted], [IsArchive], [IsDriverArchive]) VALUES (40, N'35f9e5f5-1178-421a-8bbf-4f530c11963a', N'fa1ddca8-4ead-4799-ac9e-18ec51e72d8b', CAST(N'2023-09-02 07:54:16.2833333' AS DateTime2), N'Work13321 111', 25.91, 16, 0, 0, N'Delivered', CAST(N'2023-09-02 07:54:16.2833333' AS DateTime2), NULL, CAST(N'2023-09-02 07:55:15.2000000' AS DateTime2), CAST(N'2023-09-11 07:05:34.4400000' AS DateTime2), NULL, 41.91, CAST(N'2023-09-02 07:54:16.9000000' AS DateTime2), CAST(N'2023-09-11 07:06:19.2566667' AS DateTime2), N'-18.1234854529468', N'178.458646461368', N'Work', NULL, NULL, 0, N'c471f0bf-92e6-466d-a38a-8df5a88832ff', N'-18.1132603096514', N'178.476447686746', NULL, NULL, NULL, NULL, NULL, 0, 0, 0, 0)
INSERT [dbo].[Order] ([Id], [OrderId], [CustomerId], [DateGmt], [Address], [Shipping], [Total], [ModeOfPayment], [IsOngoingOrder], [Status], [PlacedTime], [ProcessingTime], [OnTheWayTime], [DeliveredTime], [CanceledTime], [GrandTotal], [CreatedAt], [UpdatedAt], [Lat], [Lon], [AddressTitle], [ReferrerId], [ForPickUpTime], [Discount], [DriverId], [DriverLat], [DriverLon], [AdditionalFee], [ChangeAddress], [ChangeAddressLat], [ChangeAddressLon], [ChangeAddressTitle], [IsChangeAddress], [IsChangeAddressAccepted], [IsArchive], [IsDriverArchive]) VALUES (41, N'f32d9310-b7fc-4506-a820-674d4d0a2b20', N'805762d5-4f7d-4c1f-a5de-e15405ab73c1', CAST(N'2023-09-03 17:01:58.4566667' AS DateTime2), N'home', 38.16, 20, 0, 0, N'Delivered', CAST(N'2023-09-03 17:01:58.4566667' AS DateTime2), NULL, CAST(N'2023-09-03 21:16:50.2533333' AS DateTime2), CAST(N'2023-09-10 20:44:33.0433333' AS DateTime2), NULL, 56.16, CAST(N'2023-09-03 17:01:58.4700000' AS DateTime2), CAST(N'2023-09-10 20:44:33.0433333' AS DateTime2), N'-18.1308551804094', N'178.45091432333', N'Home', NULL, NULL, -2, N'b1df6432-282c-4e47-a16e-fa940c9c5f29', N'-18.0914877', N'178.4819256', NULL, NULL, NULL, NULL, NULL, 0, 0, 0, 1)
INSERT [dbo].[Order] ([Id], [OrderId], [CustomerId], [DateGmt], [Address], [Shipping], [Total], [ModeOfPayment], [IsOngoingOrder], [Status], [PlacedTime], [ProcessingTime], [OnTheWayTime], [DeliveredTime], [CanceledTime], [GrandTotal], [CreatedAt], [UpdatedAt], [Lat], [Lon], [AddressTitle], [ReferrerId], [ForPickUpTime], [Discount], [DriverId], [DriverLat], [DriverLon], [AdditionalFee], [ChangeAddress], [ChangeAddressLat], [ChangeAddressLon], [ChangeAddressTitle], [IsChangeAddress], [IsChangeAddressAccepted], [IsArchive], [IsDriverArchive]) VALUES (42, N'9004fa03-376d-451a-aca7-2d6ca20e82f2', N'dfee830d-3cd1-4a3e-b928-9cc04acd2192', CAST(N'2023-09-06 16:05:35.8366667' AS DateTime2), N'Kids School', 65.25, 131, 0, 0, N'Delivered', CAST(N'2023-09-06 16:05:35.8366667' AS DateTime2), NULL, CAST(N'2023-09-06 16:07:03.8566667' AS DateTime2), CAST(N'2023-09-10 20:43:57.1900000' AS DateTime2), NULL, 196.25, CAST(N'2023-09-06 16:05:36.0500000' AS DateTime2), CAST(N'2023-09-10 20:43:57.1900000' AS DateTime2), N'-18.1455035396092', N'178.436988964677', N'School', NULL, NULL, 0, N'b1df6432-282c-4e47-a16e-fa940c9c5f29', N'-18.0915179', N'178.4819103', NULL, NULL, NULL, NULL, NULL, 0, 0, 0, 1)
INSERT [dbo].[Order] ([Id], [OrderId], [CustomerId], [DateGmt], [Address], [Shipping], [Total], [ModeOfPayment], [IsOngoingOrder], [Status], [PlacedTime], [ProcessingTime], [OnTheWayTime], [DeliveredTime], [CanceledTime], [GrandTotal], [CreatedAt], [UpdatedAt], [Lat], [Lon], [AddressTitle], [ReferrerId], [ForPickUpTime], [Discount], [DriverId], [DriverLat], [DriverLon], [AdditionalFee], [ChangeAddress], [ChangeAddressLat], [ChangeAddressLon], [ChangeAddressTitle], [IsChangeAddress], [IsChangeAddressAccepted], [IsArchive], [IsDriverArchive]) VALUES (43, N'a8532241-b759-4515-b4f5-81a02b697e46', N'e3a08713-3d80-40ef-a464-9a3983b5c4cd', CAST(N'2023-09-07 09:22:19.5033333' AS DateTime2), N'kalabo', 36.25, 25, 0, 0, N'Delivered', CAST(N'2023-09-07 09:22:19.5033333' AS DateTime2), NULL, CAST(N'2023-09-07 09:24:24.6533333' AS DateTime2), CAST(N'2023-09-10 20:43:31.0400000' AS DateTime2), NULL, 61.25, CAST(N'2023-09-07 09:22:20.7133333' AS DateTime2), CAST(N'2023-09-10 20:43:31.0400000' AS DateTime2), N'-18.0912600836427', N'178.482026271522', N'Work', NULL, NULL, 0, N'b1df6432-282c-4e47-a16e-fa940c9c5f29', N'-18.0915126', N'178.4819149', NULL, NULL, NULL, NULL, NULL, 0, 0, 1, 1)
INSERT [dbo].[Order] ([Id], [OrderId], [CustomerId], [DateGmt], [Address], [Shipping], [Total], [ModeOfPayment], [IsOngoingOrder], [Status], [PlacedTime], [ProcessingTime], [OnTheWayTime], [DeliveredTime], [CanceledTime], [GrandTotal], [CreatedAt], [UpdatedAt], [Lat], [Lon], [AddressTitle], [ReferrerId], [ForPickUpTime], [Discount], [DriverId], [DriverLat], [DriverLon], [AdditionalFee], [ChangeAddress], [ChangeAddressLat], [ChangeAddressLon], [ChangeAddressTitle], [IsChangeAddress], [IsChangeAddressAccepted], [IsArchive], [IsDriverArchive]) VALUES (44, N'a30ed5ed-3491-4f1e-8875-745d2a34f42e', N'e3a08713-3d80-40ef-a464-9a3983b5c4cd', CAST(N'2023-09-07 20:19:36.5266667' AS DateTime2), N'Bight Little Ones', 68.03, 18, 0, 0, N'Delivered', CAST(N'2023-09-07 20:19:36.5266667' AS DateTime2), NULL, CAST(N'2023-09-07 20:20:06.5800000' AS DateTime2), CAST(N'2023-09-09 18:48:45.7566667' AS DateTime2), NULL, 86.03, CAST(N'2023-09-07 20:19:37.7100000' AS DateTime2), CAST(N'2023-09-09 18:48:45.7566667' AS DateTime2), N'-18.1553346962396', N'178.442704081535', N'Others', NULL, NULL, 0, N'64fd52b0-106d-4bdf-a21a-2165d04cce48', N'-18.1066855', N'178.4502544', NULL, NULL, NULL, NULL, NULL, 0, 0, 0, 0)
INSERT [dbo].[Order] ([Id], [OrderId], [CustomerId], [DateGmt], [Address], [Shipping], [Total], [ModeOfPayment], [IsOngoingOrder], [Status], [PlacedTime], [ProcessingTime], [OnTheWayTime], [DeliveredTime], [CanceledTime], [GrandTotal], [CreatedAt], [UpdatedAt], [Lat], [Lon], [AddressTitle], [ReferrerId], [ForPickUpTime], [Discount], [DriverId], [DriverLat], [DriverLon], [AdditionalFee], [ChangeAddress], [ChangeAddressLat], [ChangeAddressLon], [ChangeAddressTitle], [IsChangeAddress], [IsChangeAddressAccepted], [IsArchive], [IsDriverArchive]) VALUES (45, N'941b36bc-cf9c-4518-8639-292860ea39cc', N'e3a08713-3d80-40ef-a464-9a3983b5c4cd', CAST(N'2023-09-09 06:48:23.7700000' AS DateTime2), N'The Rotisserie ', 1.04, 16, 0, 1, N'OnTheWay', CAST(N'2023-09-09 06:48:23.7700000' AS DateTime2), NULL, CAST(N'2023-09-09 06:48:55.5900000' AS DateTime2), NULL, NULL, 17.04, CAST(N'2023-09-09 06:48:23.5766667' AS DateTime2), CAST(N'2023-09-12 14:21:46.6833333' AS DateTime2), N'-18.112075767485', N'178.468450605869', N'Others', NULL, NULL, 0, N'64fd52b0-106d-4bdf-a21a-2165d04cce48', N'-18.1066778', N'178.4502662', NULL, NULL, NULL, NULL, NULL, 0, 0, 0, 0)
INSERT [dbo].[Order] ([Id], [OrderId], [CustomerId], [DateGmt], [Address], [Shipping], [Total], [ModeOfPayment], [IsOngoingOrder], [Status], [PlacedTime], [ProcessingTime], [OnTheWayTime], [DeliveredTime], [CanceledTime], [GrandTotal], [CreatedAt], [UpdatedAt], [Lat], [Lon], [AddressTitle], [ReferrerId], [ForPickUpTime], [Discount], [DriverId], [DriverLat], [DriverLon], [AdditionalFee], [ChangeAddress], [ChangeAddressLat], [ChangeAddressLon], [ChangeAddressTitle], [IsChangeAddress], [IsChangeAddressAccepted], [IsArchive], [IsDriverArchive]) VALUES (46, N'a801a81d-8b16-4d9f-9868-736b7609d2c0', N'e3a08713-3d80-40ef-a464-9a3983b5c4cd', CAST(N'2023-09-09 18:12:43.2500000' AS DateTime2), N'Laucala Bay Parish', 54.18, 25, 0, 1, N'OnTheWay', CAST(N'2023-09-09 18:12:43.2500000' AS DateTime2), NULL, CAST(N'2023-09-09 18:49:14.0600000' AS DateTime2), NULL, NULL, 79.18, CAST(N'2023-09-09 18:12:44.7866667' AS DateTime2), CAST(N'2023-09-12 16:56:14.3166667' AS DateTime2), N'-18.1448749359278', N'178.447161577642', N'School', NULL, NULL, 0, N'64fd52b0-106d-4bdf-a21a-2165d04cce48', N'-18.1066877', N'178.4502455', NULL, NULL, NULL, NULL, NULL, 0, 0, 0, 0)
INSERT [dbo].[Order] ([Id], [OrderId], [CustomerId], [DateGmt], [Address], [Shipping], [Total], [ModeOfPayment], [IsOngoingOrder], [Status], [PlacedTime], [ProcessingTime], [OnTheWayTime], [DeliveredTime], [CanceledTime], [GrandTotal], [CreatedAt], [UpdatedAt], [Lat], [Lon], [AddressTitle], [ReferrerId], [ForPickUpTime], [Discount], [DriverId], [DriverLat], [DriverLon], [AdditionalFee], [ChangeAddress], [ChangeAddressLat], [ChangeAddressLon], [ChangeAddressTitle], [IsChangeAddress], [IsChangeAddressAccepted], [IsArchive], [IsDriverArchive]) VALUES (47, N'9f17217f-18cd-4bc3-a600-2401c76549bc', N'e3a08713-3d80-40ef-a464-9a3983b5c4cd', CAST(N'2023-09-10 18:25:44.4633333' AS DateTime2), N'F8 KTFZ ', 36.56, 16, 0, 0, N'Delivered', CAST(N'2023-09-10 18:25:44.4633333' AS DateTime2), NULL, CAST(N'2023-09-10 18:52:43.0600000' AS DateTime2), CAST(N'2023-09-10 19:05:36.1266667' AS DateTime2), NULL, 52.56, CAST(N'2023-09-10 18:25:45.4066667' AS DateTime2), CAST(N'2023-09-10 19:05:37.6066667' AS DateTime2), N'-18.0912546657236', N'178.482179157436', N'Work', NULL, NULL, 0, N'f60ab9d5-f39e-421e-a967-42e000e55bf3', N'-18.0889693', N'178.4817885', NULL, NULL, NULL, NULL, NULL, 0, 0, 0, 0)
INSERT [dbo].[Order] ([Id], [OrderId], [CustomerId], [DateGmt], [Address], [Shipping], [Total], [ModeOfPayment], [IsOngoingOrder], [Status], [PlacedTime], [ProcessingTime], [OnTheWayTime], [DeliveredTime], [CanceledTime], [GrandTotal], [CreatedAt], [UpdatedAt], [Lat], [Lon], [AddressTitle], [ReferrerId], [ForPickUpTime], [Discount], [DriverId], [DriverLat], [DriverLon], [AdditionalFee], [ChangeAddress], [ChangeAddressLat], [ChangeAddressLon], [ChangeAddressTitle], [IsChangeAddress], [IsChangeAddressAccepted], [IsArchive], [IsDriverArchive]) VALUES (48, N'0a878637-df9a-44a6-b8a8-191a3df96149', N'e3a08713-3d80-40ef-a464-9a3983b5c4cd', CAST(N'2023-09-11 19:51:56.3766667' AS DateTime2), N'F8 KTFZ ', 36.56, 16, 0, 1, N'OnTheWay', CAST(N'2023-09-11 19:51:56.3766667' AS DateTime2), NULL, CAST(N'2023-09-11 19:54:33.1433333' AS DateTime2), NULL, NULL, 52.56, CAST(N'2023-09-11 19:51:55.5933333' AS DateTime2), CAST(N'2023-09-12 13:53:50.5733333' AS DateTime2), N'-18.0912546657236', N'178.482179157436', N'Work', NULL, NULL, 0, N'64fd52b0-106d-4bdf-a21a-2165d04cce48', N'-18.1066865', N'178.450248', NULL, NULL, NULL, NULL, NULL, 0, 0, 0, 0)
SET IDENTITY_INSERT [dbo].[Order] OFF
SET IDENTITY_INSERT [dbo].[OrderDocuments] ON 

INSERT [dbo].[OrderDocuments] ([Id], [OrderId], [OnTheWayImage], [OnTheWayImageTime], [DeliveredImage], [DeliveredImageTime], [CancelledImage], [CancelledImageTime], [CancelledReason]) VALUES (1, N'd24382f2-16ff-45c6-8e70-0b0a513c773c', N'string', CAST(N'2023-08-16 08:46:29.5966667' AS DateTime2), NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[OrderDocuments] ([Id], [OrderId], [OnTheWayImage], [OnTheWayImageTime], [DeliveredImage], [DeliveredImageTime], [CancelledImage], [CancelledImageTime], [CancelledReason]) VALUES (2, N'e3850c70-6765-4b45-9c5f-01f4ee2eaf58', NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[OrderDocuments] ([Id], [OrderId], [OnTheWayImage], [OnTheWayImageTime], [DeliveredImage], [DeliveredImageTime], [CancelledImage], [CancelledImageTime], [CancelledReason]) VALUES (3, N'b5d99f03-eeb6-4c9c-9f16-b18a281a1826', NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[OrderDocuments] ([Id], [OrderId], [OnTheWayImage], [OnTheWayImageTime], [DeliveredImage], [DeliveredImageTime], [CancelledImage], [CancelledImageTime], [CancelledReason]) VALUES (4, N'd86b4c36-e9ec-4ff8-bcb7-507ffc036e4a', NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[OrderDocuments] ([Id], [OrderId], [OnTheWayImage], [OnTheWayImageTime], [DeliveredImage], [DeliveredImageTime], [CancelledImage], [CancelledImageTime], [CancelledReason]) VALUES (5, N'9be3488d-8a36-4bb1-b21c-2201d1171324', NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[OrderDocuments] ([Id], [OrderId], [OnTheWayImage], [OnTheWayImageTime], [DeliveredImage], [DeliveredImageTime], [CancelledImage], [CancelledImageTime], [CancelledReason]) VALUES (6, N'1f4641b4-6f3c-4538-af24-ec6ccb5a6c09', NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[OrderDocuments] ([Id], [OrderId], [OnTheWayImage], [OnTheWayImageTime], [DeliveredImage], [DeliveredImageTime], [CancelledImage], [CancelledImageTime], [CancelledReason]) VALUES (7, N'c66dd3af-908d-4713-9764-85163d74b5c5', NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[OrderDocuments] ([Id], [OrderId], [OnTheWayImage], [OnTheWayImageTime], [DeliveredImage], [DeliveredImageTime], [CancelledImage], [CancelledImageTime], [CancelledReason]) VALUES (8, N'4bb79503-6655-499a-911a-2c7fcefd0df8', NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[OrderDocuments] ([Id], [OrderId], [OnTheWayImage], [OnTheWayImageTime], [DeliveredImage], [DeliveredImageTime], [CancelledImage], [CancelledImageTime], [CancelledReason]) VALUES (9, N'string', NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[OrderDocuments] ([Id], [OrderId], [OnTheWayImage], [OnTheWayImageTime], [DeliveredImage], [DeliveredImageTime], [CancelledImage], [CancelledImageTime], [CancelledReason]) VALUES (10, N'f40f60ec-a179-42fd-8f49-69656572cd45', NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[OrderDocuments] ([Id], [OrderId], [OnTheWayImage], [OnTheWayImageTime], [DeliveredImage], [DeliveredImageTime], [CancelledImage], [CancelledImageTime], [CancelledReason]) VALUES (11, N'f7bcb121-9074-4cbb-8565-9a32124bcbd2', NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[OrderDocuments] ([Id], [OrderId], [OnTheWayImage], [OnTheWayImageTime], [DeliveredImage], [DeliveredImageTime], [CancelledImage], [CancelledImageTime], [CancelledReason]) VALUES (12, N'1290ecac-00d5-4e1f-a07e-353e6eb095a6', NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[OrderDocuments] ([Id], [OrderId], [OnTheWayImage], [OnTheWayImageTime], [DeliveredImage], [DeliveredImageTime], [CancelledImage], [CancelledImageTime], [CancelledReason]) VALUES (13, N'df784f55-0118-4e66-b827-b7c7e353e648', NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[OrderDocuments] ([Id], [OrderId], [OnTheWayImage], [OnTheWayImageTime], [DeliveredImage], [DeliveredImageTime], [CancelledImage], [CancelledImageTime], [CancelledReason]) VALUES (14, N'a0544ca0-4544-4abf-b1fb-506d82bd34fb', NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[OrderDocuments] ([Id], [OrderId], [OnTheWayImage], [OnTheWayImageTime], [DeliveredImage], [DeliveredImageTime], [CancelledImage], [CancelledImageTime], [CancelledReason]) VALUES (15, N'be7f22e6-00d3-433c-91b0-e46e65e4fb33', NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[OrderDocuments] ([Id], [OrderId], [OnTheWayImage], [OnTheWayImageTime], [DeliveredImage], [DeliveredImageTime], [CancelledImage], [CancelledImageTime], [CancelledReason]) VALUES (16, N'd14b5030-8645-4e23-9b25-c27f86b1bf8d', NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[OrderDocuments] ([Id], [OrderId], [OnTheWayImage], [OnTheWayImageTime], [DeliveredImage], [DeliveredImageTime], [CancelledImage], [CancelledImageTime], [CancelledReason]) VALUES (17, N'3a8461da-1663-4ba1-9d90-e69b27ae0469', NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[OrderDocuments] ([Id], [OrderId], [OnTheWayImage], [OnTheWayImageTime], [DeliveredImage], [DeliveredImageTime], [CancelledImage], [CancelledImageTime], [CancelledReason]) VALUES (18, N'b2fc85af-5bcf-402d-b08d-2fda1d49759c', NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[OrderDocuments] ([Id], [OrderId], [OnTheWayImage], [OnTheWayImageTime], [DeliveredImage], [DeliveredImageTime], [CancelledImage], [CancelledImageTime], [CancelledReason]) VALUES (19, N'42fdeb60-b2da-4456-a1fa-5907c2906dde', NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[OrderDocuments] ([Id], [OrderId], [OnTheWayImage], [OnTheWayImageTime], [DeliveredImage], [DeliveredImageTime], [CancelledImage], [CancelledImageTime], [CancelledReason]) VALUES (20, N'a68d234a-8e7e-4551-8886-0b1dae62e53f', NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[OrderDocuments] ([Id], [OrderId], [OnTheWayImage], [OnTheWayImageTime], [DeliveredImage], [DeliveredImageTime], [CancelledImage], [CancelledImageTime], [CancelledReason]) VALUES (21, N'000d8896-7757-49a2-a623-799b57146958', NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[OrderDocuments] ([Id], [OrderId], [OnTheWayImage], [OnTheWayImageTime], [DeliveredImage], [DeliveredImageTime], [CancelledImage], [CancelledImageTime], [CancelledReason]) VALUES (22, N'3921f73c-7b33-43f4-bd44-6d792656a0a3', NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[OrderDocuments] ([Id], [OrderId], [OnTheWayImage], [OnTheWayImageTime], [DeliveredImage], [DeliveredImageTime], [CancelledImage], [CancelledImageTime], [CancelledReason]) VALUES (23, N'438ffdc9-352e-4bb1-9bd6-e4f076c1b7c3', NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[OrderDocuments] ([Id], [OrderId], [OnTheWayImage], [OnTheWayImageTime], [DeliveredImage], [DeliveredImageTime], [CancelledImage], [CancelledImageTime], [CancelledReason]) VALUES (24, N'5593710f-82d2-4e80-bd22-befdd9bdd44d', NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[OrderDocuments] ([Id], [OrderId], [OnTheWayImage], [OnTheWayImageTime], [DeliveredImage], [DeliveredImageTime], [CancelledImage], [CancelledImageTime], [CancelledReason]) VALUES (25, N'4183d47d-3faf-4cb9-bcde-300555876943', NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[OrderDocuments] ([Id], [OrderId], [OnTheWayImage], [OnTheWayImageTime], [DeliveredImage], [DeliveredImageTime], [CancelledImage], [CancelledImageTime], [CancelledReason]) VALUES (26, N'02493b24-dcb5-43bc-8983-3dc24e7e2b92', NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[OrderDocuments] ([Id], [OrderId], [OnTheWayImage], [OnTheWayImageTime], [DeliveredImage], [DeliveredImageTime], [CancelledImage], [CancelledImageTime], [CancelledReason]) VALUES (27, N'1037d121-3fae-4692-ab19-83f44aaa7e01', NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[OrderDocuments] ([Id], [OrderId], [OnTheWayImage], [OnTheWayImageTime], [DeliveredImage], [DeliveredImageTime], [CancelledImage], [CancelledImageTime], [CancelledReason]) VALUES (28, N'c2043015-829b-4b9a-aadf-c4bc8f9bef1c', NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[OrderDocuments] ([Id], [OrderId], [OnTheWayImage], [OnTheWayImageTime], [DeliveredImage], [DeliveredImageTime], [CancelledImage], [CancelledImageTime], [CancelledReason]) VALUES (29, N'9880133a-17e3-4fc0-88ed-26163c4566da', NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[OrderDocuments] ([Id], [OrderId], [OnTheWayImage], [OnTheWayImageTime], [DeliveredImage], [DeliveredImageTime], [CancelledImage], [CancelledImageTime], [CancelledReason]) VALUES (30, N'8034aa27-19c6-4cbd-ad40-597b53859f23', NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[OrderDocuments] ([Id], [OrderId], [OnTheWayImage], [OnTheWayImageTime], [DeliveredImage], [DeliveredImageTime], [CancelledImage], [CancelledImageTime], [CancelledReason]) VALUES (31, N'b92b78cf-64d0-4c4a-a4ba-144b54a614d2', NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[OrderDocuments] ([Id], [OrderId], [OnTheWayImage], [OnTheWayImageTime], [DeliveredImage], [DeliveredImageTime], [CancelledImage], [CancelledImageTime], [CancelledReason]) VALUES (32, N'937934aa-5295-4f6e-87ab-e4cfa85d6a3e', NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[OrderDocuments] ([Id], [OrderId], [OnTheWayImage], [OnTheWayImageTime], [DeliveredImage], [DeliveredImageTime], [CancelledImage], [CancelledImageTime], [CancelledReason]) VALUES (33, N'f01c4371-6326-4082-b243-e5b6991df0ce', NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[OrderDocuments] ([Id], [OrderId], [OnTheWayImage], [OnTheWayImageTime], [DeliveredImage], [DeliveredImageTime], [CancelledImage], [CancelledImageTime], [CancelledReason]) VALUES (34, N'0cb1ae18-5b8d-4c98-b199-44b40ccc731d', NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[OrderDocuments] ([Id], [OrderId], [OnTheWayImage], [OnTheWayImageTime], [DeliveredImage], [DeliveredImageTime], [CancelledImage], [CancelledImageTime], [CancelledReason]) VALUES (35, N'311174e8-1133-4a22-8a0d-d1a609be3749', NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[OrderDocuments] ([Id], [OrderId], [OnTheWayImage], [OnTheWayImageTime], [DeliveredImage], [DeliveredImageTime], [CancelledImage], [CancelledImageTime], [CancelledReason]) VALUES (36, N'e0287748-c98b-465a-a227-32c3b866a009', NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[OrderDocuments] ([Id], [OrderId], [OnTheWayImage], [OnTheWayImageTime], [DeliveredImage], [DeliveredImageTime], [CancelledImage], [CancelledImageTime], [CancelledReason]) VALUES (37, N'94bf7b58-9aa8-4b47-9ed2-eed0f91c5f04', NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[OrderDocuments] ([Id], [OrderId], [OnTheWayImage], [OnTheWayImageTime], [DeliveredImage], [DeliveredImageTime], [CancelledImage], [CancelledImageTime], [CancelledReason]) VALUES (38, N'6d967bc2-a675-44b1-b68e-035fe467710e', NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[OrderDocuments] ([Id], [OrderId], [OnTheWayImage], [OnTheWayImageTime], [DeliveredImage], [DeliveredImageTime], [CancelledImage], [CancelledImageTime], [CancelledReason]) VALUES (39, N'70bda761-7163-44c3-8d64-65a6a3dcc5f9', NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[OrderDocuments] ([Id], [OrderId], [OnTheWayImage], [OnTheWayImageTime], [DeliveredImage], [DeliveredImageTime], [CancelledImage], [CancelledImageTime], [CancelledReason]) VALUES (40, N'35f9e5f5-1178-421a-8bbf-4f530c11963a', NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[OrderDocuments] ([Id], [OrderId], [OnTheWayImage], [OnTheWayImageTime], [DeliveredImage], [DeliveredImageTime], [CancelledImage], [CancelledImageTime], [CancelledReason]) VALUES (41, N'f32d9310-b7fc-4506-a820-674d4d0a2b20', NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[OrderDocuments] ([Id], [OrderId], [OnTheWayImage], [OnTheWayImageTime], [DeliveredImage], [DeliveredImageTime], [CancelledImage], [CancelledImageTime], [CancelledReason]) VALUES (42, N'9004fa03-376d-451a-aca7-2d6ca20e82f2', NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[OrderDocuments] ([Id], [OrderId], [OnTheWayImage], [OnTheWayImageTime], [DeliveredImage], [DeliveredImageTime], [CancelledImage], [CancelledImageTime], [CancelledReason]) VALUES (43, N'a8532241-b759-4515-b4f5-81a02b697e46', NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[OrderDocuments] ([Id], [OrderId], [OnTheWayImage], [OnTheWayImageTime], [DeliveredImage], [DeliveredImageTime], [CancelledImage], [CancelledImageTime], [CancelledReason]) VALUES (44, N'a30ed5ed-3491-4f1e-8875-745d2a34f42e', NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[OrderDocuments] ([Id], [OrderId], [OnTheWayImage], [OnTheWayImageTime], [DeliveredImage], [DeliveredImageTime], [CancelledImage], [CancelledImageTime], [CancelledReason]) VALUES (45, N'941b36bc-cf9c-4518-8639-292860ea39cc', NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[OrderDocuments] ([Id], [OrderId], [OnTheWayImage], [OnTheWayImageTime], [DeliveredImage], [DeliveredImageTime], [CancelledImage], [CancelledImageTime], [CancelledReason]) VALUES (46, N'a801a81d-8b16-4d9f-9868-736b7609d2c0', NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[OrderDocuments] ([Id], [OrderId], [OnTheWayImage], [OnTheWayImageTime], [DeliveredImage], [DeliveredImageTime], [CancelledImage], [CancelledImageTime], [CancelledReason]) VALUES (47, N'9f17217f-18cd-4bc3-a600-2401c76549bc', NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[OrderDocuments] ([Id], [OrderId], [OnTheWayImage], [OnTheWayImageTime], [DeliveredImage], [DeliveredImageTime], [CancelledImage], [CancelledImageTime], [CancelledReason]) VALUES (48, N'0a878637-df9a-44a6-b8a8-191a3df96149', NULL, NULL, NULL, NULL, NULL, NULL, NULL)
SET IDENTITY_INSERT [dbo].[OrderDocuments] OFF
SET IDENTITY_INSERT [dbo].[OrderItem] ON 

INSERT [dbo].[OrderItem] ([Id], [OrderId], [ProductId], [ProductName], [ProductImage], [ProductDescription], [UnitPrice], [Quantity], [IngredientString], [ChoiceString], [Total]) VALUES (1, N'd24382f2-16ff-45c6-8e70-0b0a513c773c', N'i012', N'Grilled Chicken Steak', N'mi_grilled_chicken_steak', N'Grilled chicken steak, pasta, salad', 16, 2, N'', N'', 32)
INSERT [dbo].[OrderItem] ([Id], [OrderId], [ProductId], [ProductName], [ProductImage], [ProductDescription], [UnitPrice], [Quantity], [IngredientString], [ChoiceString], [Total]) VALUES (2, N'e3850c70-6765-4b45-9c5f-01f4ee2eaf58', N'i012', N'Grilled Chicken Steak', N'mi_grilled_chicken_steak', N'Grilled chicken steak, pasta, salad', 16, 2, N'', N'', 32)
INSERT [dbo].[OrderItem] ([Id], [OrderId], [ProductId], [ProductName], [ProductImage], [ProductDescription], [UnitPrice], [Quantity], [IngredientString], [ChoiceString], [Total]) VALUES (3, N'b5d99f03-eeb6-4c9c-9f16-b18a281a1826', N'i012', N'Grilled Chicken Steak', N'mi_grilled_chicken_steak', N'Grilled chicken steak, pasta, salad', 16, 2, N'', N'', 32)
INSERT [dbo].[OrderItem] ([Id], [OrderId], [ProductId], [ProductName], [ProductImage], [ProductDescription], [UnitPrice], [Quantity], [IngredientString], [ChoiceString], [Total]) VALUES (4, N'd86b4c36-e9ec-4ff8-bcb7-507ffc036e4a', N'i012', N'Grilled Chicken Steak', N'mi_grilled_chicken_steak', N'Grilled chicken steak, pasta, salad', 16, 2, N'', N'', 32)
INSERT [dbo].[OrderItem] ([Id], [OrderId], [ProductId], [ProductName], [ProductImage], [ProductDescription], [UnitPrice], [Quantity], [IngredientString], [ChoiceString], [Total]) VALUES (5, N'9be3488d-8a36-4bb1-b21c-2201d1171324', N'i019', N'Napolitan Pasta', N'mi_alinazik_chicken', N'Napolitan sauce, cheddar, pasta', 11, 2, N'', N'', 22)
INSERT [dbo].[OrderItem] ([Id], [OrderId], [ProductId], [ProductName], [ProductImage], [ProductDescription], [UnitPrice], [Quantity], [IngredientString], [ChoiceString], [Total]) VALUES (6, N'1f4641b4-6f3c-4538-af24-ec6ccb5a6c09', N'i012', N'Grilled Chicken Steak', N'mi_grilled_chicken_steak', N'Grilled chicken steak, pasta, salad', 16, 2, N'', N'', 32)
INSERT [dbo].[OrderItem] ([Id], [OrderId], [ProductId], [ProductName], [ProductImage], [ProductDescription], [UnitPrice], [Quantity], [IngredientString], [ChoiceString], [Total]) VALUES (7, N'c66dd3af-908d-4713-9764-85163d74b5c5', N'i014', N'Alinazik Chicken', N'mi_alinazik_chicken', N'Chicken chop, yogurt, eggplant', 20, 1, N'', N'', 20)
INSERT [dbo].[OrderItem] ([Id], [OrderId], [ProductId], [ProductName], [ProductImage], [ProductDescription], [UnitPrice], [Quantity], [IngredientString], [ChoiceString], [Total]) VALUES (8, N'4bb79503-6655-499a-911a-2c7fcefd0df8', N'i019', N'Napolitan Pasta', N'mi_alinazik_chicken', N'Napolitan sauce, cheddar, pasta', 11, 1, N'', N'', 11)
INSERT [dbo].[OrderItem] ([Id], [OrderId], [ProductId], [ProductName], [ProductImage], [ProductDescription], [UnitPrice], [Quantity], [IngredientString], [ChoiceString], [Total]) VALUES (10, N'f40f60ec-a179-42fd-8f49-69656572cd45', N'i019', N'Napolitan Pasta', N'mi_alinazik_chicken', N'Napolitan sauce, cheddar, pasta', 11, 1, N'', N'', 11)
INSERT [dbo].[OrderItem] ([Id], [OrderId], [ProductId], [ProductName], [ProductImage], [ProductDescription], [UnitPrice], [Quantity], [IngredientString], [ChoiceString], [Total]) VALUES (11, N'f7bcb121-9074-4cbb-8565-9a32124bcbd2', N'i020', N'Alfredo Pasta', N'mi_alfredo_pasta', N'Chicken with sauce, cheddar, mushroom, pasta, custard', 12, 2, N'', N'', 24)
INSERT [dbo].[OrderItem] ([Id], [OrderId], [ProductId], [ProductName], [ProductImage], [ProductDescription], [UnitPrice], [Quantity], [IngredientString], [ChoiceString], [Total]) VALUES (12, N'1290ecac-00d5-4e1f-a07e-353e6eb095a6', N'i019', N'Napolitan Pasta', N'mi_alinazik_chicken', N'Napolitan sauce, cheddar, pasta', 11, 2, N'', N'', 22)
INSERT [dbo].[OrderItem] ([Id], [OrderId], [ProductId], [ProductName], [ProductImage], [ProductDescription], [UnitPrice], [Quantity], [IngredientString], [ChoiceString], [Total]) VALUES (13, N'df784f55-0118-4e66-b827-b7c7e353e648', N'i019', N'Napolitan Pasta', N'mi_alinazik_chicken', N'Napolitan sauce, cheddar, pasta', 11, 2, N'', N'', 22)
INSERT [dbo].[OrderItem] ([Id], [OrderId], [ProductId], [ProductName], [ProductImage], [ProductDescription], [UnitPrice], [Quantity], [IngredientString], [ChoiceString], [Total]) VALUES (14, N'a0544ca0-4544-4abf-b1fb-506d82bd34fb', N'i011', N'Grilled Meatball', N'mi_meatball', N'Grilled meatball, salad, potato.', 25, 1, N'', N'', 25)
INSERT [dbo].[OrderItem] ([Id], [OrderId], [ProductId], [ProductName], [ProductImage], [ProductDescription], [UnitPrice], [Quantity], [IngredientString], [ChoiceString], [Total]) VALUES (15, N'a0544ca0-4544-4abf-b1fb-506d82bd34fb', N'i012', N'Grilled Chicken Steak', N'mi_grilled_chicken_steak', N'Grilled chicken steak, pasta, salad', 16, 2, N'', N'', 32)
INSERT [dbo].[OrderItem] ([Id], [OrderId], [ProductId], [ProductName], [ProductImage], [ProductDescription], [UnitPrice], [Quantity], [IngredientString], [ChoiceString], [Total]) VALUES (16, N'a0544ca0-4544-4abf-b1fb-506d82bd34fb', N'i014', N'Alinazik Chicken', N'mi_alinazik_chicken', N'Chicken chop, yogurt, eggplant', 20, 1, N'', N'', 20)
INSERT [dbo].[OrderItem] ([Id], [OrderId], [ProductId], [ProductName], [ProductImage], [ProductDescription], [UnitPrice], [Quantity], [IngredientString], [ChoiceString], [Total]) VALUES (17, N'be7f22e6-00d3-433c-91b0-e46e65e4fb33', N'i001', N'Classic Burger Menu', N'mi_classic_burger_menu', N'Burger, Potato, Beverage', 18, 1, N'', N'', 18)
INSERT [dbo].[OrderItem] ([Id], [OrderId], [ProductId], [ProductName], [ProductImage], [ProductDescription], [UnitPrice], [Quantity], [IngredientString], [ChoiceString], [Total]) VALUES (18, N'be7f22e6-00d3-433c-91b0-e46e65e4fb33', N'i005', N'Classic Burger', N'mi_burger', N'Beef, bread, pickles, ketchup, mayonnaise, lettuce, tomato, onion.', 8, 3, N'', N'', 24)
INSERT [dbo].[OrderItem] ([Id], [OrderId], [ProductId], [ProductName], [ProductImage], [ProductDescription], [UnitPrice], [Quantity], [IngredientString], [ChoiceString], [Total]) VALUES (19, N'be7f22e6-00d3-433c-91b0-e46e65e4fb33', N'i011', N'Grilled Meatball', N'mi_meatball', N'Grilled meatball, salad, potato.', 25, 1, N'', N'', 25)
INSERT [dbo].[OrderItem] ([Id], [OrderId], [ProductId], [ProductName], [ProductImage], [ProductDescription], [UnitPrice], [Quantity], [IngredientString], [ChoiceString], [Total]) VALUES (20, N'be7f22e6-00d3-433c-91b0-e46e65e4fb33', N'i012', N'Grilled Chicken Steak', N'mi_grilled_chicken_steak', N'Grilled chicken steak, pasta, salad', 16, 1, N'', N'', 16)
INSERT [dbo].[OrderItem] ([Id], [OrderId], [ProductId], [ProductName], [ProductImage], [ProductDescription], [UnitPrice], [Quantity], [IngredientString], [ChoiceString], [Total]) VALUES (21, N'be7f22e6-00d3-433c-91b0-e46e65e4fb33', N'i019', N'Napolitan Pasta', N'mi_alinazik_chicken', N'Napolitan sauce, cheddar, pasta', 11, 3, N'', N'', 33)
INSERT [dbo].[OrderItem] ([Id], [OrderId], [ProductId], [ProductName], [ProductImage], [ProductDescription], [UnitPrice], [Quantity], [IngredientString], [ChoiceString], [Total]) VALUES (22, N'be7f22e6-00d3-433c-91b0-e46e65e4fb33', N'i020', N'Alfredo Pasta', N'mi_alfredo_pasta', N'Chicken with sauce, cheddar, mushroom, pasta, custard', 12, 2, N'', N'', 24)
INSERT [dbo].[OrderItem] ([Id], [OrderId], [ProductId], [ProductName], [ProductImage], [ProductDescription], [UnitPrice], [Quantity], [IngredientString], [ChoiceString], [Total]) VALUES (23, N'd14b5030-8645-4e23-9b25-c27f86b1bf8d', N'i005', N'Classic Burger', N'mi_burger', N'Beef, bread, pickles, ketchup, mayonnaise, lettuce, tomato, onion.', 8, 1, N'', N'', 8)
INSERT [dbo].[OrderItem] ([Id], [OrderId], [ProductId], [ProductName], [ProductImage], [ProductDescription], [UnitPrice], [Quantity], [IngredientString], [ChoiceString], [Total]) VALUES (24, N'3a8461da-1663-4ba1-9d90-e69b27ae0469', N'i011', N'Grilled Meatball', N'mi_meatball', N'Grilled meatball, salad, potato.', 25, 1, N'', N'', 25)
INSERT [dbo].[OrderItem] ([Id], [OrderId], [ProductId], [ProductName], [ProductImage], [ProductDescription], [UnitPrice], [Quantity], [IngredientString], [ChoiceString], [Total]) VALUES (25, N'b2fc85af-5bcf-402d-b08d-2fda1d49759c', N'i002', N'Classic Double Burger Menu', N'mi_classic_burger_menu', N'Burger, Potato, Beverage', 32, 1, N'', N'', 32)
INSERT [dbo].[OrderItem] ([Id], [OrderId], [ProductId], [ProductName], [ProductImage], [ProductDescription], [UnitPrice], [Quantity], [IngredientString], [ChoiceString], [Total]) VALUES (26, N'42fdeb60-b2da-4456-a1fa-5907c2906dde', N'i019', N'Napolitan Pasta', N'mi_alinazik_chicken', N'Napolitan sauce, cheddar, pasta', 11, 2, N'', N'', 22)
INSERT [dbo].[OrderItem] ([Id], [OrderId], [ProductId], [ProductName], [ProductImage], [ProductDescription], [UnitPrice], [Quantity], [IngredientString], [ChoiceString], [Total]) VALUES (27, N'a68d234a-8e7e-4551-8886-0b1dae62e53f', N'i020', N'Alfredo Pasta', N'mi_alfredo_pasta', N'Chicken with sauce, cheddar, mushroom, pasta, custard', 12, 1, N'', N'', 12)
INSERT [dbo].[OrderItem] ([Id], [OrderId], [ProductId], [ProductName], [ProductImage], [ProductDescription], [UnitPrice], [Quantity], [IngredientString], [ChoiceString], [Total]) VALUES (28, N'000d8896-7757-49a2-a623-799b57146958', N'i019', N'Napolitan Pasta', N'mi_alinazik_chicken', N'Napolitan sauce, cheddar, pasta', 11, 1, N'', N'', 11)
INSERT [dbo].[OrderItem] ([Id], [OrderId], [ProductId], [ProductName], [ProductImage], [ProductDescription], [UnitPrice], [Quantity], [IngredientString], [ChoiceString], [Total]) VALUES (29, N'3921f73c-7b33-43f4-bd44-6d792656a0a3', N'i020', N'Alfredo Pasta', N'mi_alfredo_pasta', N'Chicken with sauce, cheddar, mushroom, pasta, custard', 12, 1, N'', N'', 12)
INSERT [dbo].[OrderItem] ([Id], [OrderId], [ProductId], [ProductName], [ProductImage], [ProductDescription], [UnitPrice], [Quantity], [IngredientString], [ChoiceString], [Total]) VALUES (30, N'438ffdc9-352e-4bb1-9bd6-e4f076c1b7c3', N'i020', N'Alfredo Pasta', N'mi_alfredo_pasta', N'Chicken with sauce, cheddar, mushroom, pasta, custard', 12, 1, N'', N'', 12)
INSERT [dbo].[OrderItem] ([Id], [OrderId], [ProductId], [ProductName], [ProductImage], [ProductDescription], [UnitPrice], [Quantity], [IngredientString], [ChoiceString], [Total]) VALUES (31, N'5593710f-82d2-4e80-bd22-befdd9bdd44d', N'i020', N'Alfredo Pasta', N'mi_alfredo_pasta', N'Chicken with sauce, cheddar, mushroom, pasta, custard', 12, 2, N'', N'', 24)
INSERT [dbo].[OrderItem] ([Id], [OrderId], [ProductId], [ProductName], [ProductImage], [ProductDescription], [UnitPrice], [Quantity], [IngredientString], [ChoiceString], [Total]) VALUES (32, N'4183d47d-3faf-4cb9-bcde-300555876943', N'i006', N'Double Burger', N'mi_double_burger', N'Beef, bread, pickles, ketchup, mayonnaise, lettuce, tomato, onion.', 14, 1, N'', N'', 14)
INSERT [dbo].[OrderItem] ([Id], [OrderId], [ProductId], [ProductName], [ProductImage], [ProductDescription], [UnitPrice], [Quantity], [IngredientString], [ChoiceString], [Total]) VALUES (33, N'02493b24-dcb5-43bc-8983-3dc24e7e2b92', N'i011', N'Grilled Meatball', N'mi_meatball', N'Grilled meatball, salad, potato.', 25, 1, N'', N'', 25)
INSERT [dbo].[OrderItem] ([Id], [OrderId], [ProductId], [ProductName], [ProductImage], [ProductDescription], [UnitPrice], [Quantity], [IngredientString], [ChoiceString], [Total]) VALUES (34, N'02493b24-dcb5-43bc-8983-3dc24e7e2b92', N'i012', N'Grilled Chicken Steak', N'mi_grilled_chicken_steak', N'Grilled chicken steak, pasta, salad', 16, 1, N'', N'', 16)
INSERT [dbo].[OrderItem] ([Id], [OrderId], [ProductId], [ProductName], [ProductImage], [ProductDescription], [UnitPrice], [Quantity], [IngredientString], [ChoiceString], [Total]) VALUES (35, N'1037d121-3fae-4692-ab19-83f44aaa7e01', N'i014', N'Alinazik Chicken', N'mi_alinazik_chicken', N'Chicken chop, yogurt, eggplant', 20, 1, N'', N'', 20)
INSERT [dbo].[OrderItem] ([Id], [OrderId], [ProductId], [ProductName], [ProductImage], [ProductDescription], [UnitPrice], [Quantity], [IngredientString], [ChoiceString], [Total]) VALUES (36, N'c2043015-829b-4b9a-aadf-c4bc8f9bef1c', N'i002', N'Classic Double Burger Menu', N'mi_classic_burger_menu', N'Burger, Potato, Beverage', 32, 1, N'', N'', 32)
INSERT [dbo].[OrderItem] ([Id], [OrderId], [ProductId], [ProductName], [ProductImage], [ProductDescription], [UnitPrice], [Quantity], [IngredientString], [ChoiceString], [Total]) VALUES (37, N'9880133a-17e3-4fc0-88ed-26163c4566da', N'i012', N'Grilled Chicken Steak', N'mi_grilled_chicken_steak', N'Grilled chicken steak, pasta, salad', 16, 1, N'', N'', 16)
INSERT [dbo].[OrderItem] ([Id], [OrderId], [ProductId], [ProductName], [ProductImage], [ProductDescription], [UnitPrice], [Quantity], [IngredientString], [ChoiceString], [Total]) VALUES (38, N'8034aa27-19c6-4cbd-ad40-597b53859f23', N'i019', N'Napolitan Pasta', N'mi_alinazik_chicken', N'Napolitan sauce, cheddar, pasta', 11, 1, N'', N'', 11)
INSERT [dbo].[OrderItem] ([Id], [OrderId], [ProductId], [ProductName], [ProductImage], [ProductDescription], [UnitPrice], [Quantity], [IngredientString], [ChoiceString], [Total]) VALUES (39, N'b92b78cf-64d0-4c4a-a4ba-144b54a614d2', N'i019', N'Napolitan Pasta', N'mi_alinazik_chicken', N'Napolitan sauce, cheddar, pasta', 11, 2, N'', N'', 22)
INSERT [dbo].[OrderItem] ([Id], [OrderId], [ProductId], [ProductName], [ProductImage], [ProductDescription], [UnitPrice], [Quantity], [IngredientString], [ChoiceString], [Total]) VALUES (40, N'937934aa-5295-4f6e-87ab-e4cfa85d6a3e', N'i011', N'Grilled Meatball', N'mi_meatball', N'Grilled meatball, salad, potato.', 25, 1, N'', N'', 25)
INSERT [dbo].[OrderItem] ([Id], [OrderId], [ProductId], [ProductName], [ProductImage], [ProductDescription], [UnitPrice], [Quantity], [IngredientString], [ChoiceString], [Total]) VALUES (41, N'f01c4371-6326-4082-b243-e5b6991df0ce', N'i020', N'Alfredo Pasta', N'mi_alfredo_pasta', N'Chicken with sauce, cheddar, mushroom, pasta, custard', 12, 1, N'', N'', 12)
INSERT [dbo].[OrderItem] ([Id], [OrderId], [ProductId], [ProductName], [ProductImage], [ProductDescription], [UnitPrice], [Quantity], [IngredientString], [ChoiceString], [Total]) VALUES (42, N'0cb1ae18-5b8d-4c98-b199-44b40ccc731d', N'i012', N'Grilled Chicken Steak', N'mi_grilled_chicken_steak', N'Grilled chicken steak, pasta, salad', 16, 1, N'', N'', 16)
INSERT [dbo].[OrderItem] ([Id], [OrderId], [ProductId], [ProductName], [ProductImage], [ProductDescription], [UnitPrice], [Quantity], [IngredientString], [ChoiceString], [Total]) VALUES (43, N'311174e8-1133-4a22-8a0d-d1a609be3749', N'i012', N'Grilled Chicken Steak', N'mi_grilled_chicken_steak', N'Grilled chicken steak, pasta, salad', 16, 1, N'', N'', 16)
INSERT [dbo].[OrderItem] ([Id], [OrderId], [ProductId], [ProductName], [ProductImage], [ProductDescription], [UnitPrice], [Quantity], [IngredientString], [ChoiceString], [Total]) VALUES (44, N'e0287748-c98b-465a-a227-32c3b866a009', N'i019', N'Napolitan Pasta', N'mi_alinazik_chicken', N'Napolitan sauce, cheddar, pasta', 11, 1, N'', N'', 11)
INSERT [dbo].[OrderItem] ([Id], [OrderId], [ProductId], [ProductName], [ProductImage], [ProductDescription], [UnitPrice], [Quantity], [IngredientString], [ChoiceString], [Total]) VALUES (45, N'94bf7b58-9aa8-4b47-9ed2-eed0f91c5f04', N'i001', N'Classic Burger Menu', N'mi_classic_burger_menu', N'Burger, Potato, Beverage', 18, 3, N'', N'', 54)
INSERT [dbo].[OrderItem] ([Id], [OrderId], [ProductId], [ProductName], [ProductImage], [ProductDescription], [UnitPrice], [Quantity], [IngredientString], [ChoiceString], [Total]) VALUES (46, N'6d967bc2-a675-44b1-b68e-035fe467710e', N'i012', N'Grilled Chicken Steak', N'mi_grilled_chicken_steak', N'Grilled chicken steak, pasta, salad', 16, 2, N'', N'', 32)
INSERT [dbo].[OrderItem] ([Id], [OrderId], [ProductId], [ProductName], [ProductImage], [ProductDescription], [UnitPrice], [Quantity], [IngredientString], [ChoiceString], [Total]) VALUES (47, N'70bda761-7163-44c3-8d64-65a6a3dcc5f9', N'i002', N'Classic Double Burger Menu', N'mi_classic_burger_menu', N'Burger, Potato, Beverage', 32, 1, N'', N'', 32)
INSERT [dbo].[OrderItem] ([Id], [OrderId], [ProductId], [ProductName], [ProductImage], [ProductDescription], [UnitPrice], [Quantity], [IngredientString], [ChoiceString], [Total]) VALUES (48, N'70bda761-7163-44c3-8d64-65a6a3dcc5f9', N'i019', N'Napolitan Pasta', N'mi_alinazik_chicken', N'Napolitan sauce, cheddar, pasta', 11, 1, N'', N'', 11)
INSERT [dbo].[OrderItem] ([Id], [OrderId], [ProductId], [ProductName], [ProductImage], [ProductDescription], [UnitPrice], [Quantity], [IngredientString], [ChoiceString], [Total]) VALUES (49, N'70bda761-7163-44c3-8d64-65a6a3dcc5f9', N'i020', N'Alfredo Pasta', N'mi_alfredo_pasta', N'Chicken with sauce, cheddar, mushroom, pasta, custard', 12, 3, N'', N'', 36)
INSERT [dbo].[OrderItem] ([Id], [OrderId], [ProductId], [ProductName], [ProductImage], [ProductDescription], [UnitPrice], [Quantity], [IngredientString], [ChoiceString], [Total]) VALUES (50, N'35f9e5f5-1178-421a-8bbf-4f530c11963a', N'i012', N'Grilled Chicken Steak', N'mi_grilled_chicken_steak', N'Grilled chicken steak, pasta, salad', 16, 1, N'', N'', 16)
INSERT [dbo].[OrderItem] ([Id], [OrderId], [ProductId], [ProductName], [ProductImage], [ProductDescription], [UnitPrice], [Quantity], [IngredientString], [ChoiceString], [Total]) VALUES (51, N'f32d9310-b7fc-4506-a820-674d4d0a2b20', N'i014', N'Alinazik Chicken', N'mi_alinazik_chicken', N'Chicken chop, yogurt, eggplant', 20, 1, N'', N'', 20)
INSERT [dbo].[OrderItem] ([Id], [OrderId], [ProductId], [ProductName], [ProductImage], [ProductDescription], [UnitPrice], [Quantity], [IngredientString], [ChoiceString], [Total]) VALUES (52, N'9004fa03-376d-451a-aca7-2d6ca20e82f2', N'i002', N'Classic Double Burger Menu', N'mi_classic_burger_menu', N'Burger, Potato, Beverage', 32, 1, N'', N'', 32)
INSERT [dbo].[OrderItem] ([Id], [OrderId], [ProductId], [ProductName], [ProductImage], [ProductDescription], [UnitPrice], [Quantity], [IngredientString], [ChoiceString], [Total]) VALUES (53, N'9004fa03-376d-451a-aca7-2d6ca20e82f2', N'i010', N'Tenderloin with Mushroom Sauce', N'mi_double_burger', N'Tenderloin, mushroom sauce, salad, pasta.', 14, 1, N'', N'', 14)
INSERT [dbo].[OrderItem] ([Id], [OrderId], [ProductId], [ProductName], [ProductImage], [ProductDescription], [UnitPrice], [Quantity], [IngredientString], [ChoiceString], [Total]) VALUES (54, N'9004fa03-376d-451a-aca7-2d6ca20e82f2', N'i011', N'Grilled Meatball', N'mi_meatball', N'Grilled meatball, salad, potato.', 25, 1, N'', N'', 25)
INSERT [dbo].[OrderItem] ([Id], [OrderId], [ProductId], [ProductName], [ProductImage], [ProductDescription], [UnitPrice], [Quantity], [IngredientString], [ChoiceString], [Total]) VALUES (55, N'9004fa03-376d-451a-aca7-2d6ca20e82f2', N'i012', N'Grilled Chicken Steak', N'mi_grilled_chicken_steak', N'Grilled chicken steak, pasta, salad', 16, 3, N'', N'', 48)
INSERT [dbo].[OrderItem] ([Id], [OrderId], [ProductId], [ProductName], [ProductImage], [ProductDescription], [UnitPrice], [Quantity], [IngredientString], [ChoiceString], [Total]) VALUES (56, N'9004fa03-376d-451a-aca7-2d6ca20e82f2', N'i020', N'Alfredo Pasta', N'mi_alfredo_pasta', N'Chicken with sauce, cheddar, mushroom, pasta, custard', 12, 1, N'', N'', 12)
INSERT [dbo].[OrderItem] ([Id], [OrderId], [ProductId], [ProductName], [ProductImage], [ProductDescription], [UnitPrice], [Quantity], [IngredientString], [ChoiceString], [Total]) VALUES (57, N'a8532241-b759-4515-b4f5-81a02b697e46', N'i011', N'Grilled Meatball', N'mi_meatball', N'Grilled meatball, salad, potato.', 25, 1, N'', N'', 25)
INSERT [dbo].[OrderItem] ([Id], [OrderId], [ProductId], [ProductName], [ProductImage], [ProductDescription], [UnitPrice], [Quantity], [IngredientString], [ChoiceString], [Total]) VALUES (58, N'a30ed5ed-3491-4f1e-8875-745d2a34f42e', N'i001', N'Classic Burger Menu', N'mi_classic_burger_menu', N'Burger, Potato, Beverage', 18, 1, N'', N'', 18)
INSERT [dbo].[OrderItem] ([Id], [OrderId], [ProductId], [ProductName], [ProductImage], [ProductDescription], [UnitPrice], [Quantity], [IngredientString], [ChoiceString], [Total]) VALUES (59, N'941b36bc-cf9c-4518-8639-292860ea39cc', N'i012', N'Grilled Chicken Steak', N'mi_grilled_chicken_steak', N'Grilled chicken steak, pasta, salad', 16, 1, N'', N'', 16)
INSERT [dbo].[OrderItem] ([Id], [OrderId], [ProductId], [ProductName], [ProductImage], [ProductDescription], [UnitPrice], [Quantity], [IngredientString], [ChoiceString], [Total]) VALUES (60, N'a801a81d-8b16-4d9f-9868-736b7609d2c0', N'i011', N'Grilled Meatball', N'mi_meatball', N'Grilled meatball, salad, potato.', 25, 1, N'', N'', 25)
INSERT [dbo].[OrderItem] ([Id], [OrderId], [ProductId], [ProductName], [ProductImage], [ProductDescription], [UnitPrice], [Quantity], [IngredientString], [ChoiceString], [Total]) VALUES (61, N'9f17217f-18cd-4bc3-a600-2401c76549bc', N'i012', N'Grilled Chicken Steak', N'mi_grilled_chicken_steak', N'Grilled chicken steak, pasta, salad', 16, 1, N'', N'', 16)
INSERT [dbo].[OrderItem] ([Id], [OrderId], [ProductId], [ProductName], [ProductImage], [ProductDescription], [UnitPrice], [Quantity], [IngredientString], [ChoiceString], [Total]) VALUES (62, N'0a878637-df9a-44a6-b8a8-191a3df96149', N'i012', N'Grilled Chicken Steak', N'mi_grilled_chicken_steak', N'Grilled chicken steak, pasta, salad', 16, 1, N'', N'', 16)
SET IDENTITY_INSERT [dbo].[OrderItem] OFF
SET IDENTITY_INSERT [dbo].[RatePoints] ON 

INSERT [dbo].[RatePoints] ([Id], [Rate]) VALUES (1, 10)
SET IDENTITY_INSERT [dbo].[RatePoints] OFF
SET IDENTITY_INSERT [dbo].[ReferralRewards] ON 

INSERT [dbo].[ReferralRewards] ([Id], [ReferralId], [Balance], [IsTerminated], [CreatedAt], [UpdatedAt], [ExpirationDate]) VALUES (1, N'fa1ddca8-4ead-4799-ac9e-18ec51e72d8b', 0, 0, CAST(N'2023-08-15 09:07:57.3000000' AS DateTime2), NULL, CAST(N'2023-12-31 23:59:58.9966667' AS DateTime2))
INSERT [dbo].[ReferralRewards] ([Id], [ReferralId], [Balance], [IsTerminated], [CreatedAt], [UpdatedAt], [ExpirationDate]) VALUES (2, N'e3a08713-3d80-40ef-a464-9a3983b5c4cd', 0, 0, CAST(N'2023-08-20 13:43:42.0866667' AS DateTime2), NULL, CAST(N'2023-12-31 23:59:58.9966667' AS DateTime2))
INSERT [dbo].[ReferralRewards] ([Id], [ReferralId], [Balance], [IsTerminated], [CreatedAt], [UpdatedAt], [ExpirationDate]) VALUES (3, N'5435f9ff-8096-401e-9178-fc1deab2a048', 0, 0, CAST(N'2023-08-20 16:17:14.4600000' AS DateTime2), NULL, CAST(N'2023-12-31 23:59:58.9966667' AS DateTime2))
INSERT [dbo].[ReferralRewards] ([Id], [ReferralId], [Balance], [IsTerminated], [CreatedAt], [UpdatedAt], [ExpirationDate]) VALUES (4, N'dfee830d-3cd1-4a3e-b928-9cc04acd2192', 0, 0, CAST(N'2023-08-22 18:40:02.6366667' AS DateTime2), NULL, CAST(N'2023-12-31 23:59:58.9966667' AS DateTime2))
INSERT [dbo].[ReferralRewards] ([Id], [ReferralId], [Balance], [IsTerminated], [CreatedAt], [UpdatedAt], [ExpirationDate]) VALUES (5, N'1140a116-9749-4c37-8f7f-af0a86e9f30a', 0, 0, CAST(N'2023-08-31 19:33:36.3800000' AS DateTime2), NULL, CAST(N'2023-12-31 23:59:58.9966667' AS DateTime2))
INSERT [dbo].[ReferralRewards] ([Id], [ReferralId], [Balance], [IsTerminated], [CreatedAt], [UpdatedAt], [ExpirationDate]) VALUES (6, N'805762d5-4f7d-4c1f-a5de-e15405ab73c1', 0, 0, CAST(N'2023-09-03 12:57:22.9166667' AS DateTime2), NULL, CAST(N'2023-12-31 23:59:58.9966667' AS DateTime2))
INSERT [dbo].[ReferralRewards] ([Id], [ReferralId], [Balance], [IsTerminated], [CreatedAt], [UpdatedAt], [ExpirationDate]) VALUES (7, N'5efece17-7391-4371-9ec7-f191d5915e14', 0, 0, CAST(N'2023-09-03 16:38:25.8033333' AS DateTime2), NULL, CAST(N'2023-12-31 23:59:58.9966667' AS DateTime2))
SET IDENTITY_INSERT [dbo].[ReferralRewards] OFF
SET IDENTITY_INSERT [dbo].[Referrals] ON 

INSERT [dbo].[Referrals] ([Id], [ReferrerId], [RefereeId], [Points], [CreatedDate], [RefereeEmail], [ReferrerEmail], [ReferralCode], [OrderId], [ReferenceId]) VALUES (1, N'fa1ddca8-4ead-4799-ac9e-18ec51e72d8b', N'5435f9ff-8096-401e-9178-fc1deab2a048', 0, CAST(N'2023-08-20 16:17:14.3500000' AS DateTime2), N'baketnanga00@gmail.com', N'arciaga.clark00@gmail.com', N'AAA000', NULL, NULL)
SET IDENTITY_INSERT [dbo].[Referrals] OFF
SET IDENTITY_INSERT [dbo].[SMTPConfig] ON 

INSERT [dbo].[SMTPConfig] ([Id], [Type], [Email], [Password], [ApiKey], [ApiSecret]) VALUES (1, N'email_sms', N'servicing.tests@gmail.com', N'ahrbeqjafnaazmtx', N'26b1a35c', N'LloNIJE8CplxBNbn')
SET IDENTITY_INSERT [dbo].[SMTPConfig] OFF
SET IDENTITY_INSERT [dbo].[Vehicle] ON 

INSERT [dbo].[Vehicle] ([Id], [DriverId], [CarDescription], [CarRegistration], [DriversPhoto], [CarPhoto], [CreatedAt], [UpdateAt]) VALUES (1, N'c471f0bf-92e6-466d-a38a-8df5a88832ff', N'Toyota Vios', N'LT10001', N'https://foodappblobstorage.blob.core.windows.net:443/images/afd68c7b-39a3-4f52-992d-bb0f7aab411f.png', N'https://foodappblobstorage.blob.core.windows.net:443/images/86dda2bb-2f20-403e-95a5-5e48c8e638de.png', CAST(N'2023-08-28 10:08:45.6533333' AS DateTime2), CAST(N'2023-08-29 11:23:03.5433333' AS DateTime2))
INSERT [dbo].[Vehicle] ([Id], [DriverId], [CarDescription], [CarRegistration], [DriversPhoto], [CarPhoto], [CreatedAt], [UpdateAt]) VALUES (2, N'40140194-b9fd-488a-93cc-9b7a72c9ec59', N'Toyota Haris s', N'LT1002', N'https://foodappblobstorage.blob.core.windows.net:443/images/9ad420c0-a1be-45b4-bdea-3f22fd1e7b2a.png', N'https://foodappblobstorage.blob.core.windows.net:443/images/a29e2e04-0e4a-44b0-ac47-b8eeeef37f8a.png', CAST(N'2023-08-28 10:34:15.1166667' AS DateTime2), CAST(N'2023-08-28 10:40:03.6966667' AS DateTime2))
INSERT [dbo].[Vehicle] ([Id], [DriverId], [CarDescription], [CarRegistration], [DriversPhoto], [CarPhoto], [CreatedAt], [UpdateAt]) VALUES (3, N'b1df6432-282c-4e47-a16e-fa940c9c5f29', N'Brown truck', N'FZ 9111', N'https://foodappblobstorage.blob.core.windows.net:443/images/f1a21101-0074-4c93-b9d2-6d98543e85ea.png', N'https://foodappblobstorage.blob.core.windows.net:443/images/4ede71b8-24b4-4d10-a92e-582af5a61e1c.png', CAST(N'2023-08-29 08:20:03.9900000' AS DateTime2), NULL)
INSERT [dbo].[Vehicle] ([Id], [DriverId], [CarDescription], [CarRegistration], [DriversPhoto], [CarPhoto], [CreatedAt], [UpdateAt]) VALUES (4, N'64fd52b0-106d-4bdf-a21a-2165d04cce48', N'White Alphard Station Wagon', N'IP 211', N'https://lh3.googleusercontent.com/a/AAcHTtdJJdQJyBTnchiBijSO9tMJ5MK4FLTZ9tR85OnETZejWL8', N'https://foodappblobstorage.blob.core.windows.net:443/images/eeb3a786-9fd6-45c2-ac89-abd24079e829.png', CAST(N'2023-09-07 20:15:05.9766667' AS DateTime2), NULL)
SET IDENTITY_INSERT [dbo].[Vehicle] OFF
