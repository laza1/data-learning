SELECT
    product_id,
    COUNT(*) AS product_count
FROM {{ ref('dim_product_analytics') }}
GROUP BY product_id
HAVING COUNT(*) > 1
