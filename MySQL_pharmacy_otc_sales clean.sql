SELECT * 
FROM pharmacy_analysis.`pharmacy_otc_sales_data cleaned`;

-- VALIDATE DATA
-- Missing values(nulls)

SELECT 
    COUNT(*) AS total_rows,
    SUM(CASE WHEN date IS NULL THEN 1 ELSE 0 END) AS missing_date,
    SUM(CASE WHEN product IS NULL THEN 1 ELSE 0 END) AS missing_product,
    SUM(CASE WHEN `sales person` IS NULL THEN 1 ELSE 0 END) AS missing_salesperson,
    SUM(CASE WHEN `boxes shipped` IS NULL THEN 1 ELSE 0 END) AS missing_boxes,
    SUM(CASE WHEN `amount ($)` IS NULL THEN 1 ELSE 0 END) AS missing_amount,
    SUM(CASE WHEN country IS NULL THEN 1 ELSE 0 END) AS missing_country
FROM pharmacy_analysis.`pharmacy_otc_sales_data cleaned`;

-- Check negative or invalid values

select* 
from pharmacy_analysis.`pharmacy_otc_sales_data cleaned`
where `boxes shipped` < 0 or `amount ($)` < 0;

-- Check consistency/spelling
select distinct country
from pharmacy_analysis.`pharmacy_otc_sales_data cleaned`
order by country;

-- Check leading or trailing spaces
SELECT *
FROM pharmacy_analysis.`pharmacy_otc_sales_data cleaned`
WHERE product LIKE ' %' 
   OR product LIKE '% '
   OR `sales person` LIKE ' %'
   OR `sales person` LIKE '% '
   OR country LIKE ' %'
   OR country LIKE '% ';


-- Count total records
SELECT count(*) as total_records
FROM pharmacy_analysis.`pharmacy_otc_sales_data cleaned`;

-- Table structure 
describe pharmacy_analysis.`pharmacy_otc_sales_data cleaned`;

-- SALES PRODUCT
-- a) total sales per product
select product, 
       sum(`amount ($)`) as total_sales,
       sum(`boxes shipped`) as total_boxes
from pharmacy_analysis.`pharmacy_otc_sales_data cleaned`
group by product
order by total_sales desc;

-- b) average sale per product
select product, 
       sum(`amount ($)`) as avg_sales_amount,
       sum(`boxes shipped`) as avg_boxes_shipped
from pharmacy_analysis.`pharmacy_otc_sales_data cleaned`
group by product
order by avg_sales_amount desc;

-- SALES BY COUNTRY
select `country`, 
       sum(`amount ($)`) as total_sales,
       sum(`boxes shipped`) as total_boxes
from pharmacy_analysis.`pharmacy_otc_sales_data cleaned`
group by `country`
order by total_sales desc;


-- TIME-BASED
-- a) Sales by date
select date, 
       sum(`amount ($)`) as total_sales,
       sum(`boxes shipped`) as total_boxes
from pharmacy_analysis.`pharmacy_otc_sales_data cleaned`
group by date
order by date desc;

-- b) Monthly sales
 select date_format(date, '%Y-%m') as month,
        sum(`amount ($)`) as total_sales,
        sum(`boxes shipped`) as total_boxes
from pharmacy_analysis.`pharmacy_otc_sales_data cleaned`
group by month
order by month asc;


-- PERFORMANCE 
-- a) Product with highest sales

select product, sum(`amount ($)`) as total_sales
from pharmacy_analysis.`pharmacy_otc_sales_data cleaned`
group by product
order by total_sales desc
limit 5;

-- b) Country with highest boxes shiped

select country, sum(`amount ($)`) as total_sales
from pharmacy_analysis.`pharmacy_otc_sales_data cleaned`
group by country
order by total_sales desc
limit 5;

-- c) Salesperson with lowest performance

select `sales person`, sum(`amount ($)`) as total_sales
from pharmacy_analysis.`pharmacy_otc_sales_data cleaned`
group by `sales person`
order by total_sales asc
limit 5;


-- SALES SUMMARY
-- a) Total sale and boxes shipped

select sum(`amount ($)`) as total_sales,
        sum(`boxes shipped`) as total_boxes
from pharmacy_analysis.`pharmacy_otc_sales_data cleaned`;

-- b) Average sales per transaction
select avg(`amount ($)`) as total_sales,
	   avg(`boxes shipped`) as total_boxes
from pharmacy_analysis.`pharmacy_otc_sales_data cleaned`;

-- c) MAx and Min
select max(`amount ($)`) as total_sales,
        max(`boxes shipped`) as total_boxes
from pharmacy_analysis.`pharmacy_otc_sales_data cleaned`;


-- GROWTH RATE
-- a) Monthly total sales & growth rate: Which months had growth or deckined and seasonal patterns in sales

SELECT 
    month,
    total_sales,
    prev_month_sales,
    IFNULL(
        ROUND((total_sales - prev_month_sales) / prev_month_sales * 100, 2),
        0
    ) AS growth_rate_percent
FROM (
    SELECT 
        DATE_FORMAT(date, '%Y-%m') AS month,
        SUM(`amount ($)`) AS total_sales,
        LAG(SUM(`amount ($)`)) OVER (ORDER BY DATE_FORMAT(date, '%Y-%m')) AS prev_month_sales
    FROM pharmacy_analysis.`pharmacy_otc_sales_data cleaned`
    GROUP BY month
) t
where prev_month_sales is not null
ORDER BY month;

-- b) Product per salesperson: Best selling products? how much revenue each products brings

SELECT *
FROM (
    SELECT 
        `sales person`,
        product,
        SUM(`amount ($)`) AS total_sales,
        ROW_NUMBER() OVER (
            PARTITION BY `sales person`
            ORDER BY SUM(`amount ($)`) DESC
        ) AS rank_num
    FROM pharmacy_analysis.`pharmacy_otc_sales_data cleaned`
    GROUP BY `sales person`, product
) ranked
WHERE rank_num <= 3;
   


-- PIVOT TABLES

-- a) Pivot by country

select
      Country, 
       sum(`boxes shipped`) as Total_Boxes,
       sum(`amount ($)`) as Total_Amount
from pharmacy_analysis.`pharmacy_otc_sales_data cleaned`
group by Country
order by Total_Amount desc;

-- b) Pivot by Sales Person

select `sales person`,
sum(`boxes shipped`) as Total_Boxes,
sum(`amount ($)`) as Total_Amount
from pharmacy_analysis.`pharmacy_otc_sales_data cleaned`
group by `sales person`
order by Total_Amount desc;

-- c) Pivoted by Date
select 
date_format(Date, '%Y-%m') as Month,
sum(`boxes shipped`) as Total_Boxes,
sum(`amount ($)`) as Total_Amount
from pharmacy_analysis.`pharmacy_otc_sales_data cleaned`
group by Month
order by Month;

-- d) Pivot by Product

select product,
sum(`boxes shipped`) as Total_Boxes,
sum(`amount ($)`) as Total_Amount
from pharmacy_analysis.`pharmacy_otc_sales_data cleaned`
group by product
order by Total_Amount desc;
        












