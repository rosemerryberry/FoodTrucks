/************************inserting into Position / GetPositionID sproc**************************************/
use FoodTrucks1
GO

INSERT INTO tblPosition (PositionName, PositionDescription) 
VALUES 
('Manager','Runs day-to-day of truck'),
('Intern','Part-time team member'),
('Cashier','Handles transactions with customers'),
('Cook','Makes orders'),
('Bookkeeper','Manages all payments'),
('Promoter','Encourages people to eat at truck')
go

alter procedure GetPositionID
	@PositionName varchar(50),
	@PositionID int OUTPUT
as
begin
	select @PositionID = PositionID
	from tblPosition
	where @PositionName = PositionName
end
go


/************************inserting into Company / GetCompanyID sproc**************************************/

use FoodTrucks1
GO

INSERT INTO tblCompany (CompanyName, CompanyDescription)
VALUES
('Timmy and Taco','Mexican food'),
('Grilled Cheeses','Hot food with cheese'),
('India','Authentic Indian food'),
('Vegan Heaven','All vegan menu'),
('Olive You','Italian'),
('BYO','Build your own food'),
('BBQueue','Southern cuisine'),
('Corn Stalkoverflow','Make fun corn here'),
('Short Stackopancakes','Breakfast foods'),
('iSchream','Ice cream and gelato'),
('Cotton Candy Cloud','Desserts'),
('Lez Talk-o bout IT','Mexican food'),
('PC&J','Sandwiches'),
('Mac&cheesy','All kinds of macaroni'),
('4K Cheese Pizza','Fresh pizza'),
('Mango Mongo','Smoothie bar'),
('Digital Seafood','Fish and seafood'),
('Android Oreo','Desserts')
go

alter procedure GetCompanyID
	@CompanyName varchar(50),
	@CompanyID int OUTPUT
as
begin
	select @CompanyID = CompanyID
	from tblCompany
	where @CompanyName = CompanyName
end
go

/************************inserting into EmployeeTEMP**************************************/

use [445_PROJ_FoodTrucks_JMR]

CREATE TABLE tblEmployeeTEMP(
	EMPID INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
	FName VARCHAR(50) NOT NULL,
	LName VARCHAR(100) NOT NULL,
    DOB date
)
INSERT INTO tblEmployeeTEMP (FName, LName, DOB)
SELECT TOP 100000 CustomerFName, CustomerLName, DateOfBirth FROM CUSTOMER_BUILD.[tblCUSTOMER]

/**************************importing data into employee !!! need truck info dammit***********************************/
go

create procedure PopulateEmployee
as

IF EXISTS (SELECT Name
	FROM sys.Objects
	WHERE Name = 'WorkingEmployeeDataPK')
	BEGIN
	DROP TABLE WorkingCustomerDataPK
	end

select * into WorkingEmployeeDataPK from [dbo].[RAWEmployeePositionPK]

declare @PositionName varchar(50)
Declare @PositionID int
declare @FName varchar(50)
declare @Lname varchar(50)
declare @DOB varchar(50)
declare @EmployeeID int

declare @RUN int

set @RUN = (select count(*) from WorkingEmployeeDataPK)

while @RUN > 0
	
	set @EmployeeID = (Select min(EmployeePositionID) from WorkingEmployeeDataPK)
	set @PositionName = (select Position from WorkingEmployeeDataPK where EmployeePositionID = @EmployeeID)
	set @FName = (select FName from WorkingEmployeeDataPK where EmployeePositionID = @EmployeeID)
	set @LName = (select LName from WorkingEmployeeDataPK where EmployeePositionID = @EmployeeID)
	set @DOB = (select DOB from WorkingEmployeeDataPK where EmployeePositionID = @EmployeeID)

	exec GetPositionID (
		@PositionName = @PositionName,
		@PositionID = @PositionID OUTPUT
	)

begin tran t1

	insert into tblEmployee


