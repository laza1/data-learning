SELECT
    order_id,
    COUNT(*) AS order_count
FROM {{ ref('fct_orders') }}
GROUP BY order_id
HAVING COUNT(*) > 1
