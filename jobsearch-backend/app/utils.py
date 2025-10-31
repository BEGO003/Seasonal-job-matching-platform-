from datetime import datetime, timedelta

def get_cutoff_date(posted_within: str | None):
    """
    Converts strings like '7d', '30d' into a cutoff datetime object.
    Example: '7d' → today - 7 days.
    """
    if not posted_within:
        return None

    try:
        days = int(posted_within.replace("d", ""))
        return datetime.utcnow() - timedelta(days=days)
    except ValueError:
        return None
