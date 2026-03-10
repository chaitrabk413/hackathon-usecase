output "vpc_id" {
  description = "VPC id"
  value       = module.network.vpc_id
}

output "public_subnet_ids" {
  description = "Public subnet ids"
  value       = module.network.public_subnet_ids
}

output "private_subnet_ids" {
  description = "Private subnet ids"
  value       = module.network.private_subnet_ids
}

output "ecr_repository_urls" {
  description = "ECR repository URLs"
  value       = module.ecr_repositories.repository_urls
}

output "service_role_arns" {
  description = "IAM role arns per service"
  value = {
    for k, v in module.service_identities :
    k => v.role_arn
  }
}

output "service_secret_arns" {
  description = "Secrets Manager arns per service"
  value = {
    for k, v in module.service_identities :
    k => v.secret_arn
  }
}

output "service_security_group_ids" {
  description = "Security group ids per service"
  value = {
    for k, v in module.service_security_groups :
    k => v.security_group_id
  }
}
