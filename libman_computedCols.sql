-- employee age
go
CREATE FUNCTION fn_employeeAge(@EmployeeID int)
RETURNS int
AS
BEGIN
DECLARE @ret int = (
    SELECT DateDiff(
        year, 
        (SELECT DOB FROM tblEmployee WHERE EmployeeID = @EmployeeID), 
        GETDATE()))
RETURN @ret
END
go
ALTER TABLE tblEmployee
ADD EmployeeAge
AS dbo.fn_employeeAge(EmployeeID)
go
-- num employees per truck
CREATE FUNCTION fn_employeePerTruck(@TruckID int)
RETURNS int
AS
BEGIN
DECLARE @ret int = (
    SELECT count(*) 
    FROM tblTruck t 
    JOIN tblEmployee e ON e.TruckID = t.TruckID
    GROUP BY t.TruckID
)
RETURN @ret
END
go
ALTER TABLE tblTruck
ADD NumEmployees
AS dbo.fn_employeePerTruck(TruckID)