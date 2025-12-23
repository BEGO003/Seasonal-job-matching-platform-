#!/bin/bash

# Enable robust error handling
set -e

echo "=== STARTUP SCRIPT LAUNCHED ==="

# 1. Start Python Recommender in the background
echo "Starting Python Uvicorn server..."
uvicorn app.main:app --host 0.0.0.0 --port 8000 --log-level info &
PYTHON_PID=$!

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
