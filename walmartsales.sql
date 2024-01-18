-- Create database
create database if not exists walmart;

use walmart;

alter table `walmartsalesdata.csv` rename walmartsales;

select * from walmartsales;

-- Add the time_of_day column
select time,
(case 
	when `time` between "00:00:00" and "12:00:00" then "Morning"
	when `time` between "12:01:00" and "16:00:00" then "Afternoon"
	else "Evening"
    end) as time_of_date
 from walmartsales;
 
 alter table walmartsales add column time_of_day varchar(20);
 
 update walmartsales
 set time_of_day = (
 case 
	when `time` between "00:00:00" and "12:00:00" then "Morning"
	when `time` between "12:01:00" and "16:00:00" then "Afternoon"
	else "Evening"
    end
 );
 
 -- Add day_name column
 select date, dayname(date) from walmartsales;
 
 alter table walmartsales add column day_name varchar(20);
 
 update walmartsales
 set day_name = (dayname(date));
 
 -- Add month_name column
 alter table walmartsales add column month_name varchar(20);
 
  update walmartsales
 set month_name = (monthname(date));
 
 -- How many unique cities does the data have?
 select distinct(city) as unique_cities from walmartsales;
 
 -- In which city is each branch?
  select distinct city,branch as unique_branches from walmartsales;
  
-- How many unique product lines does the data have?
select count(distinct(`product line`)) as unique_pl from walmartsales;

-- What is the most used payment method
select payment, count(payment) as total_payment from walmartsales group by payment;

-- What is the most selling product line
select `product line`, count(`product line`) as cnt from walmartsales group by `product line` order by cnt desc;

-- month wise revenue
select month_name as month, sum(total) as revenue from walmartsales group by month;

select month_name as month, sum(cogs) as cogs_sum from walmartsales group by month;

-- product line wise revenue
select `product line`, sum(total) as revenue from walmartsales group by `product line` order by revenue desc;

-- city wise revenue
select city, sum(total) as revenue from walmartsales group by city order by revenue desc;

-- Which branch sold more products than average product sold?
select branch, sum(quantity) as total_sum from walmartsales group by branch;

-- What is the most common product line by gender
select gender,`product line`, count(gender) as gender_cnt from walmartsales
group by gender,`product line` order by gender_cnt desc;

-- What is the average rating of each product line
select `product line`, round(avg(rating),2) as avg_rating from walmartsales group by `product line` order by avg_rating desc;

-- How many unique customer types does the data have?
select distinct(`customer type`) from walmartsales;

-- How many unique payment methods does the data have?
select distinct(payment) from walmartsales;

-- What is the most common customer type?
select `customer type`, count(`customer type`) as cnt from walmartsales group by `customer type`;

-- What is the gender of most of the customers?
select gender, count(*) as cnt from walmartsales group by gender;

-- What is the gender distribution per branch?
select gender, branch, count(*) as cnt from walmartsales group by gender, branch;

-- Which time of the day do customers give most ratings?
SELECT time_of_day, AVG(rating) AS avg_rating
FROM walmartsales
GROUP BY time_of_day
ORDER BY avg_rating DESC;

-- Which time of the day do customers give most ratings per branch?
SELECT time_of_day,branch, AVG(rating) AS avg_rating
FROM walmartsales
GROUP BY time_of_day, branch
ORDER BY avg_rating DESC;

-- Which day fo the week has the best avg ratings?
select day_name, avg(rating) as avg_rating from walmartsales group by day_name order by avg_rating desc;

-- Which day of the week has the best average ratings per branch?
SELECT 
	day_name,
	COUNT(day_name) total_sales
FROM walmartsales
WHERE branch = "C"
GROUP BY day_name
ORDER BY total_sales DESC;