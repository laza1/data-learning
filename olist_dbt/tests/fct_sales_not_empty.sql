SELECT 1
WHERE NOT EXISTS (
    SELECT 1
    FROM {{ ref('fct_sales') }}
)