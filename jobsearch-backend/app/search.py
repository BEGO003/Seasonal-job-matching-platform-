from fastapi import APIRouter, Depends
from sqlalchemy.orm import Session
from . import database, schemas, crud, utils

router = APIRouter(prefix="/api", tags=["Search"])

@router.post("/jobs", response_model=list[schemas.JobResponse])
def search_jobs(filters: schemas.JobSearchFilters, db: Session = Depends(database.get_db)):
    cutoff = utils.get_cutoff_date(filters.posted_within)
    jobs = crud.search_jobs(db, filters, cutoff)
    return jobs
