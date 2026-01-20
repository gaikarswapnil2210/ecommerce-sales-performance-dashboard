select count(*) from ecommerce_transactions;

--total sales--
select sum(sales_amount) as total_sales from ecommerce_transactions;

--total number of transactions--
select count(*) as total_transactions from ecommerce_transactions;

--average order value--
select sum(sales_amount) /count(distinct transaction_id) as avg_order_value from ecommerce_transactions;

--Sales by Country--
select country,sum(sales_amount) as total_sales 
from ecommerce_transactions
group by country
order by total_sales desc;

--Sales by Product Category--
select product_category,sum(sales_amount) as total_sales
from ecommerce_transactions
group by product_category
order by total_sales desc;

--Monthly Sales Trend--
SELECT YEAR(transaction_date) as year,
month (transaction_date)as month,
sum(sales_amount)as monthly_sales
from ecommerce_transactions
group by YEAR(transaction_date),MONTH(transaction_date)
order by year,month;

--Top 10 Customers by Sales--
select top 10 customer_name,
sum(sales_amount) as total_sales
from ecommerce_transactions
group by customer_name
order by total_sales desc;

--Sales by Payment Method--

select payment_method,
sum(sales_amount) as total_sales
from ecommerce_transactions
group by payment_method
order by total_sales desc;

--Age Group Analysis--

select 
case when age between 15 and 25 then '15-25'
when age between 26 and 35 then '26-35'
when age between 36 and 45 then '36-45'
when age between 46 and 60 then '46-60'
else ' 60+'
end as  age_group,
sum(sales_amount) as total_sales
from ecommerce_transactions
group by 
case when age between 15 and 25 then '15-25'
when age between 26 and 35 then '26-35'
when age between 36 and 45 then '36-45'
when age between 46 and 60 then '46-60'
else ' 60+'
end 
order by total_sales desc;

--Repeat Customers--
select customer_name,count(distinct transaction_id) as order_count
from ecommerce_transactions
group by customer_name
having count(distinct transaction_id)>1
order by order_count desc;

--Rank Customers by Sales (using Window function)--
select customer_name,sum(sales_amount)as total_sales,
rank() over(order by sum(sales_amount)desc) sales_rank from ecommerce_transactions
group by customer_name;

--Running Total of Sales (Time Analysis)---
select transaction_date,sum(sales_amount)as daily_sales,
sum(sum(sales_amount)) over (order by transaction_date )as running_totals
from ecommerce_transactions
group by transaction_date
order by transaction_date;





