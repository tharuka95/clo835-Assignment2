variable "vpc_cidr" {
  default     = "10.1.0.0/16"
  type        = string
  description = "VPC cidr"
}

variable "subnet_cidr" {
  default = "10.1.1.0/24"
  type        = string
  description = "Subnet"
}


