# CI/CD Pipeline

This repository contains a CI/CD pipeline that automates the building, testing, and deployment of a Spring Boot and Angular-based application. The pipeline is implemented using GitHub Actions and AWS services.

## Features
- **Automatic Builds**: Scheduled nightly builds.
- **Manual Trigger**: Supports workflow dispatch with optional smoke testing.
- **AWS Integration**: Configures AWS credentials and deploys images to Amazon ECR.
- **Dockerized Deployment**: Uses Docker to build, tag, and push images.
- **EC2-Based Smoke Testing**: Deploys the application to a temporary EC2 instance for validation.

## Workflow Triggers
The pipeline is triggered by:
- **Scheduled Builds**: Runs every night at midnight (`cron: '0 0 * * *'`).
- **Manual Execution**: Can be manually triggered via GitHub Actions with an option to enable or disable smoke tests.

## Environment Variables
The following environment variables are required for the pipeline:
- `ECR_REGISTRY`: Amazon Elastic Container Registry.
- `AWS_REGION`: AWS region for deployment.
- `AWS_ACCESS_KEY_ID`: AWS access key.
- `AWS_SECRET_ACCESS_KEY`: AWS secret key.
- `AWS_SESSION_TOKEN`: AWS session token.
- `PAT_TOKEN`: GitHub Personal Access Token.
- `EC2_SSH_KEY`: SSH key for EC2 instance.
- `EC2_KEY_NAME`: Key name for EC2.
- `TEST_SG_ID`: Security group ID for test instance.
- `PUBLIC_SUBNET_ID`: Subnet ID for test instance.
- `QA_EC2_IP`: IP of the QA EC2 instance.

## Jobs Overview
### 1. Build
- Checks out the repository.
- Configures AWS credentials.
- Logs into Amazon ECR.
- Determines appropriate image tags.
- Builds and tags Docker images for backend and frontend.
- Pushes images to ECR.

### 2. Smoke Test (Optional)
- Deploys a temporary EC2 instance.
- Configures SSH and installs dependencies.
- Launches the application using `docker-compose`.
- Runs health checks for backend and frontend.
- Reports success or failure.

## Deployment Process
1. **Build & Push Docker Images**
   - Docker images are built for backend and frontend applications.
   - Tagged images are pushed to Amazon ECR.
   
2. **Smoke Testing on EC2**
   - A temporary EC2 instance is launched.
   - The application is deployed using `docker-compose`.
   - Health checks are performed.
   - If successful, the build passes; otherwise, the instance logs errors and exits.

## How to Manually Trigger the Workflow
To manually trigger the workflow:
1. Navigate to GitHub Actions.
2. Select the **CI/CD Pipeline** workflow.
3. Click **Run workflow**.
4. Toggle the `run_tests` option to enable or disable smoke tests.

## Expected Output
- **Success**: Images are built, tested, and deployed successfully.
- **Failure**: Logs are available in the GitHub Actions UI to diagnose issues.

## Dependencies
- **GitHub Actions**: Automates the CI/CD process.
- **Docker**: Used for containerizing applications.
- **AWS CLI**: Required for ECR authentication and EC2 management.
- **EC2 Instance**: Used for smoke testing.
- **Amazon ECR**: Stores Docker images.

## Troubleshooting
- Check the logs in GitHub Actions for any errors.
- Ensure AWS credentials are correctly configured.
- Verify that the required environment variables are set.
- Ensure that the EC2 instance has sufficient permissions.

## Contributing
Contributions are welcome! Feel free to open an issue or submit a pull request.

## License
This project is licensed under the MIT License.

