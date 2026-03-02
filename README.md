# Transaction ETL Pipeline with Star Schema (PostgreSQL)

This project demonstrates an end-to-end ETL (Extract, Transform, Load) pipeline that transforms raw transactional data into an analytics-ready data warehouse using a star schema design. The pipeline is designed to support business intelligence and analytical queries such as revenue trends, top customers, and top products.

---

## Project Objectives

- Build a complete ETL pipeline from processed transactional data
- Design and implement a **star schema** (fact & dimension tables)
- Load data into **PostgreSQL** with proper referential integrity
- Validate that the data is **analytics-ready** using SQL queries

---

## Dataset Overview

The dataset contains historical retail transaction records, including customer purchases, product details, quantities, unit prices, and transaction dates.  
It represents a typical retail transactional dataset commonly used for sales analytics and data warehousing use cases.

**Source:** [Retail Transactions: Online Sales Dataset (Year 2010-2011)](https://www.kaggle.com/datasets/shashanks1202/retail-transactions-online-sales-dataset)

---

## Data Model (Star Schema)

**Fact Table**
- `fact_transactions`
  - transaction_id
  - customer_id
  - product_id
  - date_id
  - quantity
  - total_amount

**Dimension Tables**
- `dim_customers` (customer_id)
- `dim_products` (product_id, description, unit_price)
- `dim_date` (date_id, date, year, month)

This structure enables efficient analytical queries and aligns with standard data warehouse design practices.

---

## Tech Stack

- **Python** (Pandas)
- **PostgreSQL**
- **SQLAlchemy**
- **pgAdmin**
- **Git & GitHub**

---

## ETL Workflow

1. **Extract**
   - Load processed transactional CSV data

2. **Transform**
   - Standardize column names
   - Handle duplicate dimension records using business keys
   - Ensure consistent date data types
   - Prepare fact and dimension datasets

3. **Load**
   - Load dimension tables first (`customers`, `products`, `date`)
   - Load fact table (`fact_transactions`)
   - Enforce primary and foreign key relationships

---

## Analytics-Ready Validation

After loading the data, analytical SQL queries were executed to validate usability:

- Monthly revenue trends
- Top customers by revenue
- Top products by revenue
- Average order value (AOV)
- Revenue contributions by month (%)

These queries confirm that the data model supports real-world business analysis.

---

## Project Structure

```
transaction-etl-pipeline/
├── data/
│ ├── raw/
│ │ └── transactions_raw.csv
│ └── processed/
│ ├── transactions_clean.csv
│ └── transactions_transformed.csv
├── notebooks/
│ ├── 01_data_cleaning.ipynb
│ └── 02_data_transformation.ipynb
├── scripts/
│ └── load_to_db.py
├── sql/
│ ├── schema.sql
│ └── analytics_queries.sql
├── report/
│ ├── q1_total_revenue_per_month.png
│ ├── q2_top_10_customers_by_revenue.png
│ ├── q3_top_10_products_by_revenue.png
│ ├── q4_average_order_value_(aov).png
│ └── q5_revenue_contribution_by_month_(%).png
└── README.md
```

---

## How to Run

1. Create PostgreSQL database:
   ```sql
   CREATE DATABASE etl_transactions_db;
2. Create tables using the provided schema
3. Run ETL pipeline:
   ```bash 
   python scripts/load_to_db.py
   ```
---

## Key Takeaways
- Designed a star schema for analytical workloads
- Built a reproducible ETL pipeline
- Resolved real-world data quality issues (duplicates, date mismatches)
- Validated analytics readiness with business-driven SQL queries

---

## Author
Mario Suryowisnu Wicaksono
Data Analyst | Tech Enthusiast

**LinkedIn:** *www.linkedin.com/in/marioswicaksono*

**Portfolio:** *[marioswicaksono](https://www.canva.com/design/DAG38LX1BGw/e-P9BGpUdkNq5SU0OLRN3Q/edit?utm_content=DAG38LX1BGw&utm_campaign=designshare&utm_medium=link2&utm_source=sharebutton)*
