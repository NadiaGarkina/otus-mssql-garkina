--- 1. Написать функцию возвращающую Клиента с наибольшей суммой покупки.
USE WideWorldImporters;
IF OBJECT_ID (N'dbo.fGetMaxSumma', N'FN') IS NOT NULL
DROP FUNCTION dbo.fGetMaxSumma;
GO
CREATE FUNCTION dbo.fGetMaxSumma()
RETURNS int
AS
BEGIN
DECLARE @CustomerID INT;
with b as (
select si.InvoiceID, sum(si.Quantity*si.UnitPrice) as summa 
from Sales.InvoiceLines si
group by si.InvoiceID)
select top 1 @CustomerID=i.CustomerID
from Sales.Invoices i 
inner join b on b.InvoiceID=i.InvoiceID
order by b.summa desc
RETURN @CustomerID
END

select dbo.fGetMaxSumma()

--- 2. Написать хранимую процедуру с входящим параметром СustomerID, выводящую сумму покупки по этому клиенту.
create procedure dbo.summa0 @CustomerID int
as begin
select 
sum(si.Quantity*si.UnitPrice) as summa 
from Sales.InvoiceLines si
inner join Sales.Invoices i ON i.InvoiceID = si.InvoiceID
where i.CustomerID=@CustomerID
group by i.CustomerID
end

exec dbo.summa0  834

--- 3. Создать одинаковую функцию и хранимую процедуру, посмотреть в чем разница в производительности и почему.
USE WideWorldImporters;
IF OBJECT_ID (N'dbo.fGetMaxSumma1', N'FN') IS NOT NULL
DROP FUNCTION dbo.fGetMaxSumma1;
GO
CREATE FUNCTION dbo.fGetMaxSumma1(@CustomerId int)
RETURNS DECIMAL (18, 2)
AS
BEGIN
return
(select sum(si.Quantity*si.UnitPrice) as summa 
from Sales.InvoiceLines si
inner join Sales.Invoices i ON i.InvoiceID = si.InvoiceID
where i.CustomerID=@CustomerID)
end
--- при выполнении схожих процедуры и функции у меня весь ресурс затрачен на процедуру, 
--- возможно из-за использования в выполнении процедуры колоночного индекса, а в функции Constant Scan то есть поиск по константе.
exec dbo.summa0  900 
select dbo.fGetMaxSumma1(900)

--- 4. Создайте табличную функцию покажите как ее можно вызвать для каждой строки result set'а без использования цикла.
--- вывести всех клиентов с датами последнего заказа
USE WideWorldImporters;
IF OBJECT_ID (N'dbo.fGetCustomerOrderDate', N'FN') IS NOT NULL
DROP FUNCTION dbo.fGetCustomerOrderDate;
GO
CREATE FUNCTION dbo.fGetCustomerOrderDate(@CustomerId int)
RETURNS table
as
return
(select CustomerID, max(OrderDate) as maxdate 
from  Sales.Orders o
where o.CustomerID=@CustomerID
group by CustomerID
)
--- выбираем всех клиентов с последними датами с помощью cross apply
select c.CustomerID, a.maxdate
from sales.Customers c
CROSS APPLY (
select f.maxdate
from dbo.fGetCustomerOrderDate(c.CustomerID) f
) as a
order by CustomerID

