import os
from pathlib import Path

# === DATABASE CREDENTIALS (set via environment variables)
# 1. Try fully qualified DATABASE_URL first
DATABASE_URL = os.getenv("DATABASE_URL", "")

# 2. If not set, construct from PROD_DB_* variables (matching Spring Boot)
if not DATABASE_URL:
    db_user = os.getenv("PROD_DB_USERNAME", "")
    db_pass = os.getenv("PROD_DB_PASSWORD", "")
    db_host = os.getenv("PROD_DB_HOST", "")
    db_port = os.getenv("PROD_DB_PORT", "5432")
    db_name = os.getenv("PROD_DB_NAME", "")
    
    if db_user and db_host and db_name:
        DATABASE_URL = f"postgresql+asyncpg://{db_user}:{db_pass}@{db_host}:{db_port}/{db_name}?ssl=require"

# Fallback/Constants for reference (optional)
PROD_DB_HOST = os.getenv("PROD_DB_HOST", "")
PROD_DB_NAME = os.getenv("PROD_DB_NAME", "")
PROD_DB_USERNAME = os.getenv("PROD_DB_USERNAME", "")
PROD_DB_PASSWORD = os.getenv("PROD_DB_PASSWORD", "")

# === Recommender settings
RECOMMENDER_CACHE_PATH = str(Path(__file__).resolve().parent / "cache")
EMBEDDING_MODEL_NAME = "all-MiniLM-L6-v2"
RECOMMENDER_MIN_SCORE = 0.15
RECOMMENDER_TOP_N = 50
