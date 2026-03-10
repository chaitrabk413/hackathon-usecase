output "vpc_id" {
  description = "VPC id"
  value       = aws_vpc.this.id
}

output "public_subnet_ids" {
  description = "Public subnet ids"
  value       = [for subnet in aws_subnet.public : subnet.id]
}

output "private_subnet_ids" {
  description = "Private subnet ids"
  value       = [for subnet in aws_subnet.private : subnet.id]
}
