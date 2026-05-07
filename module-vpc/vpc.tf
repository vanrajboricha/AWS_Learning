module "vpc" {
  source = "./modules/vpc"
  vpc_cidr         = var.vpc_cidr
  tags = var.tags
  environment_name = var.environment_name
  aws_region = var.aws_region   
}