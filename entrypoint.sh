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
# Wait for Python to be ready
echo "Waiting for Python service to start on port 8000..."
for i in {1..30}; do
  # Check if port 8000 is open using netcat (installed in Dockerfile)
  if nc -z 127.0.0.1 8000; then
    echo "Python service is UP!"
    break
  fi
  echo "Waiting for Python... ($i/30)"
  sleep 2
done

# If loop finished but port still closed, warn but proceed (or exit)
if ! nc -z 127.0.0.1 8000; then
    echo "WARNING: Python service did not start within 60 seconds. Logs should appear above."
fi

# 2. Start Java Spring Boot Backend in the background
echo "Starting Java Application..."
java -Dserver.port=$PORT $JAVA_OPTS -jar /app/seasonaljobs.jar &
JAVA_PID=$!

# 3. Monitor Loop: Exit if either process dies
# wait without -n is standard POSIX (waits for all).
# To wait for *any*, we can use a loop or just wait.
# Since we want to exit if ONE dies, we can use a trap or just let them run.
# For simplicity in sh: just wait. If one dies, usually the container exits anyway if it was PID 1.
wait $PYTHON_PID $JAVA_PID

# If header reaches here, one process crashed
echo "CRITICAL: One of the services exited unexpectedly. Shutting down container."
exit 1
