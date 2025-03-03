#!/bin/bash
# Removes failed images from ECR

if [ $# -ne 2 ]; then
  echo "Usage: $0 <backend_tag> <frontend_tag>"
  exit 1
fi

BACKEND_TAG=$1
FRONTEND_TAG=$2

# Delete backend image
aws ecr batch-delete-image \
  --repository-name backend \
  --image-ids imageTag=$BACKEND_TAG

# Delete frontend image
aws ecr batch-delete-image \
  --repository-name frontend \
  --image-ids imageTag=$FRONTEND_TAG

echo "Failed images removed from ECR"