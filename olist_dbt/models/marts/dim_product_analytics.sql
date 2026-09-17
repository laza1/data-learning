{{ config(materialized='table') }}

SELECT
    p.product_id,
    p.product_category_name,
    c.product_category_name_english,

    COUNT(s.order_item_id) AS item_count,

    COALESCE(SUM(s.price), 0) AS sales_amount,

    COALESCE(SUM(s.freight_value), 0) AS freight_amount,

    COALESCE(SUM(s.total_item_value), 0) AS total_sales_value

FROM {{ ref('stg_products') }} AS p

LEFT JOIN {{ ref('stg_category') }} AS c
    ON p.product_category_name = c.product_category_name

LEFT JOIN {{ ref('fct_sales') }} AS s
    ON p.product_id = s.product_id

GROUP BY
    p.product_id,
    p.product_category_name,
    c.product_category_name_english
