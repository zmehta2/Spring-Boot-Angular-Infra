#!/bin/bash

AWS_REGION=${1:-us-east-1}
ECR_REGISTRY=$(aws sts get-caller-identity --query 'Account' --output text).dkr.ecr.$AWS_REGION.amazonaws.com

# Get ECR authentication token and login
aws ecr get-login-password --region $AWS_REGION | docker login --username AWS --password-stdin $ECR_REGISTRY

echo "Successfully logged into ECR"