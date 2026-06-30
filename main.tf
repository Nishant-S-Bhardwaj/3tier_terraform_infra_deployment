module "vpc" {
  source      = "./modules/vpc"
  vpc_cidr    = var.vpc_cidr
  environment = var.environment
  project     = var.project
  az_1        = var.az_1
  az_2        = var.az_2
}
