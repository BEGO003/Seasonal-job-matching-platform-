# app/recommender/embeddings_index.py
from pathlib import Path
import pickle
import numpy as np
from typing import List, Tuple, Optional
from sentence_transformers import SentenceTransformer
from app.config import RECOMMENDER_CACHE_PATH, EMBEDDING_MODEL_NAME
import logging

try:
    import faiss
except Exception as exc:
    faiss = None
    logging.warning("FAISS not importable. Install faiss-cpu or request an hnswlib variant. Error: %s", exc)

CACHE_DIR = Path(RECOMMENDER_CACHE_PATH)
INDEX_PATH = CACHE_DIR / "faiss.index"
JOB_IDS_PATH = CACHE_DIR / "job_ids.pkl"
JOB_TEXTS_PATH = CACHE_DIR / "job_texts.pkl"
VECTORS_NPY = CACHE_DIR / "job_vectors.npy"

_model = None

def _get_model():
    global _model
    if _model is None:
        _model = SentenceTransformer(EMBEDDING_MODEL_NAME)
    return _model

def _ensure_cache_dir():
    CACHE_DIR.mkdir(parents=True, exist_ok=True)

async def build_index_from_texts(job_texts: List[str], job_ids: List[int]) -> dict:
    _ensure_cache_dir()
    if faiss is None:
        raise RuntimeError("faiss not available. Install faiss-cpu or request hnswlib variant.")

    if len(job_texts) == 0:
        with open(JOB_IDS_PATH, "wb") as f:
            pickle.dump([], f)
        np.save(VECTORS_NPY, np.zeros((0, 1)))
        return {"status": "empty"}

    model = _get_model()
    embs = model.encode(job_texts, convert_to_numpy=True, show_progress_bar=False)
    faiss.normalize_L2(embs)

    d = embs.shape[1]
    index = faiss.IndexFlatIP(d)
    index.add(embs)

    faiss.write_index(index, str(INDEX_PATH))
    with open(JOB_IDS_PATH, "wb") as f:
        pickle.dump(job_ids, f)
    with open(JOB_TEXTS_PATH, "wb") as f:
        pickle.dump(job_texts, f)
    np.save(VECTORS_NPY, embs)
    return {"status": "indexed", "count": len(job_ids)}

def load_index() -> Tuple[Optional[object], Optional[List[int]], Optional[List[str]]]:
    _ensure_cache_dir()
    if faiss is None:
        raise RuntimeError("faiss not available.")
    if not INDEX_PATH.exists() or not JOB_IDS_PATH.exists():
        return None, None, None
    index = faiss.read_index(str(INDEX_PATH))
    with open(JOB_IDS_PATH, "rb") as f:
        job_ids = pickle.load(f)
    job_texts = None
    if JOB_TEXTS_PATH.exists():
        with open(JOB_TEXTS_PATH, "rb") as f:
            job_texts = pickle.load(f)
    return index, job_ids, job_texts

def query_index(user_text: str, top_k: int = 50) -> Tuple[np.ndarray, np.ndarray]:
    if faiss is None:
        raise RuntimeError("faiss not available.")
    index, job_ids, job_texts = load_index()
    if index is None:
        return np.array([]), np.array([])
    model = _get_model()
    emb = model.encode([user_text], convert_to_numpy=True)
    faiss.normalize_L2(emb)
    D, I = index.search(emb, top_k)
    return D[0], I[0]
