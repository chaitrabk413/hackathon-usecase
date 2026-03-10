variable "aws_region" {
  description = "AWS region for backend resources"
  type        = string
  default     = "us-east-1"
}

variable "project_name" {
  description = "Project name prefix"
  type        = string
  default     = "hackathon-usecase"
}

variable "tags" {
  description = "Common tags"
  type        = map(string)
  default = {
    ManagedBy = "terraform"
    Project   = "hackathon-usecase"
  }
}
