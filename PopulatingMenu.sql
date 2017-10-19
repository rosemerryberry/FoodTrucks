/************************inserting into Menu_Type**************************************/
use FoodTrucks1

insert into tblMenu_Type(Menu_TypeName, Menu_TypeDescription) VALUES
	('Indian', 'Spicy af'),
	('Gluten Free', 'Absolutely no gluten'),
	('Greek', 'Featuring olives and feta, so our customers arent fed up'),
	('Vegan', 'Our customers watched What the Health'),
	('Wings', 'Literally just wings'),
	('Dessert', 'Lots of chocolate'),
	('Korean BBQ', 'Humbaos for days'),
	('Salads', 'Lettuce serve your dietary needs'),
	('American', 'Featuring the seattle dog and milkshakes'),
	('Mexican', 'Bitchin Beans')
GO

create procedure GetMenuTypeID(
	@Menu_TypeName varchar(50),
	@Menu_TypeID int OUTPUT
)
as
begin
	select @Menu_TypeID = Menu_TypeID
	from tblMenu_Type
	where Menu_TypeName = @Menu_TypeName
end
go


/********************************inserting into Menu SPROC*************************************/
USE FoodTrucks1
GO

CREATE PROCEDURE PopulateMenu
	@MenuTypeName varchar(50),
	@MenuName varchar(50)
AS
declare @Menu_TypeID int = (SELECT [Menu_TypeID]
  FROM [FoodTrucks1].[dbo].[tblMenu_Type]
  WHERE Menu_TypeName = @MenuTypeName)

begin tran t1
insert into tblMenu(Menu_TypeID, MenuName) 
values (@Menu_TypeID, @MenuName)
IF @@ERROR <> 0
      ROLLBACK TRAN t1
ELSE
      COMMIT TRAN t1
GO

EXEC PopulateMenu
	@MenuTypeName = 'Indian', 
	@MenuName = 'I Can Show You The World'
GO

EXEC PopulateMenu
	@MenuTypeName = 'Gluten Free', 
	@MenuName = 'Bread is the Devil'
GO

EXEC PopulateMenu
	@MenuTypeName = 'Greek', 
	@MenuName = 'I Love Olives'
GO

EXEC PopulateMenu
	@MenuTypeName = 'Vegan', 
	@MenuName = 'Vegemites'
GO

EXEC PopulateMenu
	@MenuTypeName = 'Mexican', 
	@MenuName = 'Tacos are Fancy Sandwiches'
GO

EXEC PopulateMenu
	@MenuTypeName = 'Wings', 
	@MenuName = 'Wings'
GO

EXEC PopulateMenu
	@MenuTypeName = 'Dessert', 
	@MenuName = 'Sweet Tooth'
GO

EXEC PopulateMenu
	@MenuTypeName = 'Korean BBQ', 
	@MenuName = 'No BBQuestions Asked'
GO

EXEC PopulateMenu
	@MenuTypeName = 'Salads', 
	@MenuName = 'Rabbit Food'
GO

EXEC PopulateMenu
	@MenuTypeName = 'American', 
	@MenuName = 'Hot Dawg'
GO

/******************************populating customer and order****************************/
/******************************get customer and menu IDs******************************/
use FoodTrucks1

insert into tblCustomer 
	select distinct FName, LName, DOB 
	from RAWCustomer
GO

alter procedure GetCustomerID(
	@FName varchar(50),
	@LName varchar(50),
	@DOB date,
	@CustomerID int OUTPUT
)
as 
begin
	select @CustomerID = CustomerID
	from tblCustomer
	where @FName = Fname AND @LName = LName AND @DOB = DOB
end
go
/* testing
declare @CustomerID int
exec GetCustomerID
	@FName = 'Aaron', 
	@LName = 'Bass', 
	@DOB = '1976-10-22',
	@CustomerID = @CustomerID
print @CustomerID
go
*/
create procedure GetMenuID
	@MenuName varchar(50),
	@MenuID int OUTPUT
as
begin
	select @MenuID = MenuID
	from tblMenu
	where @MenuName = MenuName
end
go

alter procedure PopulateOrder
as

IF EXISTS (SELECT Name
	FROM sys.Objects
	WHERE Name = 'WorkingCustomerDataPK')
	BEGIN
	DROP TABLE WorkingCustomerDataPK
	end

select * into WorkingCustomerDataPK from [dbo].[RAWCustomerPK]

declare @OrderID int
declare @MenuID int
declare @MenuName varchar(50)
declare @OrderDate date
declare @CustomerID int
declare @FName varchar(50)
declare @LName varchar(50)
declare @DOB date

declare @RUN int

SET @RUN = (SELECT COUNT(*) FROM WorkingCustomerDataPK)

WHILE @RUN > 0

BEGIN

  SET @OrderID = (SELECT Min(CustomerOrderID) FROM WorkingCustomerDataPK) 
  set @MenuName = (Select MenuName from WorkingCustomerDataPK where CustomerOrderID = @OrderID)
  set @OrderDate = (select OrderDate from WorkingCustomerDataPK where OrderDate = @OrderDate)
  set @FName = (select FName from WorkingCustomerDataPK where FName = @FName)
  set @LName = (select LName from WorkingCustomerDataPK where LName = @LName)
  set @DOB = (select DOB from WorkingCustomerDataPK where DOB = @DOB)

  exec [GetMenuID]
	@MenuName = @MenuName,
	@MenuID = @MenuID OUTPUT
	
  exec [GetCustomerID]
	@FName = @FName,
	@LName = @LName,
	@DOB = @DOB,
	@CustomerID = @CustomerID OUTPUT

begin tran t1

insert into [dbo].[tblOrder]
(MenuID, CustomerID, OrderDate)
values
(@MenuID, @CustomerID, @OrderDate)

IF @@ERROR <> 0

        ROLLBACK TRAN t1

ELSE

        COMMIT TRAN t1

DELETE

FROM WorkingCustomerDataPK

WHERE CustomerOrderID = @OrderID

SET @RUN = @RUN - 1

END

exec PopulateOrder
go

/***************************************populate supplier and get supplierID**********************************************/
use FoodTrucks1
GO

INSERT INTO tblSupplier (SupplierName, SupplierDescription) VALUES 
	('All Star','Commercial Grocer'),
	('Kroger','General Grocer'),
	('Charlies Produce','General Produce'),
	('Billys Brewery','Alcohol Provider'),
	('The Market','Specialty Provider'),
	('Jills Herbs','Herb Provider'),
	('Mom and Pops','Butcher')

GO

alter procedure GetSupplierID(
	@SupplierName varchar(50),
	@SupplierID int OUTPUT
)

as
begin
	set @SupplierID = (select SupplierID
	from tblSupplier 
	WHERE SupplierName = @SupplierName)
end
GO

/***************************************populate ingredient***************************************/
use FoodTrucks1

alter procedure PopulateIngredient
	@IngredientName varchar(50),
	@IngredientDescription varchar(100),
	@SupplierName varchar(50)
as
declare @SupplierID int

exec GetSupplierID
	@SupplierName = @SupplierName,
	@SupplierID = @SupplierID OUTPUT

begin tran t1
	insert into tblIngredient (IngredientName, IngredientDescription, SupplierID)
	values (@IngredientName, @IngredientDescription, @SupplierID)

IF @@ERROR <> 0
      ROLLBACK TRAN t1
ELSE
      COMMIT TRAN t1
GO

exec PopulateIngredient
	@IngredientName = 'Coconut Milk',
	@IngredientDescription = 'tropical coconut water',
	@SupplierName = 'Kroger'
go

exec PopulateIngredient
	@IngredientName = 'Spices',
	@IngredientDescription = 'spicy',
	@SupplierName = 'The Market'
go

exec PopulateIngredient
	@IngredientName = 'Tofu',
	@IngredientDescription = 'sauce sponge',
	@SupplierName = 'Kroger'
go

exec PopulateIngredient
	@IngredientName = 'Flour',
	@IngredientDescription = 'dusty',
	@SupplierName = 'All Star'
go

exec PopulateIngredient
	@IngredientName = 'Garlic',
	@IngredientDescription = 'delicious',
	@SupplierName = 'Charlies Produce'
go

exec PopulateIngredient
	@IngredientName = 'Tomatos',
	@IngredientDescription = 'fruits?',
	@SupplierName = 'Charlies Produce'
go

exec PopulateIngredient
	@IngredientName = 'Beer',
	@IngredientDescription = 'alcohol',
	@SupplierName = 'Billys Brewery'
go

exec PopulateIngredient
	@IngredientName = 'Honey',
	@IngredientDescription = 'sweet',
	@SupplierName = 'Jills Herbs'
go

exec PopulateIngredient
	@IngredientName = 'Pine Nuts',
	@IngredientDescription = 'expensive',
	@SupplierName = 'Jills Herbs'
go

exec PopulateIngredient
	@IngredientName = 'Yeast',
	@IngredientDescription = 'tiny bacterias',
	@SupplierName = 'Kroger'
go

/*********************************Populating MenuItem/sproc for GetMenuItemID*****************************************/
create procedure PopulateMenuItem
	@MenuItemName varchar(50),
	@MenuName varchar(50)
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

exec PopulateMenuItem
	@MenuItemName = 'Curry',
	@MenuName = 'I Can Show You The World'
go

exec PopulateMenuItem
	@MenuItemName = 'Naan',
	@MenuName = 'I Can Show You The World'
go

exec PopulateMenuItem
	@MenuItemName = 'Chai',
	@MenuName = 'I Can Show You The World'
go

exec PopulateMenuItem
	@MenuItemName = 'Pizza',
	@MenuName = 'Bread is the Devil'
go

exec PopulateMenuItem
	@MenuItemName = 'Pasta',
	@MenuName = 'Bread is the Devil'
go

exec PopulateMenuItem
	@MenuItemName = 'Beer',
	@MenuName = 'Bread is the Devil'
go

exec PopulateMenuItem
	@MenuItemName = 'Gyro',
	@MenuName = 'I Love Olives'
go

exec PopulateMenuItem
	@MenuItemName = 'Baclava',
	@MenuName = 'I Love Olives'
go

exec PopulateMenuItem
	@MenuItemName = 'Spanikopita',
	@MenuName = 'I Love Olives'
go

exec PopulateMenuItem
	@MenuItemName = 'Hummus',
	@MenuName = 'Vegemites'
go

exec PopulateMenuItem
	@MenuItemName = 'Soup',
	@MenuName = 'Vegemites'
go

exec PopulateMenuItem
	@MenuItemName = 'Panini',
	@MenuName = 'Vegemites'
go

exec PopulateMenuItem
	@MenuItemName = 'Spicy Wings',
	@MenuName = 'Wings'
go

create procedure GetMenuItemID
	@MenuItemName varchar(50),
	@MenuItemID int OUTPUT
as
begin
	select MenuItemID = @MenuItemID
	from tblMenuItem
	where MenuItemName = @MenuItemName
end
