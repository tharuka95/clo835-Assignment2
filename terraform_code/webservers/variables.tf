variable "instance_type" {
  default = "t2.micro"
  description = "Type of the instance"
  type        = string
}

variable "ami_id" {
  default = "ami-0ac4dfaf1c5c0cce9"
  description = "AMI id of the instance"
  type        = string
}

variable "key_name"{
    type    = string
    default = "ec2-key"
    description = "Key Name"
} 