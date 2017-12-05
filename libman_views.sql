-- List menu per truck 
CREATE VIEW [dbo].[truckMenu] as (
    SELECT t.TruckName, m.MenuName, mi.MenuItemName
    FROM tblMenu m
    JOIN tblMenuItem mi ON m.MenuID = mi.MenuID
    JOIN tblTruck t ON t.MenuID = m.MenuID
)

-- What are the age demographics for each truck? 
CREATE VIEW [dbo].[truckDemographics] as (
    SELECT (CASE 
        WHEN c.DOB < (GetDate() - (365.25 * 12))
        THEN 'Child'
        WHEN c.DOB BETWEEN (GetDate() - (365.25 * 12)) AND (GetDate() - (365.25 * 19))
        THEN 'Teen'
        WHEN c.DOB BETWEEN (GetDate() - (365.25 * 19)) AND (GetDate() - (365.25 * 34))
        THEN 'Young Adult'
        WHEN c.DOB BETWEEN (GetDate() - (365.25 * 34)) AND (GetDate() - (365.25 * 65))
        THEN 'Adult'
        WHEN c.DOB > (GetDate() - (365.25 * 65))
        THEN 'Senior'
        ELSE 'Unknown'
        END) AS Generation
    FROM tblTruck t
    JOIN tblMenu m ON m.MenuID = t.MenuID
    JOIN tblOrder o ON o.MenuID = m.MenuID
    JOIN tblCustomer c ON c.CustomerID = o.CustomerID
)
