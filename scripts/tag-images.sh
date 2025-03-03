#!/bin/bash
# Tags images as QA-ready if tests pass

if [ $# -ne 2 ]; then
  echo "Usage: $0 <backend_tag> <frontend_tag>"
  exit 1
fi

BACKEND_TAG=$1
FRONTEND_TAG=$2
ECR_REGISTRY=${ECR_REGISTRY:-"your-account-id.dkr.ecr.region.amazonaws.com"}

# Tag backend image as QA-ready
aws ecr batch-get-image \
  --repository-name backend \
  --image-ids imageTag=$BACKEND_TAG \
  --query 'images[].imageManifest' \
  --output text | aws ecr put-image \
  --repository-name backend \
  --image-tag QA-ready \
  --image-manifest -

# Tag frontend image as QA-ready
aws ecr batch-get-image \
  --repository-name frontend \
  --image-ids imageTag=$FRONTEND_TAG \
  --query 'images[].imageManifest' \
  --output text | aws ecr put-image \
  --repository-name frontend \
  --image-tag QA-ready \
  --image-manifest -

# Also tag with specific QA version for traceability
QA_VERSION="qa-$(date +%Y%m%d)-$BACKEND_TAG"
aws ecr batch-get-image \
  --repository-name backend \
  --image-ids imageTag=$BACKEND_TAG \
  --query 'images[].imageManifest' \
  --output text | aws ecr put-image \
  --repository-name backend \
  --image-tag $QA_VERSION \
  --image-manifest -

aws ecr batch-get-image \
  --repository-name frontend \
  --image-ids imageTag=$FRONTEND_TAG \
  --query 'images[].imageManifest' \
  --output text | aws ecr put-image \
  --repository-name frontend \
  --image-tag $QA_VERSION \
  --image-manifest -

echo "Images successfully tagged as QA-ready and $QA_VERSION"