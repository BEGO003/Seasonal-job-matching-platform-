from fastapi import FastAPI
from .search import router as search_router

app = FastAPI(title="Job Search API")

@app.get("/health")
def health_check():
    return {"status": "ok"}

# include the search endpoints
app.include_router(search_router)
