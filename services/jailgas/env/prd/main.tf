terraform {
  required_version = ">= 1.0.9"

  required_providers {
    aws = "~> 4.63.0"
  }
}

provider "aws" {
  region = "ap-northeast-2"
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
}

module "network" {
  source          = "../../../../modules/network"
  name            = var.name
  cidr            = var.cidr
  public_subnets  = var.public_subnets
  private_subnets = var.private_subnets
  rds_subnets     = var.rds_subnets
  env             = var.env
}

module "sg" {
  source = "../../modules/sg"
  vpc_id = module.network.id
  env    = var.env
  name   = var.name
  cidr   = var.cidr
}

module "rds" {
  source                 = "../../../../modules/rds"
  env                    = var.env
  name                   = var.name
  private_rds_subnets_id = module.network.rds_subnets
  rds_storage            = var.rds_storage
  db_engine              = var.db_engine
  db_engine_version      = var.db_engine_version
  db_instance_class      = var.db_instance_class
  db_user_name           = var.db_user_name
  db_password            = var.db_password
  database_name          = var.database_name
  database_port          = var.database_port
  security_groups_id     = module.sg.db
}

module "key-pair" {
  source	= "../../modules/key-pair"
  env		= var.env
  name      = var.name
}

module "acm" {
  source			= "../../../../modules/acm"
  domain_name		= var.domain_name
}

module "beanstalk" {
  source			= "../../../../modules/beanstalk"
  name				= var.name
  env				= var.env
  vpc_id			= module.network.id
  public_subnets	= module.network.public_subnets
  instance_type		= "t3.micro"
  keypair			= module.key-pair.key-pair
  certificate		= module.acm.certificate
  security_groups	= join(",", module.sg.ec2_security_groups)
}
