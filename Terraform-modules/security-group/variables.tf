variable "name" {
  description = "Security group name"
  type        = string
}

variable "vpc_id" {
  description = "VPC ID"
  type        = string
}

variable "service_port" {
  description = "Service ingress port"
  type        = number
}

variable "allowed_cidr_blocks" {
  description = "CIDRs allowed to access service"
  type        = list(string)
  default     = ["0.0.0.0/0"]
}

variable "tags" {
  description = "Common tags"
  type        = map(string)
  default     = {}
}
