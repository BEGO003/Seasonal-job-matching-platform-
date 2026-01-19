# app/api/endpoints.py
from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.ext.asyncio import AsyncSession
from sqlalchemy import text
from fastapi.responses import JSONResponse

from ..db import get_session
from ..recommender_engine import (
    build_index,
    recommend_for_user,
    fetch_jobs_by_ids,
    build_user_profile,
)


router = APIRouter()

@router.post("/admin/index", summary="(Admin) Build or rebuild FAISS index")
async def admin_index(session: AsyncSession = Depends(get_session)):
    res = await build_index(session)
    return JSONResponse(res)

@router.get("/recommend/{user_id}", summary="Get recommendations for a user")
async def api_recommend(user_id: int, n: int = 5, session: AsyncSession = Depends(get_session)):
    recs = await recommend_for_user(session, user_id, top_n=n)
    if not recs:
        return {"user_id": user_id, "recommendations": []}
    ids = [r[0] for r in recs]
    jobs = await fetch_jobs_by_ids(session, ids)
    score_map = {r[0]: r[1] for r in recs}
    out = []
    for j in jobs:
        out.append({
            "id": j.get("id"),
            "title": j.get("title"),
            "description": j.get("description"),
            "score": round(score_map.get(j.get("id"), 0.0), 4)
        })
    out_sorted = sorted(out, key=lambda x: -x["score"])
    return {"user_id": user_id, "recommendations": out_sorted}

@router.get("/jobs/{job_id}", summary="Get job details")
async def get_job(job_id: int, session: AsyncSession = Depends(get_session)):
    q = text("SELECT * FROM jobs WHERE id = :jid")
    res = await session.execute(q, {"jid": job_id})
    row = res.fetchone()
    if not row:
        raise HTTPException(status_code=404, detail="Job not found")
    m = row._mapping
    return {
        "id": int(m.get("id")),
        "title": m.get("title"),
        "description": m.get("description"),
        "categories": m.get("categories"),
        "requirements": m.get("requirements"),
        "benefits": m.get("benefits"),
        "location": m.get("location"),
    }

@router.get("/admin/debug_user_profile/{user_id}")
async def debug_user_profile(user_id: int, session: AsyncSession = Depends(get_session)):
    text_profile = await build_user_profile(session, user_id)
    return {"user_id": user_id, "profile_text": text_profile}
