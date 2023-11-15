/*
�������� ������� �� ����� MS SQL Server Developer � OTUS.
������� "02 - �������� SELECT � ������� �������, GROUP BY, HAVING".

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
1. ��������� ������� ���� ������, ����� ����� ������� �� �������.
�������:
* ��� ������� (��������, 2015)
* ����� ������� (��������, 4)
* ������� ���� �� ����� �� ���� �������
* ����� ����� ������ �� �����

������� �������� � ������� Sales.Invoices � ��������� ��������.
*/

select 
  YEAR(si.InvoiceDate)				 as '���'
, MONTH(si.InvoiceDate)				 as '�����'
, AVG(i.UnitPrice)					 as '������� ����'
, SUM(i.UnitPrice*i.Quantity)		 as '����� �����'
from Sales.Invoices si
inner join [Sales].[InvoiceLines] i on i.InvoiceID=si.InvoiceID
group by YEAR(si.InvoiceDate), MONTH(si.InvoiceDate)
order by YEAR(si.InvoiceDate), MONTH(si.InvoiceDate)

/*
2. ���������� ��� ������, ��� ����� ����� ������ ��������� 4 600 000

�������:
* ��� ������� (��������, 2015)
* ����� ������� (��������, 4)
* ����� ����� ������

������� �������� � ������� Sales.Invoices � ��������� ��������.
*/

select 
  YEAR(si.InvoiceDate)				as '���'
, MONTH(si.InvoiceDate)				as '�����'
, SUM(i.UnitPrice*i.Quantity)		as '����� �����'
from Sales.Invoices si
inner join [Sales].[InvoiceLines] i on i.InvoiceID=si.InvoiceID
group by YEAR(si.InvoiceDate), MONTH(si.InvoiceDate)
having SUM(i.UnitPrice*i.Quantity)>'4600000'

/*
3. ������� ����� ������, ���� ������ �������
� ���������� ���������� �� �������, �� �������,
������� ������� ����� 50 �� � �����.
����������� ������ ���� �� ����,  ������, ������.

�������:
* ��� �������
* ����� �������
* ������������ ������
* ����� ������
* ���� ������ �������
* ���������� ����������

������� �������� � ������� Sales.Invoices � ��������� ��������.
*/

select 
  YEAR(si.InvoiceDate)				as '��� �������'
, MONTH(si.InvoiceDate)				as '����� �������'
, i.Description					    as '������������ ������'
, SUM(i.UnitPrice*i.Quantity)		as '����� ������'
, min(si.InvoiceDate)				as '���� ������ �������'
, sum(i.Quantity)					as '���������� ����������'
from [Sales].[InvoiceLines] i
inner join Sales.Invoices si on i.InvoiceID=si.InvoiceID
group by YEAR(si.InvoiceDate), MONTH(si.InvoiceDate), i.Description
having sum(i.Quantity)<'50'

-- ---------------------------------------------------------------------------
-- �����������
-- ---------------------------------------------------------------------------
/*
�������� ������� 2-3 ���, ����� ���� � �����-�� ������ �� ���� ������,
�� ���� ����� ����� ����������� �� � �����������, �� ��� ���� ����.
*/
