#!/bin/bash
# Logs into ECR

AWS_REGION=${1:-us-east-1}

# Get ECR authentication token and login
aws ecr get-login-password --region $AWS_REGION | docker login --username AWS --password-stdin $ECR_REGISTRY

echo "Successfully logged into ECR"