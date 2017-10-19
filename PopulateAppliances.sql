USE FoodTrucks1
GO

/*tblApplianceType*/

INSERT INTO tblApplianceType(ApplianceName, ApplianceDescription) VALUES ('Refrigerator', 'Keeps food cool')

INSERT INTO tblApplianceType(ApplianceName, ApplianceDescription) VALUES ('Stove top', 'Something to head food on')

INSERT INTO tblApplianceType(ApplianceName, ApplianceDescription) VALUES ('Oven', 'Bake, broil, and otherwise alter food at high temperatures')

INSERT INTO tblApplianceType(ApplianceName, ApplianceDescription) VALUES ('Freezer', 'Keeps food ice cold')

INSERT INTO tblApplianceType(ApplianceName, ApplianceDescription) VALUES ('Stove burner', 'The metal piece on which to heat food on the stove')

INSERT INTO tblApplianceType(ApplianceName, ApplianceDescription)VALUES ('Dishwasher', 'Cleans dishes quickly')

INSERT INTO tblApplianceType(ApplianceName, ApplianceDescription) VALUES ('Microwave', 'Heats food quickly')

/*tblLocation_Name*/

INSERT INTO tblLocation_Name (LocationDescription, LocationName) VALUES ('Near Amazon', 'South Lake Union')

INSERT INTO tblLocation_Name (LocationDescription, LocationName) VALUES ('North Georgetown', 'Near Costco')

INSERT INTO tblLocation_Name (LocationDescription, LocationName) VALUES ('Central Downtown', 'Near Pike Place Market')

INSERT INTO tblLocation_Name (LocationDescription, LocationName) VALUES ('Ballard 1', 'Near Ballard High School')

INSERT INTO tblLocation_Name (LocationDescription, LocationName) VALUES ('Ballard 2', 'Near the marina')

INSERT INTO tblLocation_Name (LocationDescription, LocationName) VALUES ('University District 1', 'Middle of the Ave')

/*Sproc to get locationNameID*/
CREATE PROCEDURE getLocationNameID
@locationName varchar(30), 
@locationNameID INT OUTPUT
AS
BEGIN
SET @locationNameID = (SELECT Location_NameID FROM tblLocation_Name WHERE LocationName = @locationName)
END

/*Sproc to populate location*/

CREATE PROCEDURE getLocationNameID
@locationName varchar(30), 
@locationNameID INT OUTPUT
AS
BEGIN
SET @locationNameID = (SELECT Location_NameID FROM tblLocation_Name WHERE LocationName = @locationName)
END
GO

CREATE PROCEDURE usp_AddNewLocation
@locName varchar(30),
@streetAddress varchar(50),
@zip INT

AS
DECLARE @locNameID INT

EXEC [getLocationNameID]
 @locationName = @locName,
 @locationNameID = @locNameID OUTPUT


BEGIN TRAN t
INSERT INTO tblLocation (Location_NameID, StreetAddress, Zip)
VALUES(@locNameID, @streetAddress, @zip)


IF @@ERROR <> 0
 ROLLBACK TRAN t
ELSE
 COMMIT TRAN t

EXEC [usp_AddNewLocation]
@locName = 'South Lake Union',
@streetAddress = '1635 Ruskin Hill',
@zip = 98115

EXEC [usp_AddNewLocation]
@locName = 'South Lake Union',
@streetAddress = '5960 Fulton Parkway',
@zip = 98125

EXEC [usp_AddNewLocation]
@locName = 'South Lake Union',
@streetAddress = '56 Forest Crossing',
@zip = 98135

EXEC [usp_AddNewLocation]
@locName = 'South Lake Union',
@streetAddress = '82010 Briar Crest Center',
@zip = 18283


EXEC [usp_AddNewLocation]
@locName = 'South Lake Union',
@streetAddress = '68776 Fordem Drive',
@zip = 29305

EXEC [usp_AddNewLocation]
@locName = 'South Lake Union',
@streetAddress = '2 Dexter Way',
@zip = 98112

EXEC [usp_AddNewLocation]
@locName = 'South Lake Union',
@streetAddress = '1635 Ruskin Hill',
@zip = 98115

EXEC [usp_AddNewLocation]
@locName = 'Near Costco',
@streetAddress = '5960 Fulton Parkway',
@zip = 98125

EXEC [usp_AddNewLocation]
@locName = 'Near Pike Place Market',
@streetAddress = '56 Forest Crossing',
@zip = 98135

EXEC [usp_AddNewLocation]
@locName = 'Near Ballard High School',
@streetAddress = '82010 Briar Crest Center',
@zip = 18283


EXEC [usp_AddNewLocation]
@locName = 'Near the marina',
@streetAddress = '68776 Fordem Drive',
@zip = 29305

EXEC [usp_AddNewLocation]
@locName = 'South Lake Union',
@streetAddress = '2 Dexter Way',
@zip = 98112


INSERT INTO tblTruck(CompanyID, MenuID) VALUES (1, 2)
INSERT INTO tblTruck(CompanyID, MenuID) VALUES (2, 2)
INSERT INTO tblTruck(CompanyID, MenuID) VALUES (3, 2)
INSERT INTO tblTruck(CompanyID, MenuID) VALUES (1, 4)
INSERT INTO tblTruck(CompanyID, MenuID) VALUES (2, 5)
INSERT INTO tblTruck(CompanyID, MenuID) VALUES (5, 3)
INSERT INTO tblTruck(CompanyID, MenuID) VALUES (1, 5)

