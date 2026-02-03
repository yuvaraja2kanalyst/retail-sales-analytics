use yuva;
show tables;
select * from intern;
select count(*) from intern;
-- Changing the column name through alter
alter table intern
RENAME COLUMN `Total Amount` TO Total_Amount;
alter table intern
RENAME COLUMN `Transaction ID` TO ID;
alter table intern
RENAME COLUMN `Customer ID` TO Customer_ID;
alter table intern
RENAME COLUMN `Product Category` TO Product_Category;
alter table intern
RENAME COLUMN `Price per Unit` TO unit_Price;

-- ===============================
-- Question 1
-- Find Total Sales Revenue
select sum(Total_Amount) as Revenue
from intern;
-- ==============================
-- Question 2.
-- Count the number of unique customers.
select distinct Customer_ID as uniqu
from intern;
-- ===============================
-- Question 3.
-- Find average order value.
select avg(Total_Amount) as Average_Amount
from intern;
select avg(Quantity) as Average_Amount
from intern;
-- ===================================
-- Question 4.
-- Get total sales per Product Category.
select Product_Category,sum(Total_Amount) as Total_sales
from intern
group by Product_Category;
-- =================================
-- Question 5.
-- Get total sales by Gender.
select Gender,sum(Total_Amount) as Sales_By_Gender
from intern
group by Gender;
-- ================================
-- Question 6.
-- Find top 5 customers with highest sales.
select * from intern;
select Customer_ID, Total_Amount as Total_Sales
from intern
order by Total_Sales desc
limit 5;
-- ====================================
-- Question 7
-- Find total sales per year/month.
select month(date) as Days
from intern;

alter table intern
add column order_date date; 

update intern
set order_date=STR_TO_DATE(date, '%d-%m-%Y');

SET SQL_SAFE_UPDATES = 0;

select * from intern;
alter table intern
drop column date;
-- Question7. Find total sales per year/month.

select month(order_date),sum(Total_Amount)
from intern
group by month(order_date);

select year(order_date),sum(Total_Amount)
from intern
group by year(order_date);

-- q8.Find the most popular product category by quantity sold.
select product_category,sum(quantity) as Total_Quantity
from intern
group by product_category 
order by Total_Quantity desc
limit 1;
-- Q9. Get age-wise revenue contribution.
select * from intern;
select
case 
when age between 18 and 25 then '18-25'
when age between 26 and 35 then '26-35'
when age between 36 and 45 then '36-45'
when age between 46 and 55 then '46-55'
else '56 above'
end as age_group,
round(sum(Total_Amount)*100/sum(sum(Total_Amount)) over(),2) as revenue_Contribution
from intern
group by case 
when age between 18 and 25 then '18-25'
when age between 26 and 35 then '26-35'
when age between 36 and 45 then '36-45'
when age between 46 and 55 then '46-55'
else '56 above'
end ;
-- ====================================
-- q10. Find transactions where Total Amount > 1000.
select * from intern;
select id,Total_Amount from intern
where Total_Amount > 1000;

-- using cte
with high_Value as
(select id, Total_Amount from intern where Total_Amount > 1000)
select *,
(Select count(*) from high_value as Total_High_Values)
from high_value;

-- q11. Get the average quantity per transaction.
with t as 
(select id, sum(Total_Amount) as total_sales
from intern
group by id)
select *,round(avg(total_sales)) as average
from t
group by id;

-- q12. Find customers who purchased more than 5 times.
select customer_id, count(distinct id) as Total_transaction
from intern
group by customer_id
having count(distinct id)>5;

-- q13 Find the maximum and minimum transaction value
-- Maximum value
select * from intern
where total_Amount = (select max(total_Amount) from intern);
-- count
select count(*) from intern
where total_Amount = (select max(total_Amount) from intern); 

-- Miimum value
select * from intern
where total_Amount = (select min(total_Amount) from intern);
-- count
select count(*) from intern
where total_Amount = (select min(total_Amount) from intern);

-- q14. Write a query to get cumulative sales over time
select * from intern;
select count(*) from(
select order_date,sum(Total_Amount) over(order by order_date) as cummulative
from intern)as t;

-- q15. Get the city (if available) or Gender-wise customer count.
select gender, count(customer_id) from intern
group by gender;










