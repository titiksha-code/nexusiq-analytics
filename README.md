# 📊 E-Commerce Sales & Customer Analytics Platform

<div align="center">

![Dashboard Preview](screenshots/dashboard_overview.png)

[![SQL](https://img.shields.io/badge/SQL-MySQL%208.0-4479A1?style=for-the-badge&logo=mysql&logoColor=white)](https://www.mysql.com/)
[![Power BI](https://img.shields.io/badge/Power%20BI-Dashboard-F2C811?style=for-the-badge&logo=powerbi&logoColor=black)](https://powerbi.microsoft.com/)
[![Excel](https://img.shields.io/badge/Microsoft-Excel-217346?style=for-the-badge&logo=microsoftexcel&logoColor=white)](https://www.microsoft.com/excel)
[![License](https://img.shields.io/badge/License-MIT-green?style=for-the-badge)](LICENSE)
[![Status](https://img.shields.io/badge/Status-Active-brightgreen?style=for-the-badge)]()

**A production-grade analytics platform built entirely in SQL** — covering sales KPIs, customer behaviour, product performance, regional heatmaps, forecasting, and customer segmentation across a full e-commerce data model.

[View Dashboard →](#-dashboard-preview) · [SQL Queries →](sql/02_analytics_queries.sql) · [Schema →](sql/01_schema.sql) · [Report an Issue](../../issues)

</div>

---

## 📌 Table of Contents

- [Overview](#-overview)
- [Dashboard Preview](#-dashboard-preview)
- [Features](#-features)
- [Database Schema](#-database-schema)
- [Dashboard Sections](#-dashboard-sections)
- [Advanced Add-ons](#-advanced-add-ons)
- [Project Structure](#-project-structure)
- [Getting Started](#-getting-started)
- [Key SQL Techniques Used](#-key-sql-techniques-used)
- [Tools & Tech Stack](#-tools--tech-stack)
- [Author](#-author)

---

## 🌟 Overview

This project simulates a **real-world e-commerce analytics system** for a retail business. It is designed to answer business questions across four dimensions:

| Dimension | Questions Answered |
|---|---|
| **Sales** | How much revenue did we make? What is our profit margin? |
| **Customers** | Who are our top buyers? What is our retention rate? |
| **Products** | What sells best? What should we discontinue? |
| **Region** | Which states drive the most revenue? |

All analytics are powered by **pure SQL** — no Python, no Pandas. The final output is visualised in **Power BI** and **Excel**.

---

## 🖼 Dashboard Preview

### Sales KPI Overview
![Sales KPIs](screenshots/01_sales_kpis.png)

### Customer Analytics
![Customer Analytics](screenshots/02_customer_analytics.png)

### Product Performance
![Product Analytics](screenshots/03_product_analytics.png)

### Regional Revenue Heatmap
![Regional Heatmap](screenshots/04_regional_heatmap.png)

### Advanced Analytics (Forecasting + Segmentation)
![Advanced Analytics](screenshots/05_advanced_analytics.png)

---

## ✨ Features

### 📈 Sales KPIs
- **Total Revenue** — aggregated net revenue after discounts
- **Total Orders** — distinct order count excluding cancellations/returns
- **Net Profit** — revenue minus cost of goods sold
- **Average Order Value (AOV)** — revenue ÷ order count
- **Monthly Revenue & Profit Trend** — 12-month line chart data
- **Year-over-Year Comparison** — growth rate calculation

### 👥 Customer Analytics
- **Top 10 Customers** ranked by lifetime value
- **Repeat Customer Rate** — customers with more than one order
- **Customer Retention Cohort Analysis** — month-over-month retention
- **RFM Segmentation** — Recency, Frequency, Monetary scoring with NTILE()

### 📦 Product Analytics
- **Best-selling products** by revenue, units, and margin
- **Low-performing products** flagged for review
- **Category Revenue Share** with window functions
- **Profit Margin Analysis** by category

### 🗺 Regional Analytics
- **Sales by State** — ranked revenue table
- **Sales by City** — top 20 cities
- **Revenue Heatmap** — Region × Month cross-tab

### 🚀 Advanced Add-ons
- **Sales Forecasting** — 3-month moving average baseline
- **Customer Segmentation** — RFM-based Champions / Loyal / At Risk / Lost labels
- **Recommendation Insights** — co-purchase analysis (market basket)
- **Projected Annual CLV** — customer lifetime value proxy
- **Churn Detection** — customers inactive 90+ days
- **Return Rate Analysis** — by product

---

## 🗄 Database Schema

```
customers ──< orders ──< order_items >── products
                 │
               returns
```

| Table | Rows (sample) | Key Columns |
|---|---|---|
| `customers` | 8 | customer_id, segment, region, signup_date |
| `products` | 8 | product_id, category, unit_cost, unit_price |
| `orders` | 10 | order_id, customer_id, order_date, status, state |
| `order_items` | 16 | item_id, order_id, product_id, quantity, discount_pct |
| `returns` | — | return_id, order_id, return_date, reason |

**Full schema:** [`sql/01_schema.sql`](sql/01_schema.sql)

---

## 📊 Dashboard Sections

### 1. Sales KPIs
Four headline metric cards — revenue, orders, profit, AOV — with delta vs. prior year. Backed by a monthly trend line.

> **SQL highlight:** Discount-adjusted revenue using `unit_price * quantity * (1 - discount_pct / 100)` across all queries.

### 2. Customer Analytics
Retention cohort built with a `WITH` CTE that joins customers to their next-month activity. RFM scoring uses `NTILE(5)` window functions for consistent percentile bucketing.

> **SQL highlight:** `NTILE(5) OVER (ORDER BY monetary)` for monetary scoring without hard-coded thresholds.

### 3. Product Analytics
Best-sellers ranked by revenue with margin % calculated inline. Low performers identified via `LEFT JOIN` to surface products with zero or near-zero sales.

> **SQL highlight:** `SUM() OVER ()` (window function) for category revenue share percentage.

### 4. Regional Analytics
State and city breakdowns joined from `orders.state`/`orders.city`. Heatmap pivot done in Power BI using Region × Month matrix visual.

### 5. Advanced Add-ons
- Forecasting baseline: `AVG() OVER (ROWS BETWEEN 2 PRECEDING AND CURRENT ROW)` sliding window
- Co-purchase: self-join on `order_items` where `order_id` matches but `product_id` differs
- Churn: `HAVING DATEDIFF(CURDATE(), MAX(order_date)) > 90`

---

## 🚀 Getting Started

### Prerequisites
- MySQL 8.0+ (or compatible: MariaDB 10.5+, PostgreSQL with minor adjustments)
- MySQL Workbench / DBeaver / any SQL client
- Power BI Desktop (for dashboard file) — optional

### 1. Clone the repository
```bash
git clone https://github.com/YOUR_USERNAME/ecommerce-analytics.git
cd ecommerce-analytics
```

### 2. Create the database & schema
```bash
mysql -u root -p < sql/01_schema.sql
```

### 3. Load sample data
```bash
mysql -u root -p < sql/03_sample_data.sql
```

### 4. Run analytics queries
```bash
mysql -u root -p ecommerce_analytics < sql/02_analytics_queries.sql
```
Or open `sql/02_analytics_queries.sql` in MySQL Workbench and run sections individually.

### 5. Connect Power BI (optional)
1. Open Power BI Desktop
2. Get Data → MySQL database
3. Enter your host/credentials
4. Import tables: `customers`, `orders`, `order_items`, `products`
5. Use the SQL queries as custom data sources for each visual

---

## 🔑 Key SQL Techniques Used

| Technique | Where Used |
|---|---|
| `WITH` (CTEs) | Retention cohort, RFM scoring |
| `NTILE(n) OVER ()` | RFM percentile buckets |
| `AVG() OVER (ROWS BETWEEN ...)` | 3-month moving average |
| `SUM() OVER ()` | Category revenue share % |
| `LEFT JOIN` | Surface zero-sales products |
| Self-join | Co-purchase / market basket |
| `HAVING` with aggregates | Repeat customers, churn detection |
| `DATEDIFF()` | Recency, customer lifespan |
| `NULLIF()` | Avoid division-by-zero in margin % |
| `DATE_FORMAT()` | Monthly grouping for trend charts |
| `CASE WHEN` | Segment labelling in RFM |

---

## 🛠 Tools & Tech Stack

| Tool | Purpose |
|---|---|
| **MySQL 8.0** | Primary analytics engine — all queries |
| **Power BI Desktop** | Interactive dashboard & visuals |
| **Microsoft Excel** | Pivot tables, secondary reporting |
| **MySQL Workbench** | Query development & schema design |
| **Git / GitHub** | Version control & portfolio hosting |

---

## 📁 Project Structure

```
ecommerce-analytics/
│
├── sql/
│   ├── 01_schema.sql            # Database tables & indexes
│   ├── 02_analytics_queries.sql # All dashboard queries (50+ queries)
│   └── 03_sample_data.sql       # Seed data for demo
│
├── screenshots/
│   ├── dashboard_overview.png
│   ├── 01_sales_kpis.png
│   ├── 02_customer_analytics.png
│   ├── 03_product_analytics.png
│   ├── 04_regional_heatmap.png
│   └── 05_advanced_analytics.png
│
├── docs/
│   └── data_dictionary.md       # Column descriptions (optional)
│
└── README.md
```

---

## 💡 What I Learned

- Designing a normalised relational schema for e-commerce data
- Writing complex analytical SQL using window functions, CTEs, and self-joins
- Building RFM customer segmentation from scratch without external libraries
- Translating SQL output into Power BI visuals with drill-through and slicers
- Structuring a GitHub project for portfolio visibility

---

## 🤝 Contributing

Pull requests are welcome! For major changes, open an issue first to discuss what you'd like to change.

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/new-query`)
3. Commit your changes (`git commit -m 'Add CLV cohort analysis'`)
4. Push to the branch (`git push origin feature/new-query`)
5. Open a Pull Request

---

## 📄 License

This project is licensed under the MIT License — see [LICENSE](LICENSE) for details.

---

## 👤 Author

**Your Name**
- GitHub: [@YOUR_USERNAME](https://github.com/YOUR_USERNAME)
- LinkedIn: [linkedin.com/in/YOUR_PROFILE](https://linkedin.com/in/YOUR_PROFILE)
- Email: your.email@example.com

---

<div align="center">

⭐ **If this project helped you, please give it a star!** ⭐

*Built with SQL · Visualised with Power BI · Hosted on GitHub*

</div>
