/*
Домашнее задание по курсу MS SQL Server Developer в OTUS.
Занятие "02 - Оператор SELECT и простые фильтры, JOIN".

Задания выполняются с использованием базы данных WideWorldImporters.

Бэкап БД WideWorldImporters можно скачать отсюда:
https://github.com/Microsoft/sql-server-samples/releases/download/wide-world-importers-v1.0/WideWorldImporters-Full.bak

Описание WideWorldImporters от Microsoft:
* https://docs.microsoft.com/ru-ru/sql/samples/wide-world-importers-what-is
* https://docs.microsoft.com/ru-ru/sql/samples/wide-world-importers-oltp-database-catalog
*/

-- ---------------------------------------------------------------------------
-- Задание - написать выборки для получения указанных ниже данных.
-- ---------------------------------------------------------------------------

USE WideWorldImporters

/*
1. Все товары, в названии которых есть "urgent" или название начинается с "Animal".
Вывести: ИД товара (StockItemID), наименование товара (StockItemName).
Таблицы: Warehouse.StockItems.
*/

select StockItemID, StockItemName
from Warehouse.StockItems
where StockItemName like '%urgent%' or StockItemName like 'Animal%'

/*
2. Поставщиков (Suppliers), у которых не было сделано ни одного заказа (PurchaseOrders).
Сделать через JOIN, с подзапросом задание принято не будет.
Вывести: ИД поставщика (SupplierID), наименование поставщика (SupplierName).
Таблицы: Purchasing.Suppliers, Purchasing.PurchaseOrders.
По каким колонкам делать JOIN подумайте самостоятельно.
*/

select distinct ps.SupplierID, ps.SupplierName
from Purchasing.Suppliers ps
left join Purchasing.PurchaseOrders pp on pp.SupplierID=ps.SupplierID
where pp.OrderDate is NULL


/*
3. Заказы (Orders) с ценой товара (UnitPrice) более 100$ 
либо количеством единиц (Quantity) товара более 20 штук
и присутствующей датой комплектации всего заказа (PickingCompletedWhen).
Вывести:
* OrderID
* дату заказа (OrderDate) в формате ДД.ММ.ГГГГ
* название месяца, в котором был сделан заказ
* номер квартала, в котором был сделан заказ
* треть года, к которой относится дата заказа (каждая треть по 4 месяца)
* имя заказчика (Customer)
Добавьте вариант этого запроса с постраничной выборкой,
пропустив первую 1000 и отобразив следующие 100 записей.

Сортировка должна быть по номеру квартала, трети года, дате заказа (везде по возрастанию).

Таблицы: Sales.Orders, Sales.OrderLines, Sales.Customers.
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
4. Заказы поставщикам (Purchasing.Suppliers),
которые должны быть исполнены (ExpectedDeliveryDate) в январе 2013 года
с доставкой "Air Freight" или "Refrigerated Air Freight" (DeliveryMethodName)
и которые исполнены (IsOrderFinalized).
Вывести:
* способ доставки (DeliveryMethodName)
* дата доставки (ExpectedDeliveryDate)
* имя поставщика
* имя контактного лица принимавшего заказ (ContactPerson)

Таблицы: Purchasing.Suppliers, Purchasing.PurchaseOrders, Application.DeliveryMethods, Application.People.
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
5. Десять последних продаж (по дате продажи) с именем клиента и именем сотрудника,
который оформил заказ (SalespersonPerson).
Сделать без подзапросов.
*/

select top 10  o.OrderDate, sc.CustomerName, ap.FullName
from Sales.Orders o
left join [Sales].[Customers] sc on sc.CustomerID=o.CustomerID
left join [Application].People ap on ap.PersonID=o.SalespersonPersonID
order by o.OrderDate desc


/*
6. Все ид и имена клиентов и их контактные телефоны,
которые покупали товар "Chocolate frogs 250g".
Имя товара смотреть в таблице Warehouse.StockItems.
*/

select distinct o.CustomerID, c.CustomerName, c.PhoneNumber 
from Sales.Orders o
left join [Sales].[OrderLines] os on os.OrderID=o.OrderID
left join Warehouse.StockItems st on st.StockItemID=os.StockItemID
left join [Sales].[Customers] c on c.CustomerID=o.CustomerID
where st.StockItemName='Chocolate frogs 250g'

