{{ config(materialized='table') }}

SELECT
    DATE_TRUNC('month', order_purchase_timestamp)::date AS month,

    COUNT(DISTINCT order_id) AS order_count,

    SUM(sales_amount) AS sales_amount,

    SUM(freight_amount) AS freight_amount,

    SUM(total_order_value) AS total_sales_value,

    AVG(total_order_value) AS average_order_value

FROM {{ ref('fct_orders') }}

GROUP BY
    DATE_TRUNC('month', order_purchase_timestamp)::date

ORDER BY
    month
