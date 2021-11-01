terraform {
  backend "remote" {
    hostname = "app.terraform.io"
    organization = "Bobr"

    workspaces {
      name = "stage"
    }
  }
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "3.63.0"
    }

  }

  required_version = ">= 0.14.9"
}
provider "aws" {
  region     = "us-west-2"
  access_key = "***"
  secret_key = "****"
}


module "vpc" {
  source = "terraform-aws-modules/vpc/aws"
  name = "netology"
  cidr = "172.31.0.0/16"
  azs = ["us-west-2a","us-west-2b","us-west-2c"]
  private_subnets = ["172.31.1.0/24","172.31.2.0/24","172.31.3.0/24"]
  public_subnets =  ["172.31.4.0/24","172.31.5.0/24","172.31.6.0/24"]
  #security_groups = [aws_security_group.allow_all.id]
  single_nat_gateway = false
  tags = {
    Terraform = "true"
    Environment = "stage"
  }
}

/* ========================== PUBLIC ========================== */
resource "aws_subnet" "public" {
  vpc_id     = module.vpc.vpc_id
  cidr_block = "172.31.32.0/19"

  tags = {
    Name = "public"
  }
}
resource "aws_internet_gateway" "gw" {
  vpc_id = module.vpc.vpc_id

  tags = {
    Name = "internet gateway"
  }
}

resource "aws_route_table" "pub_to_inet" {
  vpc_id = module.vpc.vpc_id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }

  tags = {
    Name = "public to the internet"
  }
}

resource "aws_route_table_association" "a" {
  subnet_id      = aws_subnet.public.id
  route_table_id = aws_route_table.pub_to_inet.id
}

/* ========================== PRIVATE ========================== */
resource "aws_subnet" "private" {
  vpc_id     = module.vpc.vpc_id
  cidr_block = "172.31.96.0/19"

  tags = {
    Name = "private"
  }
}

resource "aws_eip" "ip_for_nat" {
  vpc      = true
}

resource "aws_nat_gateway" "NAT_for_private_subnet" {
  allocation_id = aws_eip.ip_for_nat.id
  subnet_id     = aws_subnet.public.id

  tags = {
    Name = "NAT for private subnet"
  }
  depends_on = [aws_internet_gateway.gw]
}


resource "aws_route_table" "private_to_nat" {
  vpc_id = module.vpc.vpc_id

  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.NAT_for_private_subnet.id
  }

  tags = {
    Name = "private to the NAT"
  }
}

resource "aws_route_table_association" "b" {
  subnet_id      = aws_subnet.private.id
  route_table_id = aws_route_table.private_to_nat.id
}
