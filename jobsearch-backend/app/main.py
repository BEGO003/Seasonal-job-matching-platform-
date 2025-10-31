from fastapi import FastAPI
from app import database, models, search 

# Create the FastAPI app
app = FastAPI(title="Job Search API")

# Create database tables automatically
models.Base.metadata.create_all(bind=database.engine)

# Include the search router
app.include_router(search.router)

@app.get("/")
def root():
    return {"message": "Welcome to the Job Search API"}
