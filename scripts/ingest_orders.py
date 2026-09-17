import csv
from pathlib import Path

from config.database import get_connection


CSV_FILE = Path("data/raw/olist_orders_dataset.csv")


CREATE_TABLE_SQL = """
CREATE TABLE IF NOT EXISTS raw.orders (
    order_id VARCHAR(32),
    customer_id VARCHAR(32),
    order_status VARCHAR(20),
    order_purchase_timestamp TIMESTAMP,
    order_approved_at TIMESTAMP,
    order_delivered_carrier_date TIMESTAMP,
    order_delivered_customer_date TIMESTAMP,
    order_estimated_delivery_date TIMESTAMP
);
"""


with get_connection() as conn:

    with conn.cursor() as cur:
        cur.execute(CREATE_TABLE_SQL)

        with cur.copy("""
            COPY raw.orders
            FROM STDIN
            WITH (FORMAT CSV, HEADER TRUE)
        """) as copy:

            with CSV_FILE.open("r", encoding="utf-8", newline="") as file:
                while data := file.read(1024 * 1024):
                    copy.write(data)

    conn.commit()

print("Orders ingestion completed.")
