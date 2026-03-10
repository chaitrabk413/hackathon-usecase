# Terraform Structure

This Terraform layout supports multiple environments and reusable modules.

## Folder Structure

- Terraform/bootstrap: Creates remote state bucket and lock table (S3 + DynamoDB)
- Terraform/environments/dev: Dev stack
- Terraform/environments/staging: Staging stack
- Terraform/environments/prod: Prod stack
- Terraform-modules/vpc: VPC with public/private subnets across 2 AZs
- Terraform-modules/security-group: Service security groups
- Terraform-modules/service-identity: IAM role + Secrets Manager secret per service
- Terraform-modules (root): Existing ECR module

## What gets provisioned per environment

- VPC with 2 public and 2 private subnets across 2 AZs
- Security groups for:
  - application-service
  - order-service
  - patient-service
- IAM roles for:
  - application-service
  - order-service
  - patient-service
- AWS Secrets Manager secrets for:
  - application-service
  - order-service
  - patient-service
- ECR repositories for the 3 services

## 1. Create remote backend resources first

```powershell
cd Terraform/bootstrap
terraform init
terraform apply
```

Use outputs from this step in each environment backend.hcl.

## 2. Deploy an environment

Example for dev:

```powershell
cd Terraform/environments/dev
terraform init -backend-config=backend.hcl
terraform plan -var-file=terraform.tfvars
terraform apply -var-file=terraform.tfvars
```

Repeat for staging and prod by changing folder path.

## Notes

- Update backend.hcl files with your real AWS account id in bucket name.
- Keep tfstate files remote in S3 and lock via DynamoDB.
- IAM role trust policy is currently generic service-principal based and can be tightened to IRSA/OIDC as needed.
