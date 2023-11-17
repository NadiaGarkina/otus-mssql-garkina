/*
Домашнее задание по курсу MS SQL Server Developer в OTUS.

Занятие "03 - Подзапросы, CTE, временные таблицы".

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
-- Для всех заданий, где возможно, сделайте два варианта запросов:
--  1) через вложенный запрос
--  2) через WITH (для производных таблиц)
-- ---------------------------------------------------------------------------

USE WideWorldImporters

/*
1. Выберите сотрудников (Application.People), которые являются продажниками (IsSalesPerson), 
и не сделали ни одной продажи 04 июля 2015 года. 
Вывести ИД сотрудника и его полное имя. 
Продажи смотреть в таблице Sales.Invoices.
*/

--- Вариант 1
select distinct p.PersonID, p.FullName
from [Application].People p
inner join Sales.Invoices i on i.SalespersonPersonID=p.PersonID
where i.SalespersonPersonID not in (select distinct i.SalespersonPersonID from Sales.Invoices i where i.InvoiceDate= '2015-07-04')

--- Вариант 2
select p.PersonID, p.FullName
from [Application].People p
WHERE p.PersonID in (select distinct i.SalespersonPersonID from Sales.Invoices i)
and p.PersonID not in (select distinct i.SalespersonPersonID from Sales.Invoices i where i.InvoiceDate= '2015-07-04')

--- Вариант 3
select distinct
  (SELECT p.PersonID
FROM [Application].People p
WHERE p.PersonID = i.SalespersonPersonID
) AS 'PersonID'
, (SELECT p.FullName
FROM [Application].People p
WHERE p.PersonID = i.SalespersonPersonID
) AS 'Имя продавца'
from Sales.Invoices i
where i.SalespersonPersonID not in (select distinct i.SalespersonPersonID from Sales.Invoices i where i.InvoiceDate= '2015-07-04')

--- Вариант 4
WITH a as (
select distinct p.PersonID, p.FullName
from [Application].People p
inner join Sales.Invoices i on i.SalespersonPersonID=p.PersonID
)
select a.PersonID, a.FullName from a
where a.PersonID not in (select distinct i.SalespersonPersonID from Sales.Invoices i where i.InvoiceDate= '2015-07-04')

/*
2. Выберите товары с минимальной ценой (подзапросом). Сделайте два варианта подзапроса. 
Вывести: ИД товара, наименование товара, цена.
*/

--- Вариант 1
select distinct o.StockItemID, o.Description, o.UnitPrice from Sales.OrderLines o
where o.UnitPrice = (select min(UnitPrice) from Sales.OrderLines)

--- Вариант 2
with b as (
select distinct o.StockItemID, o.Description, o.UnitPrice 
,(select min(UnitPrice) from Sales.OrderLines) as unitmin
from Sales.OrderLines o
)
select b.StockItemID, b.Description, b.UnitPrice
from b
where b.UnitPrice=b.unitmin

/*
3. Выберите информацию по клиентам, которые перевели компании пять максимальных платежей 
из Sales.CustomerTransactions. 
Представьте несколько способов (в том числе с CTE). 
*/

--- Вариант 1
select top (5) with ties CustomerID, CustomerTransactionID, TransactionAmount from Sales.CustomerTransactions
order by TransactionAmount desc
--- Вариант 2
with b as (
select rn = ROW_NUMBER() over (order by TransactionAmount desc), CustomerID, CustomerTransactionID, TransactionAmount from Sales.CustomerTransactions
)
select CustomerID, CustomerTransactionID, TransactionAmount from b
where rn<=5

/*
4. Выберите города (ид и название), в которые были доставлены товары, 
входящие в тройку самых дорогих товаров, а также имя сотрудника, 
который осуществлял упаковку заказов (PackedByPersonID).
*/
--- Вариант 1

select distinct d.[DeliveryCityID], ac.CityName, c.[PackedByPersonID] 
from 
(select distinct top (3) with ties StockItemID, UnitPrice
from Sales.OrderLines
order by UnitPrice desc) as a
inner join Sales.OrderLines b on b.StockItemID=a.StockItemID
inner join Sales.Invoices   c on c.OrderID=b.OrderID
inner join Sales.Customers  d on d.CustomerID=c.CustomerID
inner join [Application].[Cities] ac on ac.CityID=d.DeliveryCityID

--- Вариант 2
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
-- Опциональное задание
-- ---------------------------------------------------------------------------
-- Можно двигаться как в сторону улучшения читабельности запроса, 
-- так и в сторону упрощения плана\ускорения. 
-- Сравнить производительность запросов можно через SET STATISTICS IO, TIME ON. 
-- Если знакомы с планами запросов, то используйте их (тогда к решению также приложите планы). 
-- Напишите ваши рассуждения по поводу оптимизации. 

-- 5. Объясните, что делает и оптимизируйте запрос

--- Соединение по Номеру чека выборок из таблиц Sales.Invoices и Sales.InvoiceLines
--- Выводятся чеки с общей суммой свыше 27000
--- добавяляется имя продавца из таблицы Application.People (то есть сотрудник является продавцом)
--- общая сумма по избранным товарам, по которым завершена комплектация и заказ уже в чеке (то есть исполнен)
--- сортировка по убыванию по Общей сумме 