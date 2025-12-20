# app/config.py
from pathlib import Path

# === DATABASE CREDENTIALS (user requested to include them here) ===
DATABASE_URL = "postgres://u7vddsrgfrd7n9:p2ba6ccec425c2f8895c668afe2262c507d26714b88c7ebef0dac0e0f9ce75aa1@cbhpf5nl14ctov.cluster-czz5s0kz4scl.eu-west-1.rds.amazonaws.com:5432/dccblmktrrrq5n"

# Convenience fields (not required)
PROD_DB_HOST = "cbhpf5nl14ctov.cluster-czz5s0kz4scl.eu-west-1.rds.amazonaws.com"
PROD_DB_NAME = "dccblmktrrrq5n"
PROD_DB_USERNAME = "u7vddsrgfrd7n9"
PROD_DB_PASSWORD = "p2ba6ccec425c2f8895c668afe2262c507d26714b88c7ebef0dac0e0f9ce75aa1"

# Recommender settings
RECOMMENDER_CACHE_PATH = str(Path(__file__).resolve().parent / "cache")
EMBEDDING_MODEL_NAME = "all-MiniLM-L6-v2"
RECOMMENDER_MIN_SCORE = 0.15
RECOMMENDER_TOP_N = 5
