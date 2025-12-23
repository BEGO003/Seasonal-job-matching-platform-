from pathlib import Path

# === DATABASE CREDENTIALS (set via environment variables in production)
DATABASE_URL = ""
PROD_DB_HOST = ""
PROD_DB_NAME = ""
PROD_DB_USERNAME = ""
PROD_DB_PASSWORD = ""

# === Recommender settings
RECOMMENDER_CACHE_PATH = str(Path(__file__).resolve().parent / "cache")
EMBEDDING_MODEL_NAME = "all-MiniLM-L6-v2"
RECOMMENDER_MIN_SCORE = 0.15
RECOMMENDER_TOP_N = 50
