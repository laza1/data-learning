{{ config(materialized='table') }}

SELECT
    oi.order_id,
    oi.order_item_id,
    o.customer_id,
    oi.product_id,
    oi.seller_id,
    o.order_status,
    o.order_purchase_timestamp,
    oi.price,
    oi.freight_value,
    oi.price + oi.freight_value AS total_item_value
FROM {{ ref('stg_order_items') }} AS oi
JOIN {{ ref('stg_orders') }} AS o
    ON oi.order_id = o.order_id
