from sqlalchemy import Column, Integer, String, Float, DateTime
from .database import Base
from datetime import datetime

class Job(Base):
    __tablename__ = "jobs"

    id = Column(Integer, primary_key=True, index=True)
    title = Column(String, index=True)
    company = Column(String)
    location = Column(String)
    work_arrangement = Column(String)   # e.g. Remote, On-site, Hybrid
    salary = Column(Float)
    skills = Column(String)             # comma-separated string
    posted_date = Column(DateTime, default=datetime.utcnow)
