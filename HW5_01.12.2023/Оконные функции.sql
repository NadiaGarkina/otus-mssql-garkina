/*
Домашнее задание по курсу MS SQL Server Developer в OTUS.

Занятие "06 - Оконные функции".

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
1. Сделать расчет суммы продаж нарастающим итогом по месяцам с 2015 года 
(в рамках одного месяца он будет одинаковый, нарастать будет в течение времени выборки).
Выведите: id продажи, название клиента, дату продажи, сумму продажи, сумму нарастающим итогом

Пример:
-------------+----------------------------
Дата продажи | Нарастающий итог по месяцу
-------------+----------------------------
 2015-01-29   | 4801725.31
 2015-01-30	 | 4801725.31
 2015-01-31	 | 4801725.31
 2015-02-01	 | 9626342.98
 2015-02-02	 | 9626342.98
 2015-02-03	 | 9626342.98
Продажи можно взять из таблицы Invoices.
Нарастающий итог должен быть без оконной функции.
*/
SET STATISTICS IO ON;  
GO  
select si.[InvoiceID], c.[CustomerName], si.[InvoiceDate]
,		(select sum(o.Quantity*o.UnitPrice) 
		from Sales.InvoiceLines o
		where o.InvoiceID=si.InvoiceID) as 'Сумма продаж'
		,(select  sum(OL1.UnitPrice*OL1.PickedQuantity)			  
		from sales.OrderLines OL1
		inner join Sales.Invoices si1 on OL1.OrderID=si1.OrderID
		where DATETRUNC(month, si1.[InvoiceDate])<=DATETRUNC(month, si.[InvoiceDate]) 
		and si1.[InvoiceDate]>='2015-01-01') as  'Сумма продаж накопительно помесячно'
from [Sales].[Invoices] si
inner join Sales.Customers c on c.CustomerID = si.CustomerID
inner join sales.OrderLines OL on OL.OrderID=si.OrderID
where si.[InvoiceDate]>='2015-01-01'
order by [InvoiceID]
GO  
SET STATISTICS IO OFF;  
GO  
/*
2. Сделайте расчет суммы нарастающим итогом в предыдущем запросе с помощью оконной функции.
   Сравните производительность запросов 1 и 2 с помощью set statistics time, io on
*/
SET STATISTICS IO ON;  
GO  
select si.[InvoiceID], c.[CustomerName], si.[InvoiceDate]
, SUM(il.Quantity*il.UnitPrice) OVER (PARTITION BY si.InvoiceID) as 'Сумма продаж'
, SUM(il.Quantity*il.UnitPrice) OVER (order by DATETRUNC(month, si.[InvoiceDate])) as  'Сумма продаж накопительно помесячно'
from [Sales].[Invoices] si
inner join Sales.Customers c on c.CustomerID = si.CustomerID
inner join Sales.InvoiceLines il on il.InvoiceID=si.InvoiceID
where si.[InvoiceDate]>='2015-01-01' 
order by [InvoiceID]
GO  
SET STATISTICS IO OFF;  
GO  
/*
3. Вывести список 2х самых популярных продуктов (по количеству проданных) 
в каждом месяце за 2016 год (по 2 самых популярных продукта в каждом месяце).
*/

with a as	(
			select i.StockItemID, sum(i.Quantity) as 'Количество в месяц', DATETRUNC(month, si.[InvoiceDate]) as 'Месяц'
			from Sales.InvoiceLines i
			inner join [Sales].[Invoices] si on si.InvoiceID = i.InvoiceID 
			where si.InvoiceDate>='2016-01-01' and si.InvoiceDate<'2017-01-01'
			group by i.StockItemID, DATETRUNC(month, si.[InvoiceDate])
			)
,    b as   (select a.StockItemID, a.[Количество в месяц], a.[Месяц]
			, ROW_NUMBER() OVER(PARTITION BY a.Месяц ORDER BY a.[Количество в месяц] desc) as ROW_NUMBER
			from a)
select b.*
from b
where b.ROW_NUMBER<=2

/*
4. Функции одним запросом
Посчитайте по таблице товаров (в вывод также должен попасть ид товара, название, брэнд и цена):
* пронумеруйте записи по названию товара, так чтобы при изменении буквы алфавита нумерация начиналась заново
* посчитайте общее количество товаров и выведете полем в этом же запросе
* посчитайте общее количество товаров в зависимости от первой буквы названия товара
* отобразите следующий id товара исходя из того, что порядок отображения товаров по имени 
* предыдущий ид товара с тем же порядком отображения (по имени)
* названия товара 2 строки назад, в случае если предыдущей строки нет нужно вывести "No items"
* сформируйте 30 групп товаров по полю вес товара на 1 шт

Для этой задачи НЕ нужно писать аналог без аналитических функций.
*/

select st.StockItemID, st.StockItemName, st.Brand, st.UnitPrice
, ROW_NUMBER() OVER(PARTITION BY SUBSTRING(st.StockItemName, 1, 1) ORDER BY st.StockItemName)   as  ROW_NUMBER
, count(st.StockItemID) OVER()																	as 'Всего разных товаров'
, count(st.StockItemID) OVER(PARTITION BY SUBSTRING(st.StockItemName, 1, 1))					as 'Всего разных товаров в букве'
, LEAD(st.StockItemID) OVER(ORDER BY st.StockItemName)										    as 'Следующий по порядку'
, LAG(st.StockItemID) OVER(ORDER BY st.StockItemName)										    as 'Предыдущий по порядку'
, LAG(st.StockItemName, 2, 'No items') OVER(ORDER BY st.StockItemName)						    as 'Товар 2 строки назад'
, NTILE(30) OVER(ORDER BY st.TypicalWeightPerUnit)											    as 'Группа по весу'
from [Warehouse].[StockItems] st
group by st.StockItemID, st.StockItemName, st.Brand, st.UnitPrice, st.TypicalWeightPerUnit
order by st.StockItemName


/*
5. По каждому сотруднику выведите последнего клиента, которому сотрудник что-то продал.
   В результатах должны быть ид и фамилия сотрудника, ид и название клиента, дата продажи, сумму сделки.
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
6. Выберите по каждому клиенту два самых дорогих товара, которые он покупал.
В результатах должно быть ид клиента, его название, ид товара, цена, дата покупки.
*/

select distinct c.CustomerID, c.CustomerName, t.StockItemID, t.StockItemName, t.UnitPrice 
,(
	select max(i1.InvoiceDate)  
	from Sales.InvoiceLines as il1
	inner join Sales.Invoices as i1 on i1.InvoiceID=il1.InvoiceID
	where il1.StockItemID=t.StockItemID and i1.CustomerID=c.CustomerID
	) as 'IDate'
from
(
    select distinct i.CustomerID, sil.StockItemID, si.StockItemName, si.UnitPrice, i.InvoiceDate
    , DENSE_RANK() OVER(PARTITION BY i.CustomerID ORDER BY si.UnitPrice desc) as DENSE_RANK
    from Sales.InvoiceLines sil
    inner join Sales.Invoices i on i.InvoiceID = sil.InvoiceID
    inner join Warehouse.StockItems si on si.StockItemID = sil.StockItemID
) as t
inner join Sales.Customers c on t.CustomerID = c.CustomerID
where t.DENSE_RANK<=2


Опционально можете для каждого запроса без оконных функций сделать вариант запросов с оконными функциями и сравнить их производительность. 