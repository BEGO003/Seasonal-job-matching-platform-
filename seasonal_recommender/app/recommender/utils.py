# app/recommender/utils.py
import json
import re
from typing import Any

def flatten_value_to_text(v: Any) -> str:
    if v is None:
        return ""
    if isinstance(v, (list, tuple)):
        return " ".join([flatten_value_to_text(x) for x in v if x is not None])
    if isinstance(v, dict):
        parts = []
        for k, val in v.items():
            parts.append(str(k))
            parts.append(flatten_value_to_text(val))
        return " ".join(parts)
    if isinstance(v, str):
        s = v.strip()
        if (s.startswith("[") and s.endswith("]")) or (s.startswith("{") and s.endswith("}")):
            try:
                parsed = json.loads(s)
                return flatten_value_to_text(parsed)
            except Exception:
                pass
        return s
    return str(v)

def normalize_text(s: str) -> str:
    if not s:
        return ""
    s = re.sub(r"\s+", " ", s)
    return s.strip()
