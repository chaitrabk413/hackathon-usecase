# Overview
Welcome to the DevOps Hackathon Challenge! In this hackathon, you will demonstrate your skills in containerization, Infrastructure as Code (IaC), CI/CD, and cloud deployment using Azure / GCP services. You will be working with a simple healthcare application consisting of two microservices.

# Common Requirements
Regardless of the track you choose, you will be working with the following common elements:

## Microservices: 
You will be provided with two Node.js microservices - a Patient Service and an Appointment Service or Java based Microservice (order-service).
The code for these services can be found in the Sample Microservices Code file.

Order-service Java microservice.

## What we are looking for
### CI Pipeline
1. Build microservices on local
2. Build Docker images for each microservice
3. Create Kubernetes manifests using internal Helm templates
4. Push container images to GCR / ACR / ECR

### CD Deployment
1. Pull from GCR / ACR / ECR
2. Deploy on GKE / AKS / EKS

### Secrets
1. Integrate with Azure Key Vault / AWS Secrets Manager

For containerization use Docker, Terraform for IaC, and GitHub Actions / Azure DevOps / Jenkins for CI/CD pipelines.

### Monitoring and Logging: 
Set up basic monitoring and logging using cloud-native services (Azure Monitor / GCP / AWS) or equivalent open-source tooling.

### Containerization: 
Containerize all microservices using Docker.

### Infrastructure as Code (Terraform):

Set up a Terraform project structure supporting multiple environments (dev, staging, prod).
Provision the following Azure / GCP / AWS resources:
1. VPC/VNet with public and private subnets across two availability zones
2. IAM roles and security groups
3. Storage for Terraform state
4. State locking
5. Other resources specific to your selected cloud track

Terraform state management:
1. Implement remote state storage (Blob Storage / GCS / AWS S3)
2. Configure state locking
3. Configure workspace separation for dev, staging, and prod

### GitHub Actions / Azure DevOps for IaC:
Create workflows for:
1. CI/CD: Implement a CI/CD pipeline using GitHub Actions for your application code.
2. Terraform fmt and validate on all PRs
3. Terraform plan on pull requests
4. Terraform apply on merges to main branch
