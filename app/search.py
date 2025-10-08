from datetime import datetime, timedelta, timezone
from fastapi import APIRouter, Query
from typing import Literal

router = APIRouter(prefix="/api/search", tags=["search"])

POSTED_WITHIN_MAP = {
    "24h": timedelta(days=1),
    "7d": timedelta(days=7),
    "30d": timedelta(days=30),
}

def get_cutoff_date(posted_within: str | None) -> datetime | None:
    if posted_within and posted_within in POSTED_WITHIN_MAP:
        return datetime.now(timezone.utc) - POSTED_WITHIN_MAP[posted_within]
    return None

# --- Mock Jobs Data ---
JOBS = [
    {
        "id": 1,
        "title": "Senior Python Developer (AI Focus)",
        "description": "Develop and maintain backend services with a focus on machine learning integration.",
        "location": "Cairo",
        "work_arrangement": "remote",
        "work_schedule": "fulltime",
        "salary": 150000, 
        "created_at": datetime.now(timezone.utc) - timedelta(days=2) # 2 days ago
    },
    {
        "id": 2,
        "title": "Junior Data Analyst",
        "description": "Clean, process, and analyze large datasets using SQL and Python.",
        "location": "Alexandria",
        "work_arrangement": "hybrid",
        "work_schedule": "fulltime",
        "salary": 65000, # 
        "created_at": datetime.now(timezone.utc) - timedelta(hours=10) # 10 hours ago
    },
    {
        "id": 3,
        "title": "Coffee Shop Barista",
        "description": "Prepare coffee, manage cash register, and provide customer service.",
        "location": "Giza",
        "work_arrangement": "on-site",
        "work_schedule": "parttime",
        "salary": 30000,
        "created_at": datetime.now(timezone.utc) - timedelta(days=45) # 45 days ago
    },
    {
        "id": 4,
        "title": "Freelance Web Designer",
        "description": "Design user-friendly and aesthetically pleasing websites for various clients.",
        "location": "Online",
        "work_arrangement": "remote",
        "work_schedule": "freelance",
        "salary": 90000,
        "created_at": datetime.now(timezone.utc) - timedelta(days=1) # 1 day ago 
    },
    {
        "id": 5,
        "title": "Resort Lifeguard",
        "description": "Ensure the safety of guests at the resort pool and beach area.",
        "location": "Sharm El Sheikh",
        "work_arrangement": "on-site",
        "work_schedule": "seasonal",
        "salary": 45000, 
        "created_at": datetime.now(timezone.utc) - timedelta(days=7) # 7 days ago
    },
    {
        "id": 6,
        "title": "Digital Marketing Manager",
        "description": "Lead digital campaigns, SEO, and social media strategy.",
        "location": "Cairo",
        "work_arrangement": "hybrid",
        "work_schedule": "fulltime",
        "salary": 110000,
        "created_at": datetime.now(timezone.utc) - timedelta(days=60) # 60 days ago
    },
    {
        "id": 7,
        "title": "Entry Level Administrative Assistant",
        "description": "Handle office tasks, including scheduling, correspondence, and filing.",
        "location": "Cairo",
        "work_arrangement": "on-site",
        "work_schedule": "fulltime",
        "salary": 40000, 
        "created_at": datetime.now(timezone.utc) - timedelta(days=3) # 3 days ago
    },
    {
        "id": 8,
        "title": "Senior React Developer",
        "description": "Build high-performance user interfaces using React and modern JavaScript.",
        "location": "Alexandria",
        "work_arrangement": "remote",
        "work_schedule": "fulltime",
        "salary": 140000, 
        "created_at": datetime.now(timezone.utc) - timedelta(days=15) # 15 days ago
    },
    {
        "id": 9,
        "title": "Part-Time Tutor (Math)",
        "description": "Provide after-school math tutoring for high school students.",
        "location": "Mansoura",
        "work_arrangement": "hybrid",
        "work_schedule": "parttime",
        "salary": 25000,
        "created_at": datetime.now(timezone.utc) - timedelta(days=5) # 5 days ago
    },
    {
        "id": 10,
        "title": "Construction Worker",
        "description": "General labor on commercial construction sites.",
        "location": "Suez",
        "work_arrangement": "on-site",
        "work_schedule": "seasonal",
        "salary": 55000,
        "created_at": datetime.now(timezone.utc) - timedelta(days=67) # 67 days ago
    },
    {
        "id": 11,
        "title": " Worker",
        "description": "General construction labor on commercial construction sites.",
        "location": "Suez",
        "work_arrangement": "on-site",
        "work_schedule": "seasonal",
        "salary": 55000,
        "created_at": datetime.now(timezone.utc) - timedelta(days=67) # 67 days ago
    }
]

@router.get("/jobs", summary="Search and Filter Job Listings")
def search_jobs(
    q: str = Query("", description="Keyword to search"),
    location: str | None = Query(None, description="Filter by job,location/city."),

    # Filtering (Work/Job Type)
    work_arrangement: Literal["remote", "hybrid", "on-site"] | None = Query(
        None, description="Filter by workplace arrangement."
    ),
    work_schedule: Literal["fulltime", "parttime", "freelance", "seasonal"] | None = Query(
        None, description="Filter by employment schedule/contract type."
    ),

    # Salary Range Filtering
    min_salary: int | None = Query(None, description="Minimum annual salary."),
    max_salary: int | None = Query(None, description="Maximum annual salary."),

    # Date Filtering 
    posted_within: Literal["24h", "7d", "30d"] | None = Query(
        None, description="Filter jobs posted within a time frame: 24h, 7d, 30d."
    ),

    # Sorting
    sort: Literal["relevance", "date_desc", "salary_desc", "salary_asc"] = Query(
        "relevance", description="Sorting criteria: relevance, date_desc (newest), salary_desc (highest), salary_asc (lowest)."
    ),
    limit: int = 20,
    offset: int = 0
):
    
    cutoff_date = get_cutoff_date(posted_within)
    q_lower = q.lower()
    
    # 1. Filtering Logic
    results = []
    for job in JOBS:
        # Keyword Search Filter
        searchable_text = job["title"] + " " + job["description"]
        if q and q_lower not in searchable_text.lower():
            continue

        # Location Filter
        if location and job["location"].lower() != location.lower():
            continue
        
        # Work Arrangement Filter
        if work_arrangement and job["work_arrangement"].lower() != work_arrangement.lower():
            continue

        # Work Schedule Filter
        if work_schedule and job["work_schedule"].lower() != work_schedule.lower():
            continue

        # Date Posted Filter
        if cutoff_date and job["created_at"] < cutoff_date:
            continue
            
        # Salary Range Filter
        if min_salary is not None and job["salary"] <= min_salary:
            continue
        if max_salary is not None and job["salary"] >= max_salary:
            continue

        results.append(job)

    # 2. Sorting Logic
    if sort == "date_desc":
        # Newest first
        results.sort(key=lambda j: j["created_at"], reverse=True)
    elif sort == "salary_desc":
        # Highest salary first
        results.sort(key=lambda j: j["salary"], reverse=True)
    elif sort == "salary_asc":
        # Lowest salary first
        results.sort(key=lambda j: j["salary"], reverse=False)
    else: # sort == "relevance"
        # Primary key: Keyword match in title
        # Secondary key: Creation date (newer is better)
        results.sort(
            key=lambda j: (q_lower in j["title"].lower(), j["created_at"]),
            reverse=True
        )

    # Pagination
    paginated = results[offset: offset + limit]

    return {"results": paginated, "count": len(results)}
