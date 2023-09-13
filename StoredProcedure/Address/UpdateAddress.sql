GO

/****** Object:  StoredProcedure [dbo].[UpdateAddress]    Script Date: 7/25/2023 12:53:45 PM ******/
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
		where AddressId=@AddressId

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

