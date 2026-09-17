{{ config(materialized='table') }}

SELECT
    c.customer_id,
    c.customer_unique_id,
    c.customer_city,
    c.customer_state,

    COUNT(o.order_id) AS order_count,
    COALESCE(SUM(o.sales_amount), 0) AS sales_amount,
    COALESCE(SUM(o.freight_amount), 0) AS freight_amount,
    COALESCE(SUM(o.total_order_value), 0) AS total_spend,

    MIN(o.order_purchase_timestamp) AS first_order_at,
    MAX(o.order_purchase_timestamp) AS last_order_at

FROM {{ ref('stg_customers') }} AS c

LEFT JOIN {{ ref('fct_orders') }} AS o
    ON c.customer_id = o.customer_id

GROUP BY
    c.customer_id,
    c.customer_unique_id,
    c.customer_city,
    c.customer_state
