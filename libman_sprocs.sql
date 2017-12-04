CREATE PROCEDURE usp_AddNewLocationName
@LocationName varchar(35),
@LocationDescription varchar(50)

AS
BEGIN TRAN T1
INSERT INTO tblLocation_Name (LocationDescription, LocationName) VALUES (@LocationDescription, @LocationName)

IF @@ERROR <> 0
ROLLBACK TRAN T1
ELSE 
COMMIT TRAN 




CREATE PROCEDURE usp_AddNewLocation
@LocName varchar(35),
@StreetAddress varchar(50),
@Zip INT

AS
DECLARE @LocationNameID INT

EXEC [uspGetLocationNameID]
@LocName = @LocationName,
@LNameID = @LocationNameID OUTPUT

IF @LocationNameID IS NULL
BEGIN
PRINT '@LocationNameID IS NULL and will fail on insert statement; process terminated'
RAISERROR ('LocationNameID variable @LocationNameID cannot be NULL',11,1)
RETURN END

BEGIN TRAN T1
INSERT INTO tblLocation (Location_NameID, StreetAddress, Zip) VALUES (@LocationNameID, @StreetAddress, @Zip)

IF @@ERROR <> 0
ROLLBACK TRAN T1
ELSE 
COMMIT TRAN T1



CREATE PROCEDURE usp_AddMenuItemIngredient
@MenuItemName varchar(35),
@IngredientName varchar(35),
@IngredientDescription varchar(70),
@Quantity INT,
@Calories INT

AS
DECLARE @IngredientID INT, @MenuItemID INT

EXEC [uspGetIngredientID]
@IngredientDescription = @IngredientDescription,
@IngredientName = @IngredientName,
@IngredientID = @IngredientID OUTPUT

EXEC [uspGetIngredientID]
@MenuItemName = @MenuItemName,
@MenuItemID = @MenuItemID OUTPUT

IF @IngredientID IS NULL
BEGIN
PRINT '@IngredientID IS NULL and will fail on insert statement; process terminated'
RAISERROR ('IngredientID variable @IngredientID cannot be NULL',11,1)
RETURN END

IF @MenuItemID IS NULL
BEGIN
PRINT '@MenuItemID IS NULL and will fail on insert statement; process terminated'
RAISERROR ('MenuItemID variable @MenuItemID cannot be NULL',11,1)
RETURN END




----ROSE---

CREATE PROCEDURE uspGetIngredientID
@IngredientDescription varchar(50), 
@IngredientName varchar(35),
@SupplierName varchar(35), 
@SupplierDescription varchar(50),
@IngredientID int OUTPUT

AS
DECLARE @SupplierID INT

EXEC [uspGetSupplierID]
@SupplierDescription = @SupplierDescription,
@SupplierName = @SupplierName
@SupplierID = @SupplierID OUTPUT

BEGIN
SELECT IngredientID = @IngredientID
FROM tblIngredient
WHERE SupplierID = @SupplierID AND IngredientName = @IngredientName AND IngredientDescription = @IngredientDescription