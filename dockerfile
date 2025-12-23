# =======================
# 1) JAVA BUILD STAGE
# =======================
FROM maven:3.9.9-eclipse-temurin-17 AS java-build
WORKDIR /build

COPY Backend/seasonal_job_matching/pom.xml .
RUN mvn -B dependency:go-offline

COPY Backend/seasonal_job_matching .
RUN mvn -B clean package -DskipTests


# =======================
# 2) RUNTIME (PYTHON + JAVA)
# =======================
FROM python:3.10-slim

ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1

WORKDIR /app

# ---- system deps (python + postgres + java) ----
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        build-essential \
        gcc \
        libpq-dev \
        curl \
        openjdk-17-jre-headless \
    && rm -rf /var/lib/apt/lists/*

# =======================
# PYTHON SETUP
# =======================
COPY seasonal-recommender/requirements.txt /app/requirements.txt
RUN pip install --upgrade pip \
    && pip install --no-cache-dir -r /app/requirements.txt

COPY seasonal-recommender /app

RUN mkdir -p /app/app/cache
ENV RECOMMENDER_CACHE_PATH=/app/app/cache

# =======================
# JAVA APP
# =======================
COPY --from=java-build /build/target/*.jar /app/seasonaljobs.jar

# =======================
# START BOTH SERVICES
# =======================
# Python: internal (8000)
# Java: public (PORT from Heroku)
CMD sh -c "uvicorn app.main:app --host 0.0.0.0 --port 8000 & \
           java -Dserver.port=$PORT $JAVA_OPTS -jar /app/seasonaljobs.jar"
