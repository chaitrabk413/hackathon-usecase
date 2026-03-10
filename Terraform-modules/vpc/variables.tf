variable "name" {
  description = "Name prefix for VPC resources"
  type        = string
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
}

variable "azs" {
  description = "Availability zones to use"
  type        = list(string)
}

variable "public_subnet_cidrs" {
  description = "Public subnet CIDRs aligned with azs"
  type        = list(string)
}

variable "private_subnet_cidrs" {
  description = "Private subnet CIDRs aligned with azs"
  type        = list(string)
}

variable "create_nat_gateway" {
  description = "Whether to create a single NAT gateway"
  type        = bool
  default     = true
}

variable "tags" {
  description = "Common tags"
  type        = map(string)
  default     = {}
}
