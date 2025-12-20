#!/usr/bin/env python3
"""
scripts/inspect_users_range.py

Usage (from project root):
  # run for positions 10..100 inclusive:
  $env:PYTHONPATH = Resolve-Path .
 python scripts/inspect_users_range.py 10 100

Or (Unix/mac):
 PYTHONPATH=. python3 scripts/inspect_users_range.py 10 100

This script queries the users table using LIMIT/OFFSET (so "position" 1 is the first row)
and prints each row (selected columns) and a short summary.
"""
import asyncio
import sys
import os
import json
from typing import Optional

# Ensure project root is on sys.path when running as a script
project_root = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
if project_root not in sys.path:
    sys.path.insert(0, project_root)

# load config
try:
    import app.config as cfg
except Exception as e:
    print("Failed to import app.config:", e)
    raise

from sqlalchemy.ext.asyncio import create_async_engine, AsyncSession
from sqlalchemy import text
from sqlalchemy.orm import sessionmaker

def make_async_url(raw_url: str) -> str:
    """
    Convert legacy 'postgres://' to the async driver URL required by SQLAlchemy + asyncpg.
    If the URL already contains 'asyncpg' or 'postgresql+asyncpg' we leave it.
    """
    if not raw_url:
        raise RuntimeError("DATABASE_URL empty in app.config")
    if raw_url.startswith("postgres://"):
        # SQLAlchemy 1.4+ requires explicit dialect+driver
        return raw_url.replace("postgres://", "postgresql+asyncpg://", 1)
    if raw_url.startswith("postgresql+asyncpg://") or "+asyncpg" in raw_url:
        return raw_url
    # if the url is already postgresql+psycopg or similar, try to use asyncpg variant
    if raw_url.startswith("postgresql://"):
        return raw_url.replace("postgresql://", "postgresql+asyncpg://", 1)
    return raw_url

async def inspect_range(start_pos: int, end_pos: int):
    raw_url = getattr(cfg, "DATABASE_URL", None)
    if raw_url is None:
        raise RuntimeError("DATABASE_URL not found in app.config")
    async_url = make_async_url(raw_url)

    # create engine & session
    engine = create_async_engine(async_url, echo=False, future=True, pool_pre_ping=True)
    AsyncSessionLocal = sessionmaker(bind=engine, class_=AsyncSession, expire_on_commit=False)

    # compute limit/offset: user passes 1-based positions (e.g., 1..10)
    if start_pos < 1 or end_pos < start_pos:
        raise ValueError("start_pos must be >= 1 and end_pos >= start_pos")
    limit = end_pos - start_pos + 1
    offset = start_pos - 1

    q = text(f"SELECT * FROM users ORDER BY id LIMIT :limit OFFSET :offset")

    async with AsyncSessionLocal() as session:
        try:
            res = await session.execute(q, {"limit": limit, "offset": offset})
        except Exception as e:
            print("Error executing query:", e)
            await engine.dispose()
            return

        rows = res.fetchall()
        print(f"Fetched {len(rows)} rows (positions {start_pos}..{end_pos}).\n")

        # Print a JSON-like sample for each row with only the common columns
        out_list = []
        for r in rows:
            m = r._mapping
            # choose the fields you want to inspect - include resume/resume_id/fields_of_interest etc.
            obj = {
                "id": m.get("id"),
                "name": m.get("name"),
                "email": m.get("email"),
                "country": m.get("country"),
                "number": m.get("number"),
                # prefer snake_case column keys if present
                "fields_of_interest": m.get("fields_of_interest") or m.get("fieldsOfInterest") or None,
                "resume": m.get("resume"),
                "resume_id": m.get("resume_id") or m.get("resumeId") or None,
            }
            out_list.append(obj)

        # pretty print results
        print(json.dumps(out_list, indent=2, default=str))

        # summary counts within fetched rows
        with_resume = sum(1 for o in out_list if o.get("resume") is not None)
        with_resume_id = sum(1 for o in out_list if o.get("resume_id") is not None)
        with_fields = sum(1 for o in out_list if o.get("fields_of_interest"))
        print("\nSummary for fetched rows:")
        print(f"  total_rows: {len(out_list)}")
        print(f"  with resume not-null: {with_resume}")
        print(f"  with resume_id not-null: {with_resume_id}")
        print(f"  with fields_of_interest: {with_fields}")

    await engine.dispose()


def parse_args() -> Optional[tuple]:
    if len(sys.argv) not in (1, 3):
        print("Usage: python scripts/inspect_users_range.py [start end]")
        print("Example: python scripts/inspect_users_range.py 10 100")
        return None
    if len(sys.argv) == 1:
        # default example: positions 1..50
        return 1, 50
    try:
        s = int(sys.argv[1])
        e = int(sys.argv[2])
    except ValueError:
        print("start and end must be integers")
        return None
    return s, e

if __name__ == "__main__":
    parsed = parse_args()
    if not parsed:
        sys.exit(1)
    s, e = parsed
    asyncio.run(inspect_range(s, e))
