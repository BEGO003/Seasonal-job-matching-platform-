from sqlalchemy.orm import Session
from sqlalchemy import and_
from . import models, schemas
from datetime import datetime

def search_jobs(db: Session, filters: schemas.JobSearchFilters, cutoff: datetime | None):
    query = db.query(models.Job)

    if filters.location:
        query = query.filter(models.Job.location.ilike(f"%{filters.location}%"))
    if filters.work_arrangement:
        query = query.filter(models.Job.work_arrangement.ilike(f"%{filters.work_arrangement}%"))
    if filters.salary_min:
        query = query.filter(models.Job.salary >= filters.salary_min)
    if filters.salary_max:
        query = query.filter(models.Job.salary <= filters.salary_max)
    if filters.skills:
        query = query.filter(models.Job.skills.ilike(f"%{filters.skills}%"))
    if cutoff:
        query = query.filter(models.Job.posted_date >= cutoff)

    return query.all()
