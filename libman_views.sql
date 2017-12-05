-- List menu per truck 
CREATE VIEW truckMenu (
    SELECT t.TruckName, m.MenuName, mi.MenuItemName
    FROM tblMenu m
    JOIN tblMenuItem mi ON m.MenuID = mi.MenuID
    JOIN tblTruck t ON t.MenuID = m.MenuID
)

-- What are the age demographics for each type of truck? 