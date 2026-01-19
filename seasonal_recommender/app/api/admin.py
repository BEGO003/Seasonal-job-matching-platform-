# app/api/admin.py
from fastapi import APIRouter, Depends
from sqlalchemy.ext.asyncio import AsyncSession
from app.db import get_session
# these functions should exist in your recommender module; adjust names if different
from app.recommender.engine import build_index as rebuild_job_index, build_user_profile

admin_router = APIRouter(prefix="/admin", tags=["Admin"])

@admin_router.post("/reindex_jobs")
async def reindex_jobs(session: AsyncSession = Depends(get_session)):
    """
    Rebuild the job index (one-time / admin use).
    Returns the number of indexed jobs or a status dict.
    """
    res = await rebuild_job_index(session)
    # rebuild_job_index in our earlier code returns dict like {"status": "indexed", "count": N}
    if isinstance(res, dict) and "count" in res:
        return {"status": "ok", "indexed_jobs": int(res["count"])}
    return res

@admin_router.get("/debug_user_profile/{user_id}")
async def debug_user_profile(user_id: int, session: AsyncSession = Depends(get_session)):
    profile = await build_user_profile(session, user_id)
    return {"user_id": user_id, "profile_text": profile}
