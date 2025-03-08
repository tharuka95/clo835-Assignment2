resource "aws_vpc" "vpc" {
  cidr_block = var.vpc_cidr
  tags = {
    Name = "Default VPC"
  }
}

resource "aws_subnet" "subnets" {
  vpc_id               = aws_vpc.vpc.id
  cidr_block           = var.subnet_cidr
  availability_zone    = "us-east-1a"
  tags = {
    Name = "Public_SN1"
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id
  tags = {
    Name = "Internet Gateway"
  }
}

resource "aws_route_table" "pub_rtb" {
  vpc_id = aws_vpc.vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "Public Route Table"
  }
}

resource "aws_route_table_association" "public_route_table_association_1" {
  route_table_id = aws_route_table.pub_rtb.id
  subnet_id      = aws_subnet.subnets.id
}