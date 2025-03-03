#!/bin/bash
# Runs smoke tests on temporary EC2 instance

# Wait for services to start
echo "Waiting for services to start..."
sleep 20

# Test backend API
echo "Testing backend API..."
BACKEND_STATUS=$(curl -s -o /dev/null -w "%{http_code}" http://localhost:8080/api/employees)

if [[ "$BACKEND_STATUS" -ne 200 ]]; then
  echo "Backend test failed with status $BACKEND_STATUS"
  exit 1
fi

# Test frontend
echo "Testing frontend..."
FRONTEND_STATUS=$(curl -s -o /dev/null -w "%{http_code}" http://localhost:80)

if [[ "$FRONTEND_STATUS" -ne 200 ]]; then
  echo "Frontend test failed with status $FRONTEND_STATUS"
  exit 1
fi

echo "All tests passed successfully!"
exit 0