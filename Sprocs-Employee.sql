/*Sproc to get getPositionID*/
CREATE PROCEDURE getPositionID
@PositionName varchar(30), 
@PositionID INT OUTPUT
AS
BEGIN
SET @PositionID = (SELECT PositionID FROM tblPosition WHERE PositionName = @PositionName)
END

/*Sproc to getCompanyID*/
CREATE PROCEDURE getCompanyID
@CompanyName varchar(30), 
@CompanyID INT OUTPUT
AS
BEGIN
SET @CompanyID = (SELECT CompanyID FROM tblCompany WHERE CompanyName = @CompanyName)
END

/*Sproc to getEmployeeID*/
CREATE PROCEDURE getEmployeeID
@EmployeeFName varchar(30), 
@EmployeeLName varchar(30),
@EmployeeDOB date,
@EmployeeID INT OUTPUT
AS
BEGIN
SET @EmployeeID = (SELECT EmployeeID FROM tblEmployee WHERE FName = @EmployeeFName 
            AND LName = @EmployeeLName AND DOB = @EmployeeDOB)
END


/*********************************Populating Position/sproc for GetPositionID*****************************************/
use FoodTrucks1

create procedure PopulatePosition
	@PositionName varchar(50),
	@PositionDescription varchar(100)
as

declare @MenuID int

exec GetMenuID
	@MenuName = @MenuName,
	@MenuID = @MenuID OUTPUT

begin tran t1

insert into tblMenuItem (MenuID, MenuItemName) values (@MenuID, @MenuItemName)

IF @@ERROR <> 0
        ROLLBACK TRAN t1
ELSE
        COMMIT TRAN t1
go