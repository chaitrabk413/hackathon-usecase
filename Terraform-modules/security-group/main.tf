resource "aws_security_group" "this" {
  name        = var.name
  description = "Security group for ${var.name}"
  vpc_id      = var.vpc_id

  ingress {
    description = "Service ingress"
    from_port   = var.service_port
    to_port     = var.service_port
    protocol    = "tcp"
    cidr_blocks = var.allowed_cidr_blocks
  }

  egress {
    description = "Allow all outbound"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(var.tags, {
    Name = var.name
  })
}
