import pandas as pd
from sqlalchemy import create_engine

# =========================
# DATABASE CONNECTION
# =========================
engine = create_engine(
    "postgresql://postgres:bankINDONESIA26@localhost:5432/etl_transactions_db"
)

# =========================
# LOAD DATA
# =========================
df = pd.read_csv("data/processed/transactions_transformed.csv")

# standardisasi nama kolom (jaga-jaga)
df.columns = (
    df.columns
    .str.strip()
    .str.lower()
    .str.replace(" ", "_")
)

# pastikan tipe tanggal konsisten
df["transaction_date"] = pd.to_datetime(df["transaction_date"]).dt.date

# =========================
# LOAD dim_customers
# =========================
df_customers = (
    df[["customer_id"]]
    .dropna()
    .drop_duplicates()
)

df_customers.to_sql(
    "dim_customers",
    engine,
    if_exists="append",
    index=False
)

# =========================
# LOAD dim_products (SAFE)
# =========================
df_products = (
    df[["stock_code", "description", "unit_price"]]
    .dropna(subset=["stock_code"])
    .groupby("stock_code", as_index=False)
    .agg({
        "description": "first",
        "unit_price": "mean"
    })
)

df_products.columns = [
    "product_id",
    "description",
    "unit_price"
]

df_products.to_sql(
    "dim_products",
    engine,
    if_exists="append",
    index=False
)

# =========================
# LOAD dim_date
# =========================
df_dates = (
    df[["transaction_date", "year", "month"]]
    .drop_duplicates()
)

df_dates.columns = ["date", "year", "month"]

df_dates.to_sql(
    "dim_date",
    engine,
    if_exists="append",
    index=False
)

# =========================
# LOAD fact_transactions
# =========================
date_dim = pd.read_sql(
    "SELECT date_id, date FROM dim_date",
    engine
)

date_dim["date"] = pd.to_datetime(date_dim["date"]).dt.date

df_fact = df.merge(
    date_dim,
    left_on="transaction_date",
    right_on="date",
    how="left"
)

df_fact_final = df_fact[
    ["customer_id", "stock_code", "date_id", "quantity", "total_amount"]
]

df_fact_final.columns = [
    "customer_id",
    "product_id",
    "date_id",
    "quantity",
    "total_amount"
]

df_fact_final.to_sql(
    "fact_transactions",
    engine,
    if_exists="append",
    index=False
)

print("ETL PIPELINE FINISHED SUCCESSFULLY")