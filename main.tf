module "vpc" {
  source      = "./modules/vpc"
  vpc_cidr    = var.vpc_cidr
  environment = var.environment
  project     = var.project
  az_1        = var.az_1
  az_2        = var.az_2
}
module "security" {

  source = "./modules/security"

  vpc_id = module.vpc.vpc_id

  environment = var.environment
  project     = var.project
}