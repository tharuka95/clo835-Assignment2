data "terraform_remote_state" "network" {
  backend = "s3"
  config = {
    bucket = "ktdananjana-s3"
    key    = "network/terraform.tfstate"
    region = "us-east-1"
  }
}

resource "aws_security_group" "ec2-sg" {
  name        = "ec2-sg"
  description = "ec2 Security Group"
  vpc_id      = data.terraform_remote_state.network.outputs.vpc_id

  ingress {
    from_port         = 22
    to_port           = 22
    protocol          = "tcp"
    cidr_blocks       = ["0.0.0.0/0"]
  }

  ingress {
    from_port         = 8081
    to_port           = 8081
    protocol          = "tcp"
    cidr_blocks       = ["0.0.0.0/0"]
  }
  
  ingress {
    from_port         = 8082
    to_port           = 8082
    protocol          = "tcp"
    cidr_blocks       = ["0.0.0.0/0"]
  }
  
  ingress {
    from_port         = 8083
    to_port           = 8083
    protocol          = "tcp"
    cidr_blocks       = ["0.0.0.0/0"]
  }
  
  egress {
    from_port         = 0
    to_port           = 0
    protocol          = "-1"
    cidr_blocks       = ["0.0.0.0/0"]
  }

    tags = {
      "Name" = "ec2-sg"
    }
}

data "aws_iam_instance_profile" "iam_profile" {
  name = "LabInstanceProfile"
}

resource "aws_instance" "ec2_instance" {
  ami                     = var.ami_id
  instance_type           = var.instance_type
  subnet_id               = data.terraform_remote_state.network.outputs.subnet_id
  key_name                = var.key_name
  security_groups         = [aws_security_group.ec2-sg.id]
  associate_public_ip_address = true
  user_data               = file("install_docker.sh")
  iam_instance_profile    = data.aws_iam_instance_profile.iam_profile.name
  tags = {
      "Name" = "ec2 instance"
    }
}

resource "aws_key_pair" "web_key" {
  key_name   = var.key_name
  public_key = file("${var.key_name}.pub")
}


resource "awscc_ecr_repository" "mysql_images" {
  repository_name      = "mysql_images"
  image_tag_mutability = "MUTABLE"
  image_scanning_configuration = {
    scan_on_push = true
  }

}
  
  resource "awscc_ecr_repository" "app_images" {
  repository_name      = "app_images"
  image_tag_mutability = "MUTABLE"
  image_scanning_configuration = {
    scan_on_push = true
  }

}