WITH metrics AS (
    SELECT
        table_name,
        row_count,
        LAG(row_count) OVER (
            PARTITION BY table_name
            ORDER BY run_date
        ) AS previous_row_count
    FROM observability.pipeline_metrics
    WHERE pipeline_name = 'olist_daily_pipeline'
)

SELECT *
FROM metrics
WHERE previous_row_count IS NOT NULL
  AND row_count < previous_row_count * 0.8
