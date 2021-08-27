TRUNCATE TABLE [dbo].[User]

DECLARE @responseMessage NVARCHAR(250)

EXEC dbo.uspAddUser
          @pLogin = N'Admin',
          @pPassword = N'123',
          @pFirstName = N'Admin',
          @pLastName = N'Administrator',
          @responseMessage=@responseMessage OUTPUT

SELECT UserID, LoginName, PasswordHash, Salt, FirstName, LastName
FROM [dbo].[User]