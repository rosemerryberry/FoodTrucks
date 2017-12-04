-- Truck location in seattle (based on ZIP) Jess

CREATE FUNCTION fn_seattleTruckLocation()
RETURNS INT
as
begin
declare @ret int = 0
if exists (
    select * from tblLocation l
    where l.ZIP < 98101 AND l.ZIP > 98199
) set @ret = 1
return @ret
end


-- No customer can have over 50 orders in one day

CREATE FUNCTION fn_customerOrderLimit()
RETURNS INT
as
begin
DECLARE @ret int = 0
if exists (
    select * from tblCustomer c
    join tblOrder o on o.CustomerID = c.CustomerID
    where o.OrderDate = GETDATE()
    GROUP BY o.CustomerID
    having count(*) > 50

) set @ret = 1
return @ret
end

ALTER TABLE tblLocation
ADD CONSTRAINT locationCheck
CHECK (dbo.fn_seattleTruckLocation() = 0)


ALTER TABLE tblOrder
ADD CONSTRAINT maxOrders
CHECK (dbo.fn_customerOrderLimit() = 0)
