CREATE PROCEDURE AddNewTruck
@companyName
@menuName


AS
DECLARE @companyID INT, @menuID INT
SET @companyID = (SELECT CompanyID FROM tblCompany WHERE CompanyName = @companyName)
SET @menuID = (SELECT MenuID tblFROM Menu WHERE MenuName = @menuName)

BEGIN TRAN T1

INSERT INTO TRUCK (CompanyID, MenuID) VALUES (@companyID, @menuID)

IF @@ERROR <> 0
 ROLLBACK TRAN T1
ELSE
 COMMIT TRAN T1
