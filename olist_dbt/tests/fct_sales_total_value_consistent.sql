SELECT *
FROM {{ ref('fct_sales') }}
WHERE total_item_value <> price + freight_value
