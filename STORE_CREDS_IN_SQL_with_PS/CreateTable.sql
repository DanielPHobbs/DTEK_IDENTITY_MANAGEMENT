USE DTEK_IDENTITY_MANAGEMENT;
go

drop table if exists [UserEncryptedPwd];
go

CREATE TABLE [dbo].[UserEncryptedPwd] (
   [UserName] varchar(30) 
  ,[EncryptedPWD] varchar(2000) -- secure string for the password
  ,[Creator] varchar(128) -- who created the secure string for the password
  ,[HostComputer] varchar(128) -- where the secure string was created
  , ID int identity primary key );