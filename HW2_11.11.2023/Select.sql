/*
�������� ������� �� ����� MS SQL Server Developer � OTUS.
������� "02 - �������� SELECT � ������� �������, JOIN".

������� ����������� � �������������� ���� ������ WideWorldImporters.

����� �� WideWorldImporters ����� ������� ������:
https://github.com/Microsoft/sql-server-samples/releases/download/wide-world-importers-v1.0/WideWorldImporters-Full.bak

�������� WideWorldImporters �� Microsoft:
* https://docs.microsoft.com/ru-ru/sql/samples/wide-world-importers-what-is
* https://docs.microsoft.com/ru-ru/sql/samples/wide-world-importers-oltp-database-catalog
*/

-- ---------------------------------------------------------------------------
-- ������� - �������� ������� ��� ��������� ��������� ���� ������.
-- ---------------------------------------------------------------------------

USE WideWorldImporters

/*
1. ��� ������, � �������� ������� ���� "urgent" ��� �������� ���������� � "Animal".
�������: �� ������ (StockItemID), ������������ ������ (StockItemName).
�������: Warehouse.StockItems.
*/

select StockItemID, StockItemName
from Warehouse.StockItems
where StockItemName like '%urgent%' or StockItemName like 'Animal%'

/*
2. ����������� (Suppliers), � ������� �� ���� ������� �� ������ ������ (PurchaseOrders).
������� ����� JOIN, � ����������� ������� ������� �� �����.
�������: �� ���������� (SupplierID), ������������ ���������� (SupplierName).
�������: Purchasing.Suppliers, Purchasing.PurchaseOrders.
�� ����� �������� ������ JOIN ��������� ��������������.
*/

select distinct ps.SupplierID, ps.SupplierName
from Purchasing.Suppliers ps
left join Purchasing.PurchaseOrders pp on pp.SupplierID=ps.SupplierID
where pp.OrderDate is NULL


/*
3. ������ (Orders) � ����� ������ (UnitPrice) ����� 100$ 
���� ����������� ������ (Quantity) ������ ����� 20 ����
� �������������� ����� ������������ ����� ������ (PickingCompletedWhen).
�������:
* OrderID
* ���� ������ (OrderDate) � ������� ��.��.����
* �������� ������, � ������� ��� ������ �����
* ����� ��������, � ������� ��� ������ �����
* ����� ����, � ������� ��������� ���� ������ (������ ����� �� 4 ������)
* ��� ��������� (Customer)
�������� ������� ����� ������� � ������������ ��������,
��������� ������ 1000 � ��������� ��������� 100 �������.

���������� ������ ���� �� ������ ��������, ����� ����, ���� ������ (����� �� �����������).

�������: Sales.Orders, Sales.OrderLines, Sales.Customers.
*/

select o.OrderID
, convert(varchar,o.OrderDate,104) as 'OrderDate'
, datename(month, o.OrderDate) as 'month'
, datepart(quarter, o.OrderDate) as 'quarter'
, ROUND( (month(o.OrderDate)+3)/4,1 ) as 'third part'
, c.CustomerName
from Sales.Orders o
left join Sales.OrderLines ol on ol.OrderID=o.OrderID
left join Sales.Customers c on c.CustomerID=o.CustomerID
where (ol.UnitPrice>'100' or ol.Quantity>'20') and ol.PickingCompletedWhen is not NULL
order by datepart(quarter, o.OrderDate), ROUND( (month(o.OrderDate)+3)/4,1 ), o.OrderDate
OFFSET 1000 ROWS FETCH NEXT 100 ROWS ONLY

/*
4. ������ ����������� (Purchasing.Suppliers),
������� ������ ���� ��������� (ExpectedDeliveryDate) � ������ 2013 ����
� ��������� "Air Freight" ��� "Refrigerated Air Freight" (DeliveryMethodName)
� ������� ��������� (IsOrderFinalized).
�������:
* ������ �������� (DeliveryMethodName)
* ���� �������� (ExpectedDeliveryDate)
* ��� ����������
* ��� ����������� ���� ������������ ����� (ContactPerson)

�������: Purchasing.Suppliers, Purchasing.PurchaseOrders, Application.DeliveryMethods, Application.People.
*/

select dm.DeliveryMethodName
, pc.ExpectedDeliveryDate
, ps.SupplierName
, ap.FullName
from Purchasing.PurchaseOrders pc
left join Purchasing.Suppliers ps on ps.SupplierID=pc.SupplierID
left join [Application].DeliveryMethods dm on dm.DeliveryMethodID=ps.DeliveryMethodID
left join [Application].People ap on ap.PersonID=pc.ContactPersonID
where year(pc.ExpectedDeliveryDate)='2013' and month(pc.ExpectedDeliveryDate)='1'
and dm.DeliveryMethodName in ('Air Freight','Refrigerated Air Freight')
and pc.IsOrderFinalized='1'

/*
5. ������ ��������� ������ (�� ���� �������) � ������ ������� � ������ ����������,
������� ������� ����� (SalespersonPerson).
������� ��� �����������.
*/

select top 10  o.OrderDate, sc.CustomerName, ap.FullName
from Sales.Orders o
left join [Sales].[Customers] sc on sc.CustomerID=o.CustomerID
left join [Application].People ap on ap.PersonID=o.SalespersonPersonID
order by o.OrderDate desc


/*
6. ��� �� � ����� �������� � �� ���������� ��������,
������� �������� ����� "Chocolate frogs 250g".
��� ������ �������� � ������� Warehouse.StockItems.
*/

select distinct o.CustomerID, c.CustomerName, c.PhoneNumber 
from Sales.Orders o
left join [Sales].[OrderLines] os on os.OrderID=o.OrderID
left join Warehouse.StockItems st on st.StockItemID=os.StockItemID
left join [Sales].[Customers] c on c.CustomerID=o.CustomerID
where st.StockItemName='Chocolate frogs 250g'

