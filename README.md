# 💊 Pharmacy OTC Sales Analysis (MySQL)
## 📌 Project Overview
This project analyzes pharmacy over-the-counter (OTC) sales data using MySQL.
It demonstrates end-to-end data analytics skills, including data cleaning, transformation, and extracting actionable business insights.
---
## 🎯 Objectives

* Clean and standardize raw sales data
* Perform exploratory data analysis using SQL
* Generate insights for business decision-making
* Prepare structured data for dashboard visualization
---
## 📁 Dataset Description

The dataset includes:
* 🧾 Product names
* 🌍 Country/region
* 👤 Salesperson
* 📦 Quantity sold (boxes)
* 💰 Sales revenue
* 📅 Monthly sales data
---
## ⚙️ Tools & Technologies

* **MySQL** (Data analysis)
* **SQL** (Queries, transformations)
* **Microsoft Excel** (Dashboard & visualization)
---
## 🧹 Data Cleaning Process

Key cleaning steps performed:
* Removed duplicates
* Standardized column names
* Handled missing/null values
* Formatted numeric fields (sales, quantities)
* Structured dataset for analysis
---
## 🔍 Key SQL Queries
### 1️⃣ Total Sales by Product

```sql
SELECT product, SUM(sales) AS total_sales
FROM pharmacy_sales
GROUP BY product
ORDER BY total_sales DESC;
```
---
### 2️⃣ Monthly Sales Trend

```sql
SELECT month, SUM(sales) AS monthly_sales
FROM pharmacy_sales
GROUP BY month
ORDER BY month;
```
---
### 3️⃣ Top Performing Salespersons

```sql
SELECT salesperson, SUM(sales) AS total_sales
FROM pharmacy_sales
GROUP BY salesperson
ORDER BY total_sales DESC;
```
---
### 4️⃣ Sales by Country

```sql
SELECT country, SUM(sales) AS total_sales
FROM pharmacy_sales
GROUP BY country
ORDER BY total_sales DESC;
```
---
## 📊 Key Insights

* 📈 Certain products consistently outperform others in revenue
* 🌍 Sales vary significantly across countries
* 👤 A small group of salespersons generate the majority of revenue
* 📅 Monthly trends reveal peak sales periods
---
## 📉 Before vs After Cleaning

| Stage        | Description                            |
| ------------ | -------------------------------------- |
| Raw Data     | Unstructured, inconsistent formatting  |
| Cleaned Data | Standardized, analysis-ready dataset   |
| Final Output | Optimized for SQL queries & dashboards |
---
## 📊 Dashboard Integration

The cleaned dataset was exported to Excel and used to create:
* Pivot tables
* Interactive slicers
* Sales dashboard
---
## 🚀 How to Use

1. Import the `.sql` file into MySQL
2. Run the provided queries
3. Modify queries to explore further insights
4. Export results for visualization (Excel/Power BI)
---
## 🔮 Future Improvements

* Advanced SQL (window functions, joins)
* Automated reporting pipeline
* Integration with Power BI or Tableau
* Predictive analytics on sales trends
---

## 👤 Author

**Teddy Mathabatha**

---

## ⭐ Portfolio Note

This project showcases practical SQL skills required for a **Data Analyst role**, including data cleaning, querying, and insight generation.

