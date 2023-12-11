/*
ќписание/ѕошагова€ инструкци€ выполнени€ домашнего задани€:
ƒовставл€ть в базу п€ть записей использу€ insert в таблицу Customers или Suppliers
”далите одну запись из Customers, котора€ была вами добавлена
»зменить одну запись, из добавленных через UPDATE
Ќаписать MERGE, который вставит вставит запись в клиенты, если ее там нет, и изменит если она уже есть
Ќапишите запрос, который выгрузит данные через bcp out и загрузить через bulk insert */

/*
drop table if exists Sales.Customers_Copy
select * into Sales.Customers_Copy
from Sales.Customers
where 1 = 2
select * from Sales.Customers_Copy

select * into Sales.Customers_Copy_1
from Sales.Customers_Copy */

--- ƒобавл€ем значени€ в таблицу
insert into Sales.Customers_Copy
(CustomerID,CustomerName,BillToCustomerID,CustomerCategoryID
--,BuyingGroupID
,PrimaryContactPersonID
--,AlternateContactPersonID
,DeliveryMethodID,DeliveryCityID
,PostalCityID,CreditLimit,AccountOpenedDate,StandardDiscountPercentage,IsStatementSent
,IsOnCreditHold,PaymentDays,PhoneNumber,FaxNumber
--,DeliveryRun,RunPosition
,WebsiteURL,DeliveryAddressLine1,DeliveryAddressLine2,DeliveryPostalCode
--,DeliveryLocation
,PostalAddressLine1,PostalAddressLine2,PostalPostalCode
,LastEditedBy,ValidFrom,ValidTo)
	VALUES
		(NEXT VALUE FOR Sequences.CustomerID
        ,'Jose K',1060,7,3238,3,28918,28918,3200,'2023-01-01',0,0,0,7,'(217) 666-0100','(217) 999-0100','http://www.tailspintoys.com','Shop 38','705 Dita Lane','90216','PO Box 259','Jogiville','90216',1,'2013-01-01','9999-01-01'), 
		(NEXT VALUE FOR Sequences.CustomerID
        ,'Am Not',1060,7,3238,3,28918,28918,3200,'2023-01-01',0,0,0,7,'(217) 777-0100','(217) 666-0100','http://www.tailspintoys.com','Shop 38','705 Dita Lane','90216','PO Box 259','Jogiville','90216',1,'2013-01-01','9999-01-01'),
		(NEXT VALUE FOR Sequences.CustomerID
        ,'Gyre Kop',1060,7,3238,3,28918,28918,3200,'2023-01-01',0,0,0,7,'(217) 888-0100','(217) 777-0100','http://www.tailspintoys.com','Shop 38','705 Dita Lane','90216','PO Box 259','Jogiville','90216',1,'2013-01-01','9999-01-01'),
		(NEXT VALUE FOR Sequences.CustomerID
        ,'Teo li',1060,7,3238,3,28918,28918,3200,'2023-01-01',0,0,0,7,'(217) 999-0100','(217) 111-0100','http://www.tailspintoys.com','Shop 38','705 Dita Lane','90216','PO Box 259','Jogiville','90216',1,'2013-01-01','9999-01-01'),
		(NEXT VALUE FOR Sequences.CustomerID
        ,'Gary Ty',1060,7,3238,3,28918,28918,3200,'2023-01-01',0,0,0,7,'(217) 111-0100','(217) 222-0100','http://www.tailspintoys.com','Shop 38','705 Dita Lane','90216','PO Box 259','Jogiville','90216',1,'2013-01-01','9999-01-01')
SELECT @@ROWCOUNT

--select * from Sales.Customers_Copy order by CustomerID desc

--- ”дал€ем одно значение из таблицы
delete from Sales.Customers_Copy
where CustomerID=1094

--- »змен€ем одно значение в таблице
UPDATE Sales.Customers_Copy
SET CreditLimit = 
    (SELECT max (CreditLimit) FROM Sales.Customers_Copy)
WHERE CustomerID=1093

--- Merge (который вставит вставит запись в клиенты, если ее там нет, и изменит если она уже есть)
--select * from Sales.Customers_Copy order by CustomerID desc
delete from Sales.Customers_Copy where CustomerID=1090
UPDATE Sales.Customers_Copy set CustomerName='Anand Mudaliyar' where CustomerID=1093

MERGE Sales.Customers_Copy AS Target
USING Sales.Customers_Copy_1 AS Source
    ON (Target.CustomerName = Source.CustomerName)
WHEN MATCHED 
    THEN UPDATE 
        SET [CustomerName] = Source.[CustomerName]
WHEN NOT MATCHED 
    THEN INSERT 
        VALUES (CustomerID, CustomerName, BillToCustomerID, CustomerCategoryID, BuyingGroupID, PrimaryContactPersonID, AlternateContactPersonID, DeliveryMethodID, DeliveryCityID, PostalCityID, CreditLimit, AccountOpenedDate, StandardDiscountPercentage, IsStatementSent, IsOnCreditHold, PaymentDays, PhoneNumber, FaxNumber, DeliveryRun, RunPosition, WebsiteURL, DeliveryAddressLine1, DeliveryAddressLine2, DeliveryPostalCode, DeliveryLocation, PostalAddressLine1, PostalAddressLine2, PostalPostalCode, LastEditedBy, ValidFrom, ValidTo)
when NOT MATCHED by SOURCE
then delete
OUTPUT deleted.*, $action, inserted.*;


---cmd---
--1. CREATE Folder BCP
--2. bcp WideWorldImporters.Warehouse.Colors out E:\BCP\WideWorldImporters.Warehouse.Colors_Copy.txt -c -T

CREATE Folder BCP
bcp [wideworldimporters].[sales].[customers] out [C:\Users\User\Desktop\otus-mssql-garkina\HW8_11_12_2023] -c -T