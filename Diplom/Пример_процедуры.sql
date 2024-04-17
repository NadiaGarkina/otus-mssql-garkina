--- Пример простой процедуры для анализа выданных кредитов по дате и продукту
create procedure dbo.credits_proc @date date
as begin
select
  p.Segment
, p.Product
, c.Date
, count(c.Loan_ID) as 'credit_kol'
, sum(c.Main_debt) as 'credit_sum' 
from [Credits] c
inner join [Products] p ON p.Product_ID = c.Product_ID
where c.Date=@date
group by p.Segment, p.Product, c.Date
end

exec dbo.credits_proc '2023-10-22'