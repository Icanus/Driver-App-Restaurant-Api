GO

/****** Object:  StoredProcedure [dbo].[InsertAddress]    Script Date: 7/25/2023 12:52:56 PM ******/
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

