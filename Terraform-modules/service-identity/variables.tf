variable "service_name" {
  description = "Service name"
  type        = string
}

variable "environment" {
  description = "Environment name"
  type        = string
}

variable "secret_values" {
  description = "Key-value map stored in AWS Secrets Manager"
  type        = map(string)
  default     = {}
}

variable "tags" {
  description = "Common tags"
  type        = map(string)
  default     = {}
}
