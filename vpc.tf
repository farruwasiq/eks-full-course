resource "aws_vpc" "dev_vpc" {
  cidr_block       = var.main_vpc_cidr
  instance_tenancy = "default"
  tags = {
    Name = "main_vpc"
    

  }
}

resource "aws_subnet" "dev_subnet_public_1a" {
  vpc_id            = local.vpc_id
  availability_zone = "us-east-1a"
  cidr_block        = var.public_subnet_1a_cidr
  tags = {
    name = "dev-subnet-public-1a"
    "kubernetes.io/cluster/eks_cluster" = "shared"
    "NodegroupName"= "node_group"
  }
}
resource "aws_subnet" "dev_subnet_public_1b" {
  vpc_id            = local.vpc_id
  availability_zone = "us-east-1b"

  cidr_block = var.public_subnet_1b_cidr
  tags = {
    name = "dev-subnet-public-1b"
    "kubernetes.io/cluster/eks_cluster" = "shared"
    "NodegroupName"= "node_group"
    
  }
}
resource "aws_subnet" "dev_subnet_private_1a" {
  vpc_id            = local.vpc_id
  availability_zone = "us-east-1a"
  cidr_block        = var.private_subnet_1a_cidr
  tags = {
    name = "dev-subnet-private-1a"
    "kubernetes.io/cluster/eks_cluster" = "shared"
    "NodegroupName"= "node_group"
  }
}
resource "aws_subnet" "dev_subnet_private_1b" {
  vpc_id            = local.vpc_id
  availability_zone = "us-east-1b"

  cidr_block = var.private_subnet_1b_cidr
  tags = {
    name = "dev-subent-private-1b"
    "kubernetes.io/cluster/eks_cluster" = "shared"
    "NodegroupName"= "node_group"
  }
}
