{{ config(materialized='table') }}

SELECT
    order_id,
    customer_id,
    order_status,
    order_purchase_timestamp,

    COUNT(*) AS item_count,

    SUM(price) AS sales_amount,

    SUM(freight_value) AS freight_amount,

    SUM(total_item_value) AS total_order_value

FROM {{ ref('fct_sales') }}

GROUP BY
    order_id,
    customer_id,
    order_status,
    order_purchase_timestamp
