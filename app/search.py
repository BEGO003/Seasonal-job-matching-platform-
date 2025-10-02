from datetime import datetime, timedelta, timezone
from fastapi import APIRouter, Query

router = APIRouter(prefix="/api/search", tags=["search"])

# Mock jobs (for testing before DB)
JOBS = [
    {
        "id": 1,
        "title": "Barista",
        "description": "Prepare coffee and manage counter",
        "location": "Cairo",
        "job_type": "seasonal",
        "created_at": datetime.now(timezone.utc) - timedelta(days=1)
    },
    {
        "id": 2,
        "title": "Lifeguard",
        "description": "Monitor beach swimmers",
        "location": "Alexandria",
        "job_type": "seasonal",
        "created_at": datetime.now(timezone.utc) - timedelta(days=3)
    },
    {
        "id": 3,
        "title": "Backend Developer",
        "description": "Build APIs with FastAPI",
        "location": "Cairo",
        "job_type": "fulltime",
        "created_at": datetime.now(timezone.utc) - timedelta(days=5)
    }
]

def get_since(date_posted: str | None):
    now = datetime.now(timezone.utc)
    if date_posted == "last_24_hours":
        return now - timedelta(days=1)
    if date_posted == "last_7_days":
        return now - timedelta(days=7)
    if date_posted == "last_30_days":
        return now - timedelta(days=30)
    return None

@router.get("/jobs")
def search_jobs(
    q: str = Query(..., description="Keyword to search"),
    location: str | None = None,
    job_type: str | None = None,
    date_posted: str | None = None,
    sort: str = Query("relevance", description="relevance|date"),
    limit: int = 20,
    offset: int = 0
):
    since = get_since(date_posted)

    results = []
    for job in JOBS:
        if q.lower() not in (job["title"] + " " + job["description"]).lower():
            continue
        if location and job["location"].lower() != location.lower():
            continue
        if job_type and job["job_type"].lower() != job_type.lower():
            continue
        if since and job["created_at"] < since:
            continue
        results.append(job)

    if sort == "date":
        results.sort(key=lambda j: j["created_at"], reverse=True)
    else:
        results.sort(
            key=lambda j: (q.lower() in j["title"].lower(), j["created_at"]),
            reverse=True
        )

    paginated = results[offset: offset + limit]

    return {"results": paginated, "count": len(results)}
