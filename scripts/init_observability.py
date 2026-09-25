import sys
from pathlib import Path

PROJECT_ROOT = Path(__file__).resolve().parent.parent
sys.path.insert(0, str(PROJECT_ROOT))

from config.database import get_connection

def init_observability():
    sql_file = (
        Path(__file__).resolve().parent.parent
        / "sql"
        / "create_pipeline_metrics.sql"
    )

    sql = sql_file.read_text(encoding="utf-8")

    with get_connection() as conn:
        with conn.cursor() as cursor:
            cursor.execute(sql)

        conn.commit()

    print("Observability infrastructure initialized successfully.")


if __name__ == "__main__":
    init_observability()
