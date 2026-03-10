terraform {
  required_version = ">= 1.5.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.0"
    }
  }
}

provider "aws" {
  region = var.aws_region
}

variable "aws_region" {
  description = "AWS region for creating ECR repositories"
  type        = string
  default     = "us-east-1"
}

module "ecr_repositories_dev" {
  source = "../Terraform-modules"

  environment = "dev"

  tags = {
    Project     = "hackathon-usecase"
    Environment = "dev"
    ManagedBy   = "terraform"
  }

  repositories = {
    "hackathon-application-service" = {
      image_tag_mutability           = "MUTABLE"
      scan_on_push                   = true
      force_delete                   = false
      tagged_image_retention_count   = 30
      untagged_image_retention_count = 10
    }
    "hackathon-order-service" = {
      image_tag_mutability           = "MUTABLE"
      scan_on_push                   = true
      force_delete                   = false
      tagged_image_retention_count   = 30
      untagged_image_retention_count = 10
    }
    "hackathon-patient-service" = {
      image_tag_mutability           = "MUTABLE"
      scan_on_push                   = true
      force_delete                   = false
      tagged_image_retention_count   = 30
      untagged_image_retention_count = 10
    }
  }
}

output "repository_urls" {
  description = "ECR repository URLs for dev"
  value       = module.ecr_repositories_dev.repository_urls
}

output "repository_arns" {
  description = "ECR repository ARNs for dev"
  value       = module.ecr_repositories_dev.repository_arns
}
