UUSE [HR]
GO

/****** Object:  Table [dbo].[HRData]    Script Date: 17/11/2021 13:31:44 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[HRData](
	[ID] [nvarchar](50) NOT NULL PRIMARY KEY,
	[object Type] [nvarchar](50) NULL,
	[manager] [nchar](10) NULL,
	[HRType] [nvarchar](50) NULL,
	[title] [nvarchar](50) NULL,
	[department] [nvarchar](50) NULL,
	[firstName] [nvarchar](50) NULL,
	[middlename] [nvarchar](50) NULL,
	[lastname] [nvarchar](50) NULL,
) ON [PRIMARY]
GO