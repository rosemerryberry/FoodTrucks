/*inserting into Menu_Type */
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
	('American', 'Featuring the seattle dog and milkshakes')
	('Mexican', 'Bitchin Beans')
GO

/*inserting into Menu SPROC*/
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

/*populating customer and order*/

