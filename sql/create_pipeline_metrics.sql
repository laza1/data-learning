CREATE SCHEMA IF NOT EXISTS observability;

CREATE TABLE IF NOT EXISTS observability.pipeline_metrics (
    id BIGSERIAL PRIMARY KEY,
    run_date TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    pipeline_name VARCHAR(100) NOT NULL,
    table_name VARCHAR(100) NOT NULL,
    row_count BIGINT NOT NULL
);


CREATE TABLE IF NOT EXISTS observability.pipeline_runs (
    id BIGSERIAL PRIMARY KEY,
    dag_id VARCHAR(100) NOT NULL,
    run_id VARCHAR(250) NOT NULL,
    state VARCHAR(50) NOT NULL,
    start_date TIMESTAMPTZ,
    end_date TIMESTAMPTZ,
    duration_seconds DOUBLE PRECISION,
    recorded_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE UNIQUE INDEX IF NOT EXISTS ux_pipeline_runs_dag_run
ON observability.pipeline_runs (dag_id, run_id);