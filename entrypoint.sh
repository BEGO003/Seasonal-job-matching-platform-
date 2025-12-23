#!/bin/bash

# Enable robust error handling
set -e
export PYTHONUNBUFFERED=1

echo "=== STARTUP SCRIPT LAUNCHED ==="
echo "Checking environment variables..."
if [ -z "$DATABASE_URL" ]; then echo "WARNING: DATABASE_URL is not set!"; else echo "DATABASE_URL is set (length: ${#DATABASE_URL})"; fi
echo "PROD_DB_HOST is: ${PROD_DB_HOST:-'N/A'}"
echo "Current directory: $(pwd)"
ls -l /app

# 1. Start Python Recommender in the background
echo "Starting Python Uvicorn server..."
uvicorn app.main:app --host 0.0.0.0 --port 8000 --log-level info &
PYTHON_PID=$!

# Wait for Python to be ready
echo "Waiting for Python service to start on port 8000..."
# Simple retry loop (requires netcat/nc or curl, using sleep for simplicity if nc missing)
for i in {1..30}; do
  if (echo > /dev/tcp/127.0.0.1/8000) >/dev/null 2>&1; then
    echo "Python service is UP!"
    break
  fi
  echo "Waiting for Python... ($i/30)"
  sleep 2
done

# 2. Start Java Spring Boot Backend in the background
echo "Starting Java Application..."
java -Dserver.port=$PORT $JAVA_OPTS -jar /app/seasonaljobs.jar &
JAVA_PID=$!

# 3. Monitor Loop: Exit if either process dies
# wait -n waits for the *first* background job to finish
wait -n $PYTHON_PID $JAVA_PID

# If header reaches here, one process crashed
echo "CRITICAL: One of the services exited unexpectedly. Shutting down container."
exit 1
