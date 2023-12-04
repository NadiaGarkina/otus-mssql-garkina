/*
Домашнее задание по курсу MS SQL Server Developer в OTUS.

Занятие "05 - Операторы CROSS APPLY, PIVOT, UNPIVOT".

Задания выполняются с использованием базы данных WideWorldImporters.

Бэкап БД можно скачать отсюда:
https://github.com/Microsoft/sql-server-samples/releases/tag/wide-world-importers-v1.0
Нужен WideWorldImporters-Full.bak

Описание WideWorldImporters от Microsoft:
* https://docs.microsoft.com/ru-ru/sql/samples/wide-world-importers-what-is
* https://docs.microsoft.com/ru-ru/sql/samples/wide-world-importers-oltp-database-catalog
*/

-- ---------------------------------------------------------------------------
-- Задание - написать выборки для получения указанных ниже данных.
-- ---------------------------------------------------------------------------

USE WideWorldImporters

/*
1. Требуется написать запрос, который в результате своего выполнения 
формирует сводку по количеству покупок в разрезе клиентов и месяцев.
В строках должны быть месяцы (дата начала месяца), в столбцах - клиенты.

Клиентов взять с ID 2-6, это все подразделение Tailspin Toys.
Имя клиента нужно поменять так чтобы осталось только уточнение.
Например, исходное значение "Tailspin Toys (Gasport, NY)" - вы выводите только "Gasport, NY".
Дата должна иметь формат dd.mm.yyyy, например, 25.12.2019.

Пример, как должны выглядеть результаты:
-------------+--------------------+--------------------+-------------+--------------+------------
InvoiceMonth | Peeples Valley, AZ | Medicine Lodge, KS | Gasport, NY | Sylvanite, MT | Jessie, ND
-------------+--------------------+--------------------+-------------+--------------+------------
01.01.2013   |      3             |        1           |      4      |      2        |     2
01.02.2013   |      7             |        3           |      4      |      2        |     1
-------------+--------------------+--------------------+-------------+--------------+------------
*/

select * from 
(select substring(c.CustomerName, charindex('(',c.CustomerName)+1,
		charindex(')',c.CustomerName)-charindex('(',c.CustomerName)-1) as 'сокращение'
, DATETRUNC(month, o.OrderDate) as 'месяц_заказа', o.OrderID
from Sales.Customers c
inner join Sales.Orders o on o.CustomerID=c.CustomerID
where c.CustomerName like '%(%'
) as a
PIVOT (count(a.OrderID)
FOR a.сокращение in   (
						 [Sylvanite, MT]
						,[Peeples Valley, AZ]
						,[Medicine Lodge, KS]
						,[Gasport, NY]
						,[Jessie, ND]) )
as PVT_my
order by [месяц_заказа]

/*
2. Для всех клиентов с именем, в котором есть "Tailspin Toys"
вывести все адреса, которые есть в таблице, в одной колонке.

Пример результата:
----------------------------+--------------------
CustomerName                | AddressLine
----------------------------+--------------------
Tailspin Toys (Head Office) | Shop 38
Tailspin Toys (Head Office) | 1877 Mittal Road
Tailspin Toys (Head Office) | PO Box 8975
Tailspin Toys (Head Office) | Ribeiroville
----------------------------+--------------------
*/
select * from 
(
select distinct c.CustomerName, c.DeliveryAddressLine1, c.DeliveryAddressLine2, c.PostalAddressLine1, c.PostalAddressLine2
from Sales.Customers c
inner join Sales.Orders o on o.CustomerID=c.CustomerID
where c.CustomerName like '%Tailspin Toys%'
) as t
UNPIVOT (Address for AddressType in (DeliveryAddressLine1, DeliveryAddressLine2, PostalAddressLine1, PostalAddressLine2)) as unpt

/*
3. В таблице стран (Application.Countries) есть поля с цифровым кодом страны и с буквенным.
Сделайте выборку ИД страны, названия и ее кода так, 
чтобы в поле с кодом был либо цифровой либо буквенный код.

Пример результата:
--------------------------------
CountryId | CountryName | Code
----------+-------------+-------
1         | Afghanistan | AFG
1         | Afghanistan | 4
3         | Albania     | ALB
3         | Albania     | 8
----------+-------------+-------
*/

select CountryID,CountryName,Code from 
(
select c.CountryID, c.CountryName, cast(c.IsoAlpha3Code as varchar(10)) as 'IsoAlpha3Code', cast(c.IsoNumericCode as varchar(10)) as IsoNumericCode
from [Application].Countries c
) as t
UNPIVOT (Code for CodeType in (IsoAlpha3Code, IsoNumericCode)) as unpt

/*
4. Выберите по каждому клиенту два самых дорогих товара, которые он покупал.
В результатах должно быть ид клиента, его название, ид товара, цена, дата покупки.
*/

select c.CustomerID, c.CustomerName, t.StockItemID, t.StockItemName, t.UnitPrice
,	(
	select max(i1.InvoiceDate)  
	from Sales.InvoiceLines as il1
	inner join Sales.Invoices as i1 on i1.InvoiceID=il1.InvoiceID
	where il1.StockItemID=t.StockItemID and i1.CustomerID=c.CustomerID
	) as 'IDate'
from Sales.Customers c
CROSS APPLY
(
    select distinct top 2 sil.StockItemID, si.StockItemName, si.UnitPrice  
    from Sales.InvoiceLines sil
    inner join Sales.Invoices i on i.InvoiceID = sil.InvoiceID
    inner join Warehouse.StockItems si on si.StockItemID = sil.StockItemID
	where i.CustomerID=c.CustomerID
	--and i.CustomerID=832
	order by si.UnitPrice desc
) as t
