#!/bin/bash
# User data script for test EC2 instance

# Update system packages
yum update -y

# Install required packages
yum install -y git jq

# Create app directory
mkdir -p /home/ec2-user/app
chown -R ec2-user:ec2-user /home/ec2-user/app

# Install AWS CLI
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
./aws/install

echo "EC2 instance setup complete"