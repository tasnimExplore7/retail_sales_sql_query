select * from retail_table;   
-----------------------------
drop table if exists retail_table; 
-------------------------------------
create table retail_table 
           ( 
             transactions_id int primary key, 
			 sale_date date,	
			 sale_time time,	 
			 customer_id int,
			 gender varchar(20), 
			 age int, 	
			 category varchar(20),	
			 quantiy int,	
			 price_per_unit float,	
			 cogs float,	
			 total_sale float
           ) 
-------------------------------- 

SELECT COUNT(*) FROM retail_table

---------------------------------- null check -----------------
select * from retail_table where transactions_id is null  
----------------------------------null values------------------- 

select * from retail_table 
where transactions_id is null 
or sale_date is null 
or sale_time is null 
or customer_id is null 
or gender is null 
or age is null 
or category is null 
or quantiy is null  
or price_per_unit is null 
or cogs is null 
or total_sale is null 
------------------------------------------delete null
--delete from retail_table 
where transactions_id is null 
or sale_date is null 
or sale_time is null 
or customer_id is null 
or gender is null 
or age is null 
or category is null 
or quantiy is null  
or price_per_unit is null 
or cogs is null 
or total_sale is null
----------------------------------
--fill up null of age-------- 
UPDATE retail_table
SET age = (
    SELECT ROUND(AVG(age))
    FROM retail_table
)
WHERE age IS NULL;
-----------------------------
SELECT *
FROM retail_table
WHERE age IS NULL;

---------------------------------delete null---
delete from retail_table 
where transactions_id is null 
or sale_date is null 
or sale_time is null 
or customer_id is null 
or gender is null 
or age is null 
or category is null 
or quantiy is null  
or price_per_unit is null 
or cogs is null 
or total_sale is null

----how many sale we have------------- 
select count(*) as total_sale from retail_table

---how many unique customer we have -----------------

select count(distinct customer_id) as totalsale from retail_table
-------------------------------------
--how many unique category we have ---------
select count(distinct category) as totalsale from retail_table
---type of category ------ 

select distinct category from retail_table

-----------------------data analysis and business problem and answer---------- 
---1. write a sql query to retrive all column for sales made on 2022-11-05------

select * from retail_table where sale_date = '2022-11-05'

----2. write a sql query to retrive all transaction where category is clothing and the quantiy
---sold is more than 10 in the month of nov 2022 
select  
      category,  
	  sum(quantiy) as total_quantity 
from retail_table  
where category = 'Clothing'
group by category
---------------------------------
SELECT * from retail_table where category = 'Clothing' 
and to_char(sale_date, 'yyyy-mm') = '2022-11' 
and quantiy >= 4

------------------------------------
--3. write the sql query to calculate the total sale for each category
select category, sum(total_sale) as net_sale from retail_table group by 1
----------------------------- 
select category, sum(total_sale) as net_sale, count(*) AS total_order from retail_table 
group by 1
-----------------------------------------------
-- 4. weite a sql query to find the average age of customer who purchase item from 
-- beauty category 

select round(avg(age), 2) as avg_age from retail_table where category = 'Beauty'

-------------------------------------------------------- 
--5. Write a sql query to find all transaction where the total sale is greater than 1000
select * from retail_table where total_sale > 1000

-------------------------------------------------------- 
--6. wrire sql query to find total number of transaction (transaction_id) made by each  
--gender in each category 
select category, gender, count(*) as total_transaction  
from retail_table 
group by 1, 2 order by 1

--------------------------------------------------------- 
--7. write a sql query to calculate the average sale for each month. find out the best  
--selling month in each year   ---------#---mysql-- Year(sale_date)
select extract(year from sale_date) as Year, 
extract(month from sale_date) as Month, 
avg(total_sale) as Avg_sale 
From retail_table Group by 1, 2 order by 1, 3 desc 

----------------------------------------------------------   
select extract(year from sale_date) as Year, 
extract(month from sale_date) as Month, 
avg(total_sale) as Avg_sale,  
rank() over(partition by extract(year from sale_date) order by avg(total_sale) desc) as rank
From retail_table Group by 1, 2  
---------------------------------------------------------------
select * from  
( 
  select extract(year from sale_date) as Year, 
  extract(month from sale_date) as Month, 
  avg(total_sale) as Avg_sale,  
  rank() over(partition by extract(year from sale_date) order by avg(total_sale) desc) as rank
  From retail_table Group by 1, 2 
) as t1 
where rank = 1
-------------------------------------

--8.  write a sql query to find the top five customer based on the highest total sales 
select customer_id, 
sum(total_sale) as total_sales 
from retail_table group by 1 order by 2 desc limit 10

----------------------------------------------
--9. write a sql query to find the number of unique customer who purchased item 
--from each category
select category,  
count(distinct customer_id) as unique_customer
from retail_table 
group by category

------------------------------------------------- 
--10. write a sql query to create each shift and number of order 
--examole morning <=12, afternoon between 12 & 17, evening > 17 
select *, 
   case 
	   when extract(hour from sale_time) < 12 then 'Morning' 
	   when extract(hour from sale_time) between 12 and 17 then 'Afternoon' 
	   else 'Evening' 
	end as shift 
	from retail_table  
--------------------------------------------------- 
with hourly_sale 
as 
( 
 select *, 
   case 
	   when extract(hour from sale_time) < 12 then 'Morning' 
	   when extract(hour from sale_time) between 12 and 17 then 'Afternoon' 
	   else 'Evening' 
	end as shift 
	from retail_table 
)
select shift, 
count(*) as total_orders 
from hourly_sale  group by shift


------------------------------------------------------------- 
--select extract(hour from current_time) 








