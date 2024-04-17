/*
--- Используем такую конструкцию для удаления базы при необходимости
USE master; 
GO 
IF DB_ID (N'Bank_Credits_new') IS NOT NULL 
	DROP DATABASE Bank_Credits_new; 
GO */

--- Создаем базу данных с банковскими кредитами
CREATE DATABASE Bank_Credits_new;
GO

use Bank_Credits_new;
GO

--- Создаем таблицу с кредитами
-- в банке выдаются кредиты клиентам
-- то есть у кредита один клиент
-- но у клиента много кредитов
CREATE TABLE [Credits] (
    [Loan_ID] int  NOT NULL identity,
    [Date] date  NOT NULL ,
    [Client_ID] int  NOT NULL ,
    [Issue_Date] date  NOT NULL ,
    [Closing_Date] date  NOT NULL ,
    [Rate] money  NOT NULL ,
    [Account] nvarchar(200)  NOT NULL ,
    [Main_debt] money  NOT NULL ,
    [Product_ID] int  NOT NULL ,
    CONSTRAINT [PK_Credits] PRIMARY KEY CLUSTERED (
        [Loan_ID] ASC
    )
)

--- Создаем таблицу с клиентами
-- у клиента может быть несколько кредитов
CREATE TABLE [Clients] (
    [Client_ID] int  NOT NULL  identity,
    [Client_Name] nvarchar(200)  NOT NULL ,
    [Date_of_birth] date  NOT NULL ,
    [Address] nvarchar(200)  NOT NULL ,
    CONSTRAINT [PK_Clients] PRIMARY KEY CLUSTERED (
        [Client_ID] ASC
    )
)

--- Создаем таблицу с клиентами-банкротами
-- некоторые клиенты могут быть банкротами
CREATE TABLE [Clients_bankrupt] (
    [Client_ID] int  NOT NULL ,
    [Date_of_bankrupt] date  NOT NULL ,
    CONSTRAINT [PK_Clients_bankrupt] PRIMARY KEY CLUSTERED (
        [Client_ID] ASC
    )
)

--- Создаем таблицу с продуктами
-- у кредита может быть один продукт
-- но в продукте много кредитов
CREATE TABLE [Products] (
    [Product_ID] int  NOT NULL identity ,
    [Product] nvarchar(200)  NOT NULL ,
    [Segment] nvarchar(200)  NOT NULL ,
    CONSTRAINT [PK_Products] PRIMARY KEY CLUSTERED (
        [Product_ID] ASC
    ),
    CONSTRAINT [UK_Products_Product] UNIQUE (
        [Product]
    )
)

--- Создаем таблицу с платежами
-- у кредита может быть много платежей по кредитам
CREATE TABLE [Payments] (
    [Fakt_ID] int  NOT NULL identity ,
    [Loan_ID] int  NOT NULL ,
    [Oper_kod] int  NOT NULL ,
    [Oper_name] nvarchar(200)  NOT NULL ,
    [Oper_date] date  NOT NULL ,
    [Oper_sum] money  NOT NULL ,
    CONSTRAINT [PK_Payments] PRIMARY KEY CLUSTERED (
        [Fakt_ID] ASC
    )
)

--- Создаем таблицу с просроченной задолженностью
-- у кредита могут быть просроченные задолженности
CREATE TABLE [Credits_delay] (
    [Loan_ID] int  NOT NULL ,
    [Date_begin] date  NOT NULL ,
    [Date_end] date  NOT NULL ,
	CONSTRAINT [PK_Credits_delay] PRIMARY KEY ([Loan_ID],[Date_begin],[Date_end])
)

--- Создаем таблицу с реструктуризациями по кредитам
-- у кредита может быть несколько реструктуризаций или не быть
CREATE TABLE [Credits_restructs] (
    [Loan_ID] int  NOT NULL ,
    [Date_rest] date  NOT NULL ,
    [Rest_type] nvarchar(200)  NOT NULL ,
	CONSTRAINT [PK_Credits_restructs] PRIMARY KEY ([Loan_ID],[Date_rest],[Rest_type])
)

--- Добавляем ограничения по таблицам
ALTER TABLE [Credits] WITH CHECK ADD CONSTRAINT [FK_Credits_Client_ID] FOREIGN KEY([Client_ID])
REFERENCES [Clients] ([Client_ID])

ALTER TABLE [Credits] CHECK CONSTRAINT [FK_Credits_Client_ID]

ALTER TABLE [Credits] WITH CHECK ADD CONSTRAINT [FK_Credits_Product_ID] FOREIGN KEY([Product_ID])
REFERENCES [Products] ([Product_ID])

ALTER TABLE [Credits] CHECK CONSTRAINT [FK_Credits_Product_ID]

ALTER TABLE [Clients_bankrupt] WITH CHECK ADD CONSTRAINT [FK_Clients_bankrupt_Client_ID] FOREIGN KEY([Client_ID])
REFERENCES [Clients] ([Client_ID])

ALTER TABLE [Clients_bankrupt] CHECK CONSTRAINT [FK_Clients_bankrupt_Client_ID]

ALTER TABLE [Payments] WITH CHECK ADD CONSTRAINT [FK_Payments_Loan_ID] FOREIGN KEY([Loan_ID])
REFERENCES [Credits] ([Loan_ID])

ALTER TABLE [Payments] CHECK CONSTRAINT [FK_Payments_Loan_ID]

ALTER TABLE [Credits_delay] WITH CHECK ADD CONSTRAINT [FK_Credits_delay_Loan_ID] FOREIGN KEY([Loan_ID])
REFERENCES [Credits] ([Loan_ID])

ALTER TABLE [Credits_delay] CHECK CONSTRAINT [FK_Credits_delay_Loan_ID]

ALTER TABLE [Credits_restructs] WITH CHECK ADD CONSTRAINT [FK_Credits_restructs_Loan_ID] FOREIGN KEY([Loan_ID])
REFERENCES [Credits] ([Loan_ID])

ALTER TABLE [Credits_restructs] CHECK CONSTRAINT [FK_Credits_restructs_Loan_ID]

ALTER TABLE [Credits] 
ADD CONSTRAINT constr_Issue_Date
CHECK ([Issue_Date] >='2012-01-01');

--- Создаем индексы
create index idx_prod on [Credits]  ([Product_ID]);

/*
create COLUMNSTORE index idx_pay on [Payments] ([Oper_date]);
create COLUMNSTORE index idx_delay on [Credits_delay] ([Loan_ID]);
create index idx_rest on [Credits_restructs] ([Date_rest],[Loan_ID]);

drop index  idx_pay on [Payments] ;
drop index  idx_delay on [Credits_delay] ;
drop index  idx_rest on [Credits_restructs]  ;
*/