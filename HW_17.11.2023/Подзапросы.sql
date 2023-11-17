/*
�������� ������� �� ����� MS SQL Server Developer � OTUS.

������� "03 - ����������, CTE, ��������� �������".

������� ����������� � �������������� ���� ������ WideWorldImporters.

����� �� ����� ������� ������:
https://github.com/Microsoft/sql-server-samples/releases/tag/wide-world-importers-v1.0
����� WideWorldImporters-Full.bak

�������� WideWorldImporters �� Microsoft:
* https://docs.microsoft.com/ru-ru/sql/samples/wide-world-importers-what-is
* https://docs.microsoft.com/ru-ru/sql/samples/wide-world-importers-oltp-database-catalog
*/

-- ---------------------------------------------------------------------------
-- ������� - �������� ������� ��� ��������� ��������� ���� ������.
-- ��� ���� �������, ��� ��������, �������� ��� �������� ��������:
--  1) ����� ��������� ������
--  2) ����� WITH (��� ����������� ������)
-- ---------------------------------------------------------------------------

USE WideWorldImporters

/*
1. �������� ����������� (Application.People), ������� �������� ������������ (IsSalesPerson), 
� �� ������� �� ����� ������� 04 ���� 2015 ����. 
������� �� ���������� � ��� ������ ���. 
������� �������� � ������� Sales.Invoices.
*/

--- ������� 1
select distinct p.PersonID, p.FullName
from [Application].People p
inner join Sales.Invoices i on i.SalespersonPersonID=p.PersonID
where i.SalespersonPersonID not in (select distinct i.SalespersonPersonID from Sales.Invoices i where i.InvoiceDate= '2015-07-04')

--- ������� 2
select p.PersonID, p.FullName
from [Application].People p
WHERE p.PersonID in (select distinct i.SalespersonPersonID from Sales.Invoices i)
and p.PersonID not in (select distinct i.SalespersonPersonID from Sales.Invoices i where i.InvoiceDate= '2015-07-04')

--- ������� 3
select distinct
  (SELECT p.PersonID
FROM [Application].People p
WHERE p.PersonID = i.SalespersonPersonID
) AS 'PersonID'
, (SELECT p.FullName
FROM [Application].People p
WHERE p.PersonID = i.SalespersonPersonID
) AS '��� ��������'
from Sales.Invoices i
where i.SalespersonPersonID not in (select distinct i.SalespersonPersonID from Sales.Invoices i where i.InvoiceDate= '2015-07-04')

--- ������� 4
WITH a as (
select distinct p.PersonID, p.FullName
from [Application].People p
inner join Sales.Invoices i on i.SalespersonPersonID=p.PersonID
)
select a.PersonID, a.FullName from a
where a.PersonID not in (select distinct i.SalespersonPersonID from Sales.Invoices i where i.InvoiceDate= '2015-07-04')

/*
2. �������� ������ � ����������� ����� (�����������). �������� ��� �������� ����������. 
�������: �� ������, ������������ ������, ����.
*/

--- ������� 1
select distinct o.StockItemID, o.Description, o.UnitPrice from Sales.OrderLines o
where o.UnitPrice = (select min(UnitPrice) from Sales.OrderLines)

--- ������� 2
with b as (
select distinct o.StockItemID, o.Description, o.UnitPrice 
,(select min(UnitPrice) from Sales.OrderLines) as unitmin
from Sales.OrderLines o
)
select b.StockItemID, b.Description, b.UnitPrice
from b
where b.UnitPrice=b.unitmin

/*
3. �������� ���������� �� ��������, ������� �������� �������� ���� ������������ �������� 
�� Sales.CustomerTransactions. 
����������� ��������� �������� (� ��� ����� � CTE). 
*/

--- ������� 1
select top (5) with ties CustomerID, CustomerTransactionID, TransactionAmount from Sales.CustomerTransactions
order by TransactionAmount desc
--- ������� 2
with b as (
select rn = ROW_NUMBER() over (order by TransactionAmount desc), CustomerID, CustomerTransactionID, TransactionAmount from Sales.CustomerTransactions
)
select CustomerID, CustomerTransactionID, TransactionAmount from b
where rn<=5

/*
4. �������� ������ (�� � ��������), � ������� ���� ���������� ������, 
�������� � ������ ����� ������� �������, � ����� ��� ����������, 
������� ����������� �������� ������� (PackedByPersonID).
*/
--- ������� 1

select distinct d.[DeliveryCityID], ac.CityName, c.[PackedByPersonID] 
from 
(select distinct top (3) with ties StockItemID, UnitPrice
from Sales.OrderLines
order by UnitPrice desc) as a
inner join Sales.OrderLines b on b.StockItemID=a.StockItemID
inner join Sales.Invoices   c on c.OrderID=b.OrderID
inner join Sales.Customers  d on d.CustomerID=c.CustomerID
inner join [Application].[Cities] ac on ac.CityID=d.DeliveryCityID

--- ������� 2
with a as
(select distinct top (3) with ties StockItemID, UnitPrice
from Sales.OrderLines
order by UnitPrice desc)
select distinct d.[DeliveryCityID], ac.CityName, c.[PackedByPersonID] 
from a
inner join Sales.OrderLines b on b.StockItemID=a.StockItemID
inner join Sales.Invoices   c on c.OrderID=b.OrderID
inner join Sales.Customers  d on d.CustomerID=c.CustomerID
inner join [Application].[Cities] ac on ac.CityID=d.DeliveryCityID

-- ---------------------------------------------------------------------------
-- ������������ �������
-- ---------------------------------------------------------------------------
-- ����� ��������� ��� � ������� ��������� ������������� �������, 
-- ��� � � ������� ��������� �����\���������. 
-- �������� ������������������ �������� ����� ����� SET STATISTICS IO, TIME ON. 
-- ���� ������� � ������� ��������, �� ����������� �� (����� � ������� ����� ��������� �����). 
-- �������� ���� ����������� �� ������ �����������. 

-- 5. ���������, ��� ������ � ������������� ������

--- ���������� �� ������ ���� ������� �� ������ Sales.Invoices � Sales.InvoiceLines
--- ��������� ���� � ����� ������ ����� 27000
--- ������������ ��� �������� �� ������� Application.People (�� ���� ��������� �������� ���������)
--- ����� ����� �� ��������� �������, �� ������� ��������� ������������ � ����� ��� � ���� (�� ���� ��������)
--- ���������� �� �������� �� ����� ����� 