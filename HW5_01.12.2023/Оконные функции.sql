/*
�������� ������� �� ����� MS SQL Server Developer � OTUS.

������� "06 - ������� �������".

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
-- ---------------------------------------------------------------------------

USE WideWorldImporters
/*
1. ������� ������ ����� ������ ����������� ������ �� ������� � 2015 ���� 
(� ������ ������ ������ �� ����� ����������, ��������� ����� � ������� ������� �������).
��������: id �������, �������� �������, ���� �������, ����� �������, ����� ����������� ������

������:
-------------+----------------------------
���� ������� | ����������� ���� �� ������
-------------+----------------------------
 2015-01-29   | 4801725.31
 2015-01-30	 | 4801725.31
 2015-01-31	 | 4801725.31
 2015-02-01	 | 9626342.98
 2015-02-02	 | 9626342.98
 2015-02-03	 | 9626342.98
������� ����� ����� �� ������� Invoices.
����������� ���� ������ ���� ��� ������� �������.
*/
SET STATISTICS IO ON;  
GO  
select [InvoiceID], [ConfirmedReceivedBy], [InvoiceDate], OL.UnitPrice*OL.PickedQuantity as '����� ������'
		,(select  sum(OL1.UnitPrice*OL1.PickedQuantity)			  
		from [Sales].[Invoices] si1
		inner join sales.OrderLines OL1 on OL1.OrderID=si1.OrderID
		where DATETRUNC(month, si1.[InvoiceDate])<=DATETRUNC(month, si.[InvoiceDate]) 
		and si1.[InvoiceDate]>='2015-01-01') as  '����� ������ ������������ ���������'
from [Sales].[Invoices] si
inner join sales.OrderLines OL on OL.OrderID=si.OrderID
where si.[InvoiceDate]>='2015-01-01' 
order by [InvoiceID]
GO  
SET STATISTICS IO OFF;  
GO  
/*
2. �������� ������ ����� ����������� ������ � ���������� ������� � ������� ������� �������.
   �������� ������������������ �������� 1 � 2 � ������� set statistics time, io on
*/

SET STATISTICS IO ON;  
GO  
select [InvoiceID], [ConfirmedReceivedBy], [InvoiceDate], OL.UnitPrice*OL.PickedQuantity as '����� ������'
,sum(OL.UnitPrice*OL.PickedQuantity) over(order by DATETRUNC(month, si.[InvoiceDate]))   as  '����� ������ ������������ ���������'
from [Sales].[Invoices] si
inner join sales.OrderLines OL on OL.OrderID=si.OrderID
where si.[InvoiceDate]>='2015-01-01' 
order by [InvoiceID] 
GO  
SET STATISTICS IO OFF;  
GO  
/*
3. ������� ������ 2� ����� ���������� ��������� (�� ���������� ���������) 
� ������ ������ �� 2016 ��� (�� 2 ����� ���������� �������� � ������ ������).
*/

with a as	(
			select i.StockItemID, sum(i.Quantity) as '���������� � �����', DATETRUNC(month, si.[InvoiceDate]) as '�����'
			from Sales.InvoiceLines i
			inner join [Sales].[Invoices] si on si.InvoiceID = i.InvoiceID 
			where si.InvoiceDate>='2016-01-01' and si.InvoiceDate<'2017-01-01'
			group by i.StockItemID, DATETRUNC(month, si.[InvoiceDate])
			)
,    b as   (select a.StockItemID, a.[���������� � �����], a.[�����]
			, ROW_NUMBER() OVER(PARTITION BY a.����� ORDER BY a.[���������� � �����] desc) as ROW_NUMBER
			from a)
select b.*
from b
where b.ROW_NUMBER<=2

/*
4. ������� ����� ��������
���������� �� ������� ������� (� ����� ����� ������ ������� �� ������, ��������, ����� � ����):
* ������������ ������ �� �������� ������, ��� ����� ��� ��������� ����� �������� ��������� ���������� ������
* ���������� ����� ���������� ������� � �������� ����� � ���� �� �������
* ���������� ����� ���������� ������� � ����������� �� ������ ����� �������� ������
* ���������� ��������� id ������ ������ �� ����, ��� ������� ����������� ������� �� ����� 
* ���������� �� ������ � ��� �� �������� ����������� (�� �����)
* �������� ������ 2 ������ �����, � ������ ���� ���������� ������ ��� ����� ������� "No items"
* ����������� 30 ����� ������� �� ���� ��� ������ �� 1 ��

��� ���� ������ �� ����� ������ ������ ��� ������������� �������.
*/

select st.StockItemID, st.StockItemName, st.Brand, st.UnitPrice
, ROW_NUMBER() OVER(PARTITION BY SUBSTRING(st.StockItemName, 1, 1) ORDER BY st.StockItemName)   as  ROW_NUMBER
, count(st.StockItemID) OVER()																	as '����� ������ �������'
, count(st.StockItemID) OVER(PARTITION BY SUBSTRING(st.StockItemName, 1, 1))					as '����� ������ ������� � �����'
, LEAD(st.StockItemID) OVER(ORDER BY st.StockItemName)										    as '��������� �� �������'
, LAG(st.StockItemID) OVER(ORDER BY st.StockItemName)										    as '���������� �� �������'
, LAG(st.StockItemName, 2, 'No items') OVER(ORDER BY st.StockItemName)						    as '����� 2 ������ �����'
, NTILE(30) OVER(ORDER BY st.TypicalWeightPerUnit)											    as '������ �� ����'
from [Warehouse].[StockItems] st
group by st.StockItemID, st.StockItemName, st.Brand, st.UnitPrice, st.TypicalWeightPerUnit
order by st.StockItemName


/*
5. �� ������� ���������� �������� ���������� �������, �������� ��������� ���-�� ������.
   � ����������� ������ ���� �� � ������� ����������, �� � �������� �������, ���� �������, ����� ������.
*/

select p.PersonID, p.FullName, sc.CustomerID, sc.CustomerName, t.TransactionDate, t.TransactionAmount
from
		(select c.CustomerID, si.SalespersonPersonID, c.TransactionDate, c.TransactionAmount, 
		 ROW_NUMBER() OVER(PARTITION BY si.SalespersonPersonID ORDER BY TransactionDate DESC) as ROW_NUMBER
		 from Sales.CustomerTransactions c
		 inner join Sales.Invoices si on c.InvoiceID=si.InvoiceID
		) t
inner join [Application].People p on t.SalespersonPersonID=p.PersonID
inner join Sales.Customers sc on t.CustomerID=sc.CustomerID
where ROW_NUMBER = 1

/*
6. �������� �� ������� ������� ��� ����� ������� ������, ������� �� �������.
� ����������� ������ ���� �� �������, ��� ��������, �� ������, ����, ���� �������.
*/

select c.CustomerID, c.CustomerName, t.StockItemID, t.StockItemName, t.UnitPrice, t.InvoiceDate
from
(
    select i.CustomerID, sil.StockItemID, si.StockItemName, si.UnitPrice,  i.InvoiceDate, 
    ROW_NUMBER() OVER(PARTITION BY i.CustomerID ORDER BY si.UnitPrice desc) as ROW_NUMBER
    from Sales.InvoiceLines sil
    inner join Sales.Invoices i on i.InvoiceID = sil.InvoiceID
    inner join Warehouse.StockItems si on si.StockItemID = sil.StockItemID
) as t
inner join Sales.Customers c on t.CustomerID = c.CustomerID
where t.ROW_NUMBER<=2


����������� ������ ��� ������� ������� ��� ������� ������� ������� ������� �������� � �������� ��������� � �������� �� ������������������. 