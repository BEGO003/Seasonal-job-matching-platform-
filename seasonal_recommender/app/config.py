import os
from pathlib import Path

# === DATABASE (Heroku provides DATABASE_URL)
DATABASE_URL = os.getenv("DATABASE_URL")

if not DATABASE_URL:
    raise RuntimeError("DATABASE_URL environment variable is not set")

# Async SQLAlchemy requires asyncpg driver
ASYNC_DATABASE_URL = DATABASE_URL.replace(
    "postgres://", "postgresql+asyncpg://", 1
)

# === Recommender settings
RECOMMENDER_CACHE_PATH = str(Path(__file__).resolve().parent / "cache")
EMBEDDING_MODEL_NAME = "all-MiniLM-L6-v2"
RECOMMENDER_MIN_SCORE = 0.15
RECOMMENDER_TOP_N = 50
