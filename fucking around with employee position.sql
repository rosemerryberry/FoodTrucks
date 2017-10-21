USE [445_PROJ_FoodTrucks_JMR]
GO

/****** Object:  Table [dbo].[RAWEmployeePosition]    Script Date: 10/21/2017 2:32:08 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[RAWEmployeePositionPK](
	[EmployeePositionID] int identity(1,1) primary key not null,
	[F1] [float] NULL,
	[FName] [nvarchar](255) NULL,
	[LName] [nvarchar](255) NULL,
	[DOB] [datetime] NULL,
	[Position] [nvarchar](255) NULL
) ON [PRIMARY]

GO


insert into [dbo].[RAWEmployeePositionPK] (
	[F1],
	[FName],
	[LName],
	[DOB],
	[Position]
) select 
	[F1],
	[FName],
	[LName],
	[DOB],
	[Position]
 from [dbo].[RAWEmployeePosition] 