-- DIMENSION TABLES

CREATE TABLE dim_customers (
    customer_id INT PRIMARY KEY
);

CREATE TABLE dim_products (
    product_id VARCHAR(50) PRIMARY KEY,
    description TEXT,
    unit_price NUMERIC
);

CREATE TABLE dim_date (
    date_id SERIAL PRIMARY KEY,
    date DATE,
    year INT,
    month INT
);

-- FACT TABLE

CREATE TABLE fact_transactions (
    transaction_id SERIAL PRIMARY KEY,
    customer_id INT REFERENCES dim_customers(customer_id),
    product_id VARCHAR(50) REFERENCES dim_products(product_id),
    date_id INT REFERENCES dim_date(date_id),
    quantity INT,
    total_amount NUMERIC
);