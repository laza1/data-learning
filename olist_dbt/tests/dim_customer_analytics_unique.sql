SELECT
    customer_id,
    COUNT(*) AS customer_count
FROM {{ ref('dim_customer_analytics') }}
GROUP BY customer_id
HAVING COUNT(*) > 1
