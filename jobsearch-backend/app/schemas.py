from pydantic import BaseModel
from datetime import datetime
from typing import Optional

# For incoming search filters
class JobSearchFilters(BaseModel):
    location: Optional[str] = None
    work_arrangement: Optional[str] = None
    salary_min: Optional[float] = None
    salary_max: Optional[float] = None
    skills: Optional[str] = None
    posted_within: Optional[str] = None  # '7d', '30d', etc.

# For outgoing response
class JobResponse(BaseModel):
    id: int
    title: str
    company: str
    location: str
    work_arrangement: str
    salary: float
    skills: str
    posted_date: datetime

    class Config:
        orm_mode = True
