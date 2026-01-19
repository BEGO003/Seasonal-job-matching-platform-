# app/main.py
from fastapi import FastAPI
from .app.endpoints import router as api_router

# import admin router (create file if it doesn't exist)
try:
    from .app.admin import admin_router
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
    return {"status": "ok", "message": "Recommender service running"}


