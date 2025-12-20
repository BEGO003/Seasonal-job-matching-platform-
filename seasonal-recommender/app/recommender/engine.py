# app/recommender/engine.py
from typing import List, Tuple, Optional, Any
import json
import logging

from sqlalchemy import text, select
from sqlalchemy.ext.asyncio import AsyncSession

from app.recommender.utils import flatten_value_to_text, normalize_text
from app.recommender.embeddings_index import build_index_from_texts, load_index, query_index
from app.config import RECOMMENDER_MIN_SCORE, RECOMMENDER_TOP_N

logger = logging.getLogger(__name__)
logging.basicConfig(level=logging.INFO)


async def safe_execute_fetchall(session: AsyncSession, stmt) -> List[Any]:
    """
    Execute the statement and return list of Row objects (scalars() not used everywhere).
    On error, roll back the session and return empty list.
    """
    try:
        res = await session.execute(stmt)
        return res.fetchall()
    except Exception as e:
        logger.exception("DB fetchall failed: %s", e)
        try:
            await session.rollback()
        except Exception:
            logger.exception("Failed to rollback after fetchall error")
        return []


async def safe_execute_fetchone(session: AsyncSession, stmt, params: dict = None):
    """
    Execute statement and return one row or None. Rolls back on error.
    """
    try:
        if params:
            res = await session.execute(stmt, params)
        else:
            res = await session.execute(stmt)
        return res.fetchone()
    except Exception as e:
        logger.exception("DB fetchone failed: %s", e)
        try:
            await session.rollback()
        except Exception:
            logger.exception("Failed to rollback after fetchone error")
        return None


async def build_job_text_from_row(row_mapping: dict) -> str:
    parts = []
    # fields we usually want from jobs; allow both camelCase and snake_case in mapping
    fields = ("title", "description", "categories", "requirements", "benefits",
              "workArrangement", "work_arrangement", "location", "type", "duration", "amount", "salary")
    for k in fields:
        if k in row_mapping and row_mapping.get(k) is not None:
            parts.append(flatten_value_to_text(row_mapping.get(k)))
    # fallback: include any textual fields
    if not parts:
        for k, v in row_mapping.items():
            if isinstance(v, str) and len(v.strip()) > 0:
                parts.append(v)
    return normalize_text(" ".join(parts))


async def build_index(session: AsyncSession) -> dict:
    """
    Build the text index for all jobs. Returns whatever build_index_from_texts returns.
    This uses safe DB helpers to avoid leaving the session in an aborted state.
    """
    q = text("SELECT * FROM jobs")
    rows = await safe_execute_fetchall(session, q)
    job_texts: List[str] = []
    job_ids: List[int] = []
    for r in rows:
        try:
            m = r._mapping
            jt = await build_job_text_from_row(m)
            job_texts.append(jt or str(m.get("title") or ""))
            job_ids.append(int(m.get("id")))
        except Exception as e:
            logger.exception("Error processing job row while building index: %s", e)
            continue
    res = await build_index_from_texts(job_texts, job_ids)
    return res


async def build_user_profile(session: AsyncSession, user_id: int) -> str:
    """
    Build a textual profile for a user from users/resumes/favorites/jobapplication
    Uses safe helpers and is resilient to schema variations.
    """
    q = text("SELECT * FROM users WHERE id = :uid")
    row = await safe_execute_fetchone(session, q, {"uid": user_id})
    if not row:
        return ""
    m = row._mapping
    parts: List[str] = []

    # fields of interest
    for cand in ("fieldsOfInterest", "fields_of_interest", "fields", "interests"):
        if cand in m and m.get(cand):
            parts.append(flatten_value_to_text(m.get(cand)))
            break

    # skills
    for cand in ("skills", "skillset", "skills_list"):
        if cand in m and m.get(cand):
            parts.append(flatten_value_to_text(m.get(cand)))
            break

    # resume: either id in users.resume or a resume row linked by user_id
    try:
        resume_val = None
        if "resume" in m and m.get("resume"):
            resume_val = m.get("resume")
        if resume_val:
            # if it's an id
            try:
                rid = int(resume_val)
                qres = text("SELECT * FROM resumes WHERE id = :rid")
                rres = await safe_execute_fetchone(session, qres, {"rid": rid})
                if rres:
                    rm = rres._mapping
                    for f in ("skills", "experience", "education", "certificates", "languages"):
                        if f in rm and rm.get(f):
                            parts.append(flatten_value_to_text(rm.get(f)))
            except Exception:
                # if resume is a json/string blob, flatten it
                parts.append(flatten_value_to_text(resume_val))
        else:
            # try to find resume by user_id
            qres2 = text("SELECT * FROM resumes WHERE user_id = :uid LIMIT 1")
            rr2 = await safe_execute_fetchone(session, qres2, {"uid": user_id})
            if rr2:
                rm = rr2._mapping
                for f in ("skills", "experience", "education", "certificates", "languages"):
                    if f in rm and rm.get(f):
                        parts.append(flatten_value_to_text(rm.get(f)))
    except Exception:
        logger.exception("Error while fetching resume data")

    # favorite jobs enrichment (robust parsing)
    fav_cands = ("favoriteJobs", "favorite_jobs", "favoritejobids", "favoritejobids", "favoritejobs")
    fav_ids = None
    for cand in fav_cands:
        if cand in m and m.get(cand):
            val = m.get(cand)
            try:
                if isinstance(val, (list, tuple)):
                    fav_ids = [int(x) for x in val if x is not None]
                elif isinstance(val, int):
                    fav_ids = [int(val)]
                elif isinstance(val, str):
                    s = val.strip()
                    if s.startswith("[") and s.endswith("]"):
                        parsed = json.loads(s)
                        if isinstance(parsed, (list, tuple)):
                            fav_ids = [int(x) for x in parsed if x is not None]
                    else:
                        fav_ids = [int(x.strip()) for x in s.split(",") if x.strip().isdigit()]
            except Exception:
                logger.exception("Failed to parse favorite ids value: %r", val)
            break

    if fav_ids:
        try:
            # safe: if fav_ids is short, use IN
            placeholders = ", ".join(str(int(x)) for x in fav_ids)
            qj = text(f"SELECT * FROM jobs WHERE id IN ({placeholders})")
            fjobs = await safe_execute_fetchall(session, qj)
            for fj in fjobs:
                fm = fj._mapping
                if fm.get("title"):
                    parts.append(flatten_value_to_text(fm.get("title")))
                if fm.get("description"):
                    parts.append(flatten_value_to_text(fm.get("description")))
        except Exception:
            logger.exception("Error enriching profile from favorite jobs")

    # recently applied jobs enrichment (last 5)
    try:
        # jobapplication table columns might be jobid/JobID/job_id - try common names
        qapp = text("SELECT jobid FROM jobapplication WHERE userid = :uid ORDER BY createdat DESC LIMIT 5")
        rows = await safe_execute_fetchall(session, qapp, )
        # fallback: try lowercase column names or different table name variations if empty
        if not rows:
            # attempt alternate column names
            qapp_alt = text("SELECT job_id FROM jobapplication WHERE user_id = :uid ORDER BY createdat DESC LIMIT 5")
            rows = await safe_execute_fetchall(session, qapp_alt)
        if rows:
            ids = []
            for r in rows:
                # row might be a Row object where index 0 contains id
                try:
                    val = r[0]
                    if val is not None:
                        ids.append(int(val))
                except Exception:
                    try:
                        mapping = getattr(r, "_mapping", None)
                        if mapping:
                            for key in ("jobid", "job_id", "jobID"):
                                if key in mapping and mapping.get(key) is not None:
                                    ids.append(int(mapping.get(key)))
                                    break
                    except Exception:
                        pass
            if ids:
                placeholders = ", ".join(str(int(x)) for x in ids)
                qj = text(f"SELECT * FROM jobs WHERE id IN ({placeholders})")
                aj = await safe_execute_fetchall(session, qj)
                for a in aj:
                    am = a._mapping
                    if am.get("title"):
                        parts.append(flatten_value_to_text(am.get("title")))
                    if am.get("description"):
                        parts.append(flatten_value_to_text(am.get("description")))
    except Exception:
        logger.exception("Error enriching profile from jobapplication")

    # fallback: use user name if nothing else
    if not parts:
        for name_cand in ("name", "full_name", "username"):
            if name_cand in m and m.get(name_cand):
                parts.append(str(m.get(name_cand)))
                break

    profile = " ".join([p for p in parts if p]).strip()
    return normalize_text(profile)


async def recommend_for_user(session: AsyncSession, user_id: int, top_n: Optional[int] = None) -> List[Tuple[int, float]]:
    """
    Return top-N (job_id, score) using the loaded index. Filters out zero/low similarity.
    """
    if top_n is None:
        top_n = RECOMMENDER_TOP_N

    # load existing index (embedding index module should return (index, job_ids, job_texts))
    try:
        idx, job_ids, job_texts = load_index()
    except Exception as e:
        logger.exception("Failed to load index: %s", e)
        idx = None
        job_ids = None
        job_texts = None

    if idx is None:
        # build it if missing
        await build_index(session)
        idx, job_ids, job_texts = load_index()
        if idx is None:
            logger.warning("Index still missing after build_index")
            return []

    user_text = await build_user_profile(session, user_id)
    if not user_text:
        logger.info("No profile text for user %s; returning empty", user_id)
        return []

    try:
        D, I = query_index(user_text, top_k=50)
    except Exception as e:
        logger.exception("Error querying embedding index: %s", e)
        return []

    # D = distances/scores, I = indices
    if D is None or I is None or D.size == 0:
        return []

    candidates = []
    # D and I might be shaped (1, k)
    try:
        scores = D.flatten().tolist()
        inds = I.flatten().tolist()
    except Exception:
        scores = D.tolist()
        inds = I.tolist()

    for score, idxi in zip(scores, inds):
        try:
            if idxi is None or idxi < 0:
                continue
            if score is None:
                continue
            # filter out below min score or zero
            if score <= RECOMMENDER_MIN_SCORE:
                continue
            job_id = int(job_ids[int(idxi)])
            candidates.append((job_id, float(score)))
        except Exception:
            logger.exception("Error mapping index->job_id for idx %s", idxi)
            continue

    candidates.sort(key=lambda x: -x[1])
    return candidates[:top_n]


# helper: safe fetch jobs by ids (used by some endpoints)
async def fetch_jobs_by_ids(session: AsyncSession, ids: List[int]):
    if not ids:
        return []
    try:
        placeholders = ", ".join(str(int(i)) for i in ids)
        q = text(f"SELECT * FROM jobs WHERE id IN ({placeholders})")
        # use the safe helper that rolls back on error
        rows = await safe_execute_fetchall(session, q)
        out = []
        for r in rows:
            try:
                m = r._mapping
                out.append({
                    "id": int(m.get("id")),
                    "title": m.get("title"),
                    "description": m.get("description"),
                    "categories": m.get("categories"),
                    "requirements": m.get("requirements"),
                    "benefits": m.get("benefits"),
                    "location": m.get("location")
                })
            except Exception:
                logger.exception("Error converting job row to dict")
                continue
        return out
    except Exception as e:
        logger.exception("fetch_jobs_by_ids failed: %s", e)
        try:
            await session.rollback()
        except Exception:
            pass
        return []