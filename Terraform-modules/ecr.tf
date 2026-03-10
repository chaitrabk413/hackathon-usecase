terraform {
  required_version = ">= 1.5.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.0"
    }
  }
}

variable "environment" {
  description = "Environment name used in tags"
  type        = string
}

variable "tags" {
  description = "Common tags to apply to all repositories"
  type        = map(string)
  default     = {}
}

variable "repositories" {
  description = "Map of ECR repositories to create"
  type = map(object({
    image_tag_mutability           = optional(string, "MUTABLE")
    scan_on_push                   = optional(bool, true)
    force_delete                   = optional(bool, false)
    create_lifecycle_policy        = optional(bool, true)
    tagged_image_retention_count   = optional(number, 30)
    untagged_image_retention_count = optional(number, 10)
  }))
}

module "ecr" {
  for_each = var.repositories

  source  = "terraform-aws-modules/ecr/aws"
  version = "~> 2.0"

  repository_name                 = each.key
  repository_type                 = "private"
  repository_image_tag_mutability = each.value.image_tag_mutability
  repository_image_scan_on_push   = each.value.scan_on_push
  repository_force_delete         = each.value.force_delete

  create_lifecycle_policy = each.value.create_lifecycle_policy
  repository_lifecycle_policy = jsonencode({
    rules = [
      {
        rulePriority = 1
        description  = "Retain only recent tagged images"
        selection = {
          tagStatus     = "tagged"
          tagPrefixList = ["v", "release", "latest"]
          countType     = "imageCountMoreThan"
          countNumber   = each.value.tagged_image_retention_count
        }
        action = {
          type = "expire"
        }
      },
      {
        rulePriority = 2
        description  = "Retain only recent untagged images"
        selection = {
          tagStatus   = "untagged"
          countType   = "imageCountMoreThan"
          countNumber = each.value.untagged_image_retention_count
        }
        action = {
          type = "expire"
        }
      }
    ]
  })

  tags = merge(var.tags, {
    Environment = var.environment
    Repository  = each.key
  })
}

output "repository_urls" {
  description = "Repository URLs keyed by repository name"
  value = {
    for name, repo in module.ecr :
    name => repo.repository_url
  }
}

output "repository_arns" {
  description = "Repository ARNs keyed by repository name"
  value = {
    for name, repo in module.ecr :
    name => repo.repository_arn
  }
}
