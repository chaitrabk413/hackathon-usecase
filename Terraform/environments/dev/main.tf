terraform {
  required_version = ">= 1.5.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.0"
    }
  }

  backend "s3" {}
}

provider "aws" {
  region = var.aws_region
}

locals {
  common_tags = {
    Project     = "hackathon-usecase"
    Environment = var.environment
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

  service_config = {
    application-service = {
      port = 3001
      secret_values = {
        NODE_ENV = var.environment
      }
    }
    order-service = {
      port = 8080
      secret_values = {
        SPRING_PROFILES_ACTIVE = var.environment
      }
    }
    patient-service = {
      port = 3000
      secret_values = {
        NODE_ENV = var.environment
      }
    }
  }
}

module "network" {
  source = "../../../Terraform-modules/vpc"

  name                 = "hackathon-${var.environment}"
  vpc_cidr             = var.vpc_cidr
  azs                  = var.azs
  public_subnet_cidrs  = var.public_subnet_cidrs
  private_subnet_cidrs = var.private_subnet_cidrs
  create_nat_gateway   = true
  tags                 = local.common_tags
}

module "ecr_repositories" {
  source = "../../../Terraform-modules"

  environment  = var.environment
  tags         = local.common_tags
  repositories = local.repositories
}

module "service_identities" {
  for_each = local.service_config
  source   = "../../../Terraform-modules/service-identity"

  service_name  = each.key
  environment   = var.environment
  secret_values = each.value.secret_values
  tags          = local.common_tags
}

module "service_security_groups" {
  for_each = local.service_config
  source   = "../../../Terraform-modules/security-group"

  name                = "${each.key}-${var.environment}-sg"
  vpc_id              = module.network.vpc_id
  service_port        = each.value.port
  allowed_cidr_blocks = var.allowed_ingress_cidrs
  tags                = local.common_tags
}
