terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.38.0"
    }
  }
}

provider "aws" {
  default_tags {
    tags = {
      terraform = "True"
    }
  }
}

data "aws_region" "current" {}
data "aws_availability_zones" "main" {}
data "aws_caller_identity" "current" {}

locals {
  current_account_id = data.aws_caller_identity.current.account_id
  current_region     = data.aws_region.current.name
  vpc_cidr_block     = "10.100.0.0/16"
  public_cidr_blocks = [for k, v in data.aws_availability_zones.main.names :
  cidrsubnet(local.vpc_cidr_block, 4, k)]
  private_cidr_blocks = [for k, v in data.aws_availability_zones.main.zone_ids :
  cidrsubnet(local.vpc_cidr_block, 4, k + length(data.aws_availability_zones.main.names))]
}


module "vpc" {
  source = "github.com/nsbno/terraform-aws-vpc.git"

  name_prefix = "my_dev_vpc"

  availability_zones = data.aws_availability_zones.main.names
  cidr_block  = local.vpc_cidr_block
  private_subnet_cidrs = local.private_cidr_blocks
  public_subnet_cidrs = local.public_cidr_blocks
}

data "aws_iam_role" "cloud9_role" {
  name = "Developer"
}

module "cloud9" {
  source = "../"

  name      = "my_dev_environment"
  owner_arn = data.aws_iam_role.cloud9_role.arn
  subnet_id = module.vpc.public_subnet_ids[0]
}

output "environment_url" {
  value = module.cloud9.ide_url
}
