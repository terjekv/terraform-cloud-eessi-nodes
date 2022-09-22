locals {
    environment = "testing"
    region      = "eu-north-1"
}

provider "aws" {
  region = local.region
}

module "example_vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "example_vpc"
  cidr = "10.0.0.0/16"

  azs             = ["${local.region}a"]
  public_subnets  = ["10.0.0.0/24"]

  tags = {
    Environment = local.environment
  }
}

module "ssh_security_group" {
  source  = "terraform-aws-modules/security-group/aws//modules/ssh"
  version = "~> 4.0"

  name   = "example_ssh_security_group"
  vpc_id = module.example_vpc.vpc_id

  tags = {
    Environment = local.environment
  }
}

module "a_small_node" {
    source = "../../modules/aws-node/"

    hostname        = "a-small-node"
    instance_size   = "small"

    environment     = local.environment

    security_groups = [module.ssh_security_group.security_group_id]
    subnet_id       = module.example_vpc.public_subnets[0]
}