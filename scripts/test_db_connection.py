import psycopg

with psycopg.connect(
    host="localhost",
    port=5432,
    dbname="olist_dw",
    user="dev",
    password="dev",
) as conn:
    with conn.cursor() as cur:
        cur.execute("SELECT current_database(), current_user;")
        print(cur.fetchone())
