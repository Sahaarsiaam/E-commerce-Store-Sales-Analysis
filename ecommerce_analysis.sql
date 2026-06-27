create database Sale_Store;
select * 
from ordersoorders;
RENAME TABLE ordersoorders TO Orders; 
select * from orders;
select * from details;
-- data cleaning
-- Order table
-- checking duplicates
select *,row_number()over(partition by `Order ID`,`Order Date`,CustomerName,State,City)as r_n
from orders;
-- fixing date type 
select `Order Date`, str_to_date(`Order Date`,'%m/%d/%Y')
from orders ;
update orders
set `Order Date` =str_to_date(`Order Date`,'%m/%d/%Y');


ALTER TABLE orders 
MODIFY COLUMN `Order Date` DATE;

-- 
select distinct(CustomerName)
from orders ;
update orders 
set CustomerName=trim(CustomerName) ;
-- ----- ----- -------------
select distinct(State)
from orders;
update orders	
set State = trim(State);
--- 
select distinct(city)
from orders ;
update orders
set city =trim(city);
-- ------------------------------------
-- details Table 
select * from detadetailsils;
-- cheking category values
select distinct(Category)
from details ;
update details
set Category= trim(Category);
-- checking sub category values 
select distinct(`Sub-Category`)
from details ;
update details 
set `Sub-Category` = trim(`Sub-Category`);

-- checking PaymentMode values
select distinct(PaymentMode)
from details ;
update details 
set PaymentMode = trim(PaymentMode);
-- check quantity values if there is negatif values
select distinct(quantity)
from details ;
-- check amount and profit values 
select distinct(Amount)
from details;
select distinct(profit)
from details;



-- Analysing the data 

select category , sum(Profit) as total_profit
from details 
group by category
order by  total_profit DESC;
-- profit and amout by category
select Category,sum(Amount) as total_amount,sum(profit) as total_profit
from details
group by Category;
-- quantity by subcategory
select Category ,sum(Quantity) as qnt
from details
group by Category
order by qnt DESC ;
-- profit and amount by sub category
select `Sub-Category`,sum(Amount),sum(profit)
from details
group by `Sub-Category`;
-- quantity by sub category
select `Sub-Category` ,sum(Quantity) as qnt
from details
where Category ='Clothing'
group by `Sub-Category`
order by qnt desc;

select `Sub-Category` ,sum(Quantity) as qnt
from details
where Category ='Furniture'
group by `Sub-Category`
order by qnt desc;

select `Sub-Category` ,sum(Quantity) as qnt
from details
where Category ='Electronics'
group by `Sub-Category`
order by qnt desc;
select Category, (sum(profit)/sum(amount))* 100 as 'profit_margin(%)'
from details
group by Category;
-- quantity by payment mode
select PaymentMode,sum(quantity) as qnt
from details
group by (PaymentMode)
order by qnt DESC ;
-- monthly profit trends
SELECT 
    MONTH(O.`Order Date`) AS order_month,
    sum(Profit)
FROM details D
JOIN orders O
    ON D.Order_id = O.`Order ID`
GROUP BY MONTH(O.`Order Date`)
order by order_month;

-- top 10 Customer
select CustomerName,sum(Quantity) as qnt
from orders
join details
on orders.`Order ID` = details.Order_id
group by customerName 
order by qnt desc
limit 3;

-- city with  best profit 
select city ,sum(profit)
from orders
join details
on orders.`Order ID` = details.Order_id
group by city ;
-- profit for each state
select state ,sum(profit)
from orders
join details
on orders.`Order ID` = details.Order_id
group by state ;



