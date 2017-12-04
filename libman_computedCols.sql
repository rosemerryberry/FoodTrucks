-- employee age
CREATE FUNCTION fn_employeeAge(@EmployeeID int)
RETURNS int
AS
BEGIN
DECLARE @ret = (
    SELECT DateDiff(
        year, 
        (SELECT DOB FROM tblEmployee WHERE EmployeeID = @EmployeeID), 
        GETDATE()))
RETURN @ret
END

ALTER TABLE tblEmployee
ADD EmployeeAge
AS dbo.fn_employeeAge(EmployeeID)

-- num employees per truck
CREATE FUNCTION fn_employeePerTruck(@TruckID int)
RETURNS int
AS
BEGIN
DECLARE @ret = (
    SELECT count(*) 
    FROM tblTruck t 
    JOIN tblEmployee e ON e.TruckID = t.TruckID
    GROUP BY t.TruckID
)
RETURN @ret
END

ALTER TABLE tblTruck
ADD NumEmployees
AS dbo.fn_employeePerTruck(TruckID)