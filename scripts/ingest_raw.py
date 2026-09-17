import sys
from pathlib import Path

from config.database import get_connection


#DATA_DIR = Path("data/raw")
DATA_DIR = Path(__file__).resolve().parents[1] / "data" / "raw"


#def ingest(table_name: str, csv_file: str):
def ingest(table_name: str, csv_file: str, connection_factory=get_connection):
    csv_path = DATA_DIR / csv_file

    if not csv_path.exists():
        print(f"ERROR: File not found: {csv_path}")
        sys.exit(1)

    print(f"Ingesting {csv_path} → raw.{table_name}")

    with connection_factory() as conn:

        with conn.cursor() as cur:

            # Make the ingestion idempotent:
            # running the pipeline again will not duplicate data.
            cur.execute(f"TRUNCATE TABLE raw.{table_name}")

            with cur.copy(f"""
                COPY raw.{table_name}
                FROM STDIN
                WITH (FORMAT CSV, HEADER TRUE)
            """) as copy:

                with csv_path.open(
                    "r",
                    encoding="utf-8-sig",
                    newline=""
                ) as file:

                    while data := file.read(1024 * 1024):
                        copy.write(data)

        conn.commit()

    # Validate the number of rows loaded
    with connection_factory() as conn:

        with conn.cursor() as cur:
            cur.execute(f"SELECT COUNT(*) FROM raw.{table_name}")
            count = cur.fetchone()[0]

    print(f"Ingestion completed: {count:,} rows.")


if __name__ == "__main__":

    if len(sys.argv) != 3:
        print(
            "Usage: "
            "python scripts/ingest_raw.py <table> <csv_file>"
        )
        sys.exit(1)

    table_name = sys.argv[1]
    csv_file = sys.argv[2]
    ingest(table_name, csv_file)
    
