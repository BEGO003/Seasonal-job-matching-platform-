from fastapi import FastAPI
import logging
import sys

# Setup logging to ensure we see startup errors
logging.basicConfig(stream=sys.stdout, level=logging.INFO)
logger = logging.getLogger("startup")
logger.info("Initializing FastAPI Application...")

from app.api.endpoints import router as api_router

# import admin router (create file if it doesn't exist)
try:
    from app.api.admin import admin_router
except Exception:
    admin_router = None

app = FastAPI(title="Seasonal Jobs Recommender (SBERT + FAISS)")

# include main API router
app.include_router(api_router)

# include admin router if available
if admin_router is not None:
    app.include_router(admin_router)

@app.get("/")
async def root():
    logger.info("Health check endpoint called")
    return {"status": "ok", "message": "Recommender service running"}

@app.get("/test-db")
async def test_db():
    from app.db import AsyncSessionLocal
    from sqlalchemy import text
    try:
        async with AsyncSessionLocal() as session:
            await session.execute(text("SELECT 1"))
        return {"status": "db_connected"}
    except Exception as e:
        logger.error(f"DB Connection Test Failed: {e}")
        return {"status": "error", "detail": str(e)}
