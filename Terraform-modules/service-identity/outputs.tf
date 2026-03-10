output "role_name" {
  description = "IAM role name"
  value       = aws_iam_role.this.name
}

output "role_arn" {
  description = "IAM role arn"
  value       = aws_iam_role.this.arn
}

output "secret_name" {
  description = "Secrets Manager secret name"
  value       = aws_secretsmanager_secret.this.name
}

output "secret_arn" {
  description = "Secrets Manager secret arn"
  value       = aws_secretsmanager_secret.this.arn
}
