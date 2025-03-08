terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

terraform {
  backend "s3" {
    bucket = "ktdananjana-s3"
    key    = "webservers/terraform.tfstate"
    region = "us-east-1"
  }
}