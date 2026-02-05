-- Q1 — Total Revenue per Month
SELECT
    d.year,
    d.month,
    SUM(f.total_amount) AS total_revenue
FROM fact_transactions f
JOIN dim_date d ON f.date_id = d.date_id
GROUP BY d.year, d.month
ORDER BY d.year, d.month;

-- Q2 — Top 10 Customers by Revenue
SELECT
    f.customer_id,
    SUM(f.total_amount) AS total_revenue
FROM fact_transactions f
GROUP BY f.customer_id
ORDER BY total_revenue DESC
LIMIT 10;

-- Q3 — Top 10 Products by Revenue
SELECT
    p.product_id,
    p.description,
    SUM(f.total_amount) AS total_revenue
FROM fact_transactions f
JOIN dim_products p ON f.product_id = p.product_id
GROUP BY p.product_id, p.description
ORDER BY total_revenue DESC
LIMIT 10;

-- Q4 — Average Order Value (AOV)
SELECT
    AVG(order_total) AS avg_order_value
FROM (
    SELECT
        transaction_id,
        SUM(total_amount) AS order_total
    FROM fact_transactions
    GROUP BY transaction_id
) t;

-- Q5 — Revenue Contribution by Month (%)
WITH monthly_revenue AS (
    SELECT
        d.year,
        d.month,
        SUM(f.total_amount) AS revenue
    FROM fact_transactions f
    JOIN dim_date d ON f.date_id = d.date_id
    GROUP BY d.year, d.month
)
SELECT
    year,
    month,
    revenue,
    ROUND(
        revenue / SUM(revenue) OVER () * 100,
        2
    ) AS revenue_percentage
FROM monthly_revenue
ORDER BY year, month;


