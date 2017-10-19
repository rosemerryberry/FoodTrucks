USE [FoodTrucks1]
GO

/****** Object:  Table [dbo].[RAWCustomer]    Script Date: 10/18/2017 10:56:59 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO
use FoodTrucks1
CREATE TABLE [dbo].[RAWCustomerPK](
	CustomerOrderID int identity(1,1) primary key not null,
	[F1] [float] NULL,
	[FName] [nvarchar](255) NULL,
	[LName] [nvarchar](255) NULL,
	[DOB] [datetime] NULL,
	[OrderDate] [datetime] NULL,
	[MenuName] [nvarchar](255) NULL
)

GO

insert into [dbo].[RAWCustomerPK] (
[F1],
	[FName],
	[LName],
	[DOB],
	[OrderDate],
	[MenuName]
)
select [F1],
	[FName],
	[LName],
	[DOB],
	[OrderDate],
	[MenuName]
from [dbo].[RAWCustomer]


