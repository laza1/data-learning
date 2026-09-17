{{ config(materialized='view') }}

SELECT
    product_category_name,
    product_category_name_english
FROM {{ source('warehouse', 'dim_category') }}
