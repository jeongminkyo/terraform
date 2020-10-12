# yb94 VPC for my personal projects
module "yb94_vpc" {
  source          = "../../modules/vpc"
  name            = "YB94"
  cidr            = "10.10.0.0/16"
  environment     = "production"
  public_subnets  = ["10.10.1.0/24", "10.10.2.0/24"]
  private_subnets = ["10.10.101.0/24", "10.10.102.0/24"]
  keypair         = var.keypair
}
