USE [FoodAppApi_db]
GO
/****** Object:  StoredProcedure [dbo].[CheckForReferrals]    Script Date: 8/6/2023 3:23:28 AM ******/
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
	SELECT * from dbo.Referrals where ReferrerId=@CustomerId
END




GO
/****** Object:  StoredProcedure [dbo].[CheckIfFirstPurchase]    Script Date: 8/6/2023 3:23:29 AM ******/
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
	@RefereeId varchar(255),
	@CustomerId varchar(255)
AS
BEGIN
	SELECT COUNT(*) from dbo.[Order] where RefereeId = @RefereeId and CustomerId =@CustomerId and [Status] = 'Delivered'
END




GO
/****** Object:  StoredProcedure [dbo].[DeleteFavorite]    Script Date: 8/6/2023 3:23:29 AM ******/
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
/****** Object:  StoredProcedure [dbo].[GetActiveCustomerLoyaltyPointsByCustomerId]    Script Date: 8/6/2023 3:23:29 AM ******/
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
/****** Object:  StoredProcedure [dbo].[GetAddressByCustomerId]    Script Date: 8/6/2023 3:23:29 AM ******/
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
/****** Object:  StoredProcedure [dbo].[GetBanners]    Script Date: 8/6/2023 3:23:29 AM ******/
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
/****** Object:  StoredProcedure [dbo].[GetCategories]    Script Date: 8/6/2023 3:23:29 AM ******/
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
/****** Object:  StoredProcedure [dbo].[GetCategoryById]    Script Date: 8/6/2023 3:23:29 AM ******/
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
/****** Object:  StoredProcedure [dbo].[GetCustomerByEmail]    Script Date: 8/6/2023 3:23:29 AM ******/
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
/****** Object:  StoredProcedure [dbo].[GetCustomerByEmailAndPassword]    Script Date: 8/6/2023 3:23:29 AM ******/
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
/****** Object:  StoredProcedure [dbo].[GetCustomers]    Script Date: 8/6/2023 3:23:29 AM ******/
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
/****** Object:  StoredProcedure [dbo].[GetFavoriteByCustomerId]    Script Date: 8/6/2023 3:23:29 AM ******/
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
/****** Object:  StoredProcedure [dbo].[GetFeedbackByOrderId]    Script Date: 8/6/2023 3:23:29 AM ******/
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
/****** Object:  StoredProcedure [dbo].[GetItems]    Script Date: 8/6/2023 3:23:29 AM ******/
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
/****** Object:  StoredProcedure [dbo].[GetLoyaltyPointsByCustomerId]    Script Date: 8/6/2023 3:23:29 AM ******/
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
/****** Object:  StoredProcedure [dbo].[GetLoyaltyPointsHistory]    Script Date: 8/6/2023 3:23:29 AM ******/
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
/****** Object:  StoredProcedure [dbo].[GetMaxOrderId]    Script Date: 8/6/2023 3:23:29 AM ******/
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
/****** Object:  StoredProcedure [dbo].[GetOngoingOrder]    Script Date: 8/6/2023 3:23:29 AM ******/
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
/****** Object:  StoredProcedure [dbo].[GetOrderByCustomerId]    Script Date: 8/6/2023 3:23:29 AM ******/
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
/****** Object:  StoredProcedure [dbo].[GetOrderDetails]    Script Date: 8/6/2023 3:23:29 AM ******/
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
	select * from [Order] where CustomerId = @CustomerId and IsOngoingOrder=0 and OrderId = @OrderId
END




GO
/****** Object:  StoredProcedure [dbo].[GetOrderItemByOrderId]    Script Date: 8/6/2023 3:23:29 AM ******/
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
/****** Object:  StoredProcedure [dbo].[GetRatePoints]    Script Date: 8/6/2023 3:23:29 AM ******/
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
/****** Object:  StoredProcedure [dbo].[GetRewardsByCustomerId]    Script Date: 8/6/2023 3:23:29 AM ******/
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
	SELECT * from dbo.ReferralRewards where ReferralId=@ReferralId
END




GO
/****** Object:  StoredProcedure [dbo].[GetRewardsHistory]    Script Date: 8/6/2023 3:23:29 AM ******/
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
/****** Object:  StoredProcedure [dbo].[InsertAddress]    Script Date: 8/6/2023 3:23:29 AM ******/
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
/****** Object:  StoredProcedure [dbo].[InsertBanner]    Script Date: 8/6/2023 3:23:29 AM ******/
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
/****** Object:  StoredProcedure [dbo].[InsertCategory]    Script Date: 8/6/2023 3:23:29 AM ******/
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
/****** Object:  StoredProcedure [dbo].[InsertCustomer]    Script Date: 8/6/2023 3:23:29 AM ******/
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
        @Image varchar(255)
AS
BEGIN
    BEGIN TRY
        BEGIN TRANSACTION

        insert into Customer(CustomerId, FullName, Username, Email, [Password], Phone, DateOfBirth,
		Gender, AccountPreferences, TermsAndCondition, [Image], CreatedAt) values
		(@CustomerId, @FullName, @Username, @Email, @Password, @Phone, @DateOfBirth, @Gender, @AccountPreferences
		, @TermsAndCondition, @Image, CURRENT_TIMESTAMP)

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
/****** Object:  StoredProcedure [dbo].[InsertCustomerLoyaltyPoints]    Script Date: 8/6/2023 3:23:29 AM ******/
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
/****** Object:  StoredProcedure [dbo].[InsertFavorite]    Script Date: 8/6/2023 3:23:29 AM ******/
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
/****** Object:  StoredProcedure [dbo].[InsertFeedback]    Script Date: 8/6/2023 3:23:29 AM ******/
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
/****** Object:  StoredProcedure [dbo].[InsertItem]    Script Date: 8/6/2023 3:23:29 AM ******/
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
/****** Object:  StoredProcedure [dbo].[InsertLoyaltyPointsHistory]    Script Date: 8/6/2023 3:23:29 AM ******/
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
/****** Object:  StoredProcedure [dbo].[InsertOrder]    Script Date: 8/6/2023 3:23:29 AM ******/
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
        @RefereeId varchar(255)
AS
BEGIN
    BEGIN TRY
        BEGIN TRANSACTION

        insert into [Order](OrderId, CustomerId, DateGmt, [Address], AddressTitle,Shipping, Total, ModeOfPayment,
		IsOngoingOrder, [Status], PlacedTime, ProcessingTime,OnTheWayTime, DeliveredTime, CanceledTime, GrandTotal, Lat, Lon, RefereeId, CreatedAt) values
		(@OrderId, @CustomerId, @DateGmt, @Address, @AddressTitle, @Shipping, @Total, @ModeOfPayment, @IsOngoingOrder, @Status
		, @PlacedTime, @ProcessingTime,@OnTheWayTime, @DeliveredTime, @CanceledTime, @GrandTotal, @Lat, @Lon, @RefereeId, CURRENT_TIMESTAMP)

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
/****** Object:  StoredProcedure [dbo].[InsertOrderItem]    Script Date: 8/6/2023 3:23:29 AM ******/
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
/****** Object:  StoredProcedure [dbo].[InsertOrUpdateRatePoints]    Script Date: 8/6/2023 3:23:29 AM ******/
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
/****** Object:  StoredProcedure [dbo].[InsertReferralRewards]    Script Date: 8/6/2023 3:23:29 AM ******/
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

        insert into ReferralRewards(ReferralId, Balance, IsTerminated, CreatedAt) values
		(@ReferralId, 0, 0, CURRENT_TIMESTAMP)

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
/****** Object:  StoredProcedure [dbo].[InsertRewardHistory]    Script Date: 8/6/2023 3:23:29 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[InsertRewardHistory]
		@ReferralId varchar(255),
		@ReferrerId varchar(255),
		@OrderId varchar(255),
		@ActionType varchar(255),
		@Description varchar(255),
		@AddedBalance decimal(11,2),
		@AddedDate datetime
AS
BEGIN
    insert into ReferralRewardsHistory(ReferralId, ReferrerId, OrderId, ActionType, [Description], AddedBalance, AddedDate)
	values
	(@ReferralId, @ReferrerId, @OrderId, @ActionType, @Description, @AddedBalance, @AddedDate)
END


GO
/****** Object:  StoredProcedure [dbo].[SubtractCustomerLoyaltyPoints]    Script Date: 8/6/2023 3:23:29 AM ******/
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
/****** Object:  StoredProcedure [dbo].[UpdateAddress]    Script Date: 8/6/2023 3:23:29 AM ******/
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
/****** Object:  StoredProcedure [dbo].[UpdateBanner]    Script Date: 8/6/2023 3:23:29 AM ******/
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
/****** Object:  StoredProcedure [dbo].[UpdateCategory]    Script Date: 8/6/2023 3:23:29 AM ******/
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
/****** Object:  StoredProcedure [dbo].[UpdateCustomer]    Script Date: 8/6/2023 3:23:29 AM ******/
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
        @Image varchar(255)
AS
BEGIN
    BEGIN TRY
        BEGIN TRANSACTION

        update Customer set CustomerId=@CustomerId, FullName=@FullName, Username=@Username, Email=@Email, [Password]=@Password, Phone=@Phone, DateOfBirth=@DateOfBirth,
		Gender=@Gender, AccountPreferences=@AccountPreferences, TermsAndCondition=@TermsAndCondition, [Image]=@Image, UpdatedAt=CURRENT_TIMESTAMP
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
/****** Object:  StoredProcedure [dbo].[UpdateCustomerLoyaltyPoints]    Script Date: 8/6/2023 3:23:29 AM ******/
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
/****** Object:  StoredProcedure [dbo].[UpdateFeedback]    Script Date: 8/6/2023 3:23:29 AM ******/
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
/****** Object:  StoredProcedure [dbo].[UpdateItem]    Script Date: 8/6/2023 3:23:29 AM ******/
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
/****** Object:  StoredProcedure [dbo].[UpdateOrder]    Script Date: 8/6/2023 3:23:29 AM ******/
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
/****** Object:  StoredProcedure [dbo].[UpdateRewards]    Script Date: 8/6/2023 3:23:29 AM ******/
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
/****** Object:  Table [dbo].[__EFMigrationsHistory]    Script Date: 8/6/2023 3:23:29 AM ******/
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
/****** Object:  Table [dbo].[Address]    Script Date: 8/6/2023 3:23:29 AM ******/
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
/****** Object:  Table [dbo].[Banner]    Script Date: 8/6/2023 3:23:30 AM ******/
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
/****** Object:  Table [dbo].[Category]    Script Date: 8/6/2023 3:23:30 AM ******/
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
/****** Object:  Table [dbo].[Customer]    Script Date: 8/6/2023 3:23:31 AM ******/
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
	[Password] [nvarchar](max) NOT NULL,
	[Phone] [nvarchar](max) NOT NULL,
	[DateOfBirth] [datetime2](7) NOT NULL,
	[Gender] [nvarchar](max) NOT NULL,
	[AccountPreferences] [nvarchar](max) NOT NULL,
	[TermsAndCondition] [bit] NOT NULL,
	[Image] [nvarchar](max) NOT NULL,
	[CreatedAt] [datetime2](7) NULL,
	[UpdatedAt] [datetime2](7) NULL,
 CONSTRAINT [PK_Customer] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
)

GO
/****** Object:  Table [dbo].[CustomerLoyaltyPoints]    Script Date: 8/6/2023 3:23:31 AM ******/
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
/****** Object:  Table [dbo].[Favorite]    Script Date: 8/6/2023 3:23:32 AM ******/
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
/****** Object:  Table [dbo].[FeedBack]    Script Date: 8/6/2023 3:23:32 AM ******/
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
/****** Object:  Table [dbo].[Item]    Script Date: 8/6/2023 3:23:33 AM ******/
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
/****** Object:  Table [dbo].[LoyaltyPointsHistory]    Script Date: 8/6/2023 3:23:33 AM ******/
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
/****** Object:  Table [dbo].[Order]    Script Date: 8/6/2023 3:23:34 AM ******/
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
	[RefereeId] [nvarchar](255) NULL,
 CONSTRAINT [PK_Order] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
)

GO
/****** Object:  Table [dbo].[OrderItem]    Script Date: 8/6/2023 3:23:34 AM ******/
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
/****** Object:  Table [dbo].[RatePoints]    Script Date: 8/6/2023 3:23:35 AM ******/
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
/****** Object:  Table [dbo].[ReferralRewards]    Script Date: 8/6/2023 3:23:35 AM ******/
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
 CONSTRAINT [PK_ReferralRewards] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
)

GO
/****** Object:  Table [dbo].[ReferralRewardsHistory]    Script Date: 8/6/2023 3:23:36 AM ******/
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
 CONSTRAINT [PK_ReferralRewardsHistory] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
)

GO
/****** Object:  Table [dbo].[Referrals]    Script Date: 8/6/2023 3:23:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Referrals](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[ReferrerId] [nvarchar](255) NOT NULL,
	[RefereeID] [nvarchar](255) NOT NULL,
	[ReferrerName] [nvarchar](255) NULL,
	[RefereeName] [nvarchar](255) NULL,
	[Points] [int] NULL,
	[CreatedDate] [datetime2](7) NULL,
 CONSTRAINT [PK_Referrals] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
)

GO
