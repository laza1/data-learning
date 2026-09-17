SELECT
    month,
    COUNT(*) AS month_count
FROM {{ ref('fct_monthly_sales') }}
GROUP BY month
HAVING COUNT(*) > 1
