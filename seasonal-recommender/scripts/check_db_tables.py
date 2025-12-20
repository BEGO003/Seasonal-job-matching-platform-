# scripts/check_db_tables.py
# Run with: python scripts/check_db_tables.py
import os, sys
# ensure current directory is on python path
project_root = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
if project_root not in sys.path:
    sys.path.insert(0, project_root)

import asyncio
import os
import json
from sqlalchemy import text
from sqlalchemy.ext.asyncio import create_async_engine, AsyncSession
from sqlalchemy.orm import sessionmaker


def get_database_url():
    """Load DB URL from app.config or environment."""
    try:
        from app import config as app_config
        db = getattr(app_config, "DATABASE_URL", None)
        if db:
            return db
    except Exception:
        pass

    env_url = os.environ.get("DATABASE_URL")
    if env_url:
        return env_url

    raise RuntimeError("DATABASE_URL not found in config.py or environment variables!")


def normalize_for_sqlalchemy(url: str) -> str:
    """SQLAlchemy asyncpg requires postgresql+asyncpg://"""
    if url.startswith("postgres://"):
        return url.replace("postgres://", "postgresql+asyncpg://", 1)
    if url.startswith("postgresql://"):
        return url.replace("postgresql://", "postgresql+asyncpg://", 1)
    return url


async def inspect_table(session, table_name):
    """Inspect a single table: existence, columns, rows, sample data."""
    result = {}

    # Check existence
    q_exists = text("""
        SELECT EXISTS (
            SELECT 1 FROM information_schema.tables
            WHERE table_schema NOT IN ('pg_catalog','information_schema')
              AND table_name = :t
        )
    """)
    exists = (await session.execute(q_exists, {"t": table_name})).scalar()
    result["exists"] = bool(exists)

    if not exists:
        return result

    # Fetch columns
    q_cols = text("""
        SELECT column_name, data_type
        FROM information_schema.columns
        WHERE table_name = :t
        ORDER BY ordinal_position
    """)
    cols = await session.execute(q_cols, {"t": table_name})
    result["columns"] = [{"name": c[0], "type": c[1]} for c in cols.fetchall()]

    # Row count
    q_count = text(f"SELECT COUNT(*) FROM {table_name}")
    count = (await session.execute(q_count)).scalar()
    result["row_count"] = int(count)

    # Sample rows
    q_sample = text(f"SELECT * FROM {table_name} LIMIT 5")
    rows = (await session.execute(q_sample)).fetchall()
    out_rows = []
    for r in rows:
        mapping = r._mapping
        out_rows.append({k: mapping.get(k) for k in mapping.keys()})
    result["sample"] = out_rows

    return result


async def main():
    raw_url = get_database_url()
    url = normalize_for_sqlalchemy(raw_url)

    print("Using database:", "<hidden for safety>")

    engine = create_async_engine(url, echo=False)
    async_session = sessionmaker(engine, expire_on_commit=False, class_=AsyncSession)

    async with async_session() as session:
        output = {}

        # Check users table
        output["users"] = await inspect_table(session, "users")

        # Check resumes table
        output["resumes"] = await inspect_table(session, "resumes")

        # Print result cleanly
        print(json.dumps(output, indent=2, default=str))

    await engine.dispose()


if __name__ == "__main__":
    asyncio.run(main())
