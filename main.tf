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
module "compute" {
  source = "./modules/compute"

  environment = var.environment
  project     = var.project

  frontend_sg_id = module.security.frontend_sg_id
  backend_sg_id  = module.security.backend_sg_id
  frontend_target_group_arn = module.alb.frontend_target_group_arn

  ami_id        = var.ami_id
  instance_type = var.instance_type
  key_name      = var.key_name

  public_subnet_ids  = module.vpc.public_subnet_ids
  private_subnet_ids = module.vpc.private_app_subnet_ids
  backend_target_group_arn = module.alb.backend_target_group_arn
}
module "alb" {

  source = "./modules/alb"

  environment = var.environment
  project     = var.project

  vpc_id = module.vpc.vpc_id

  public_subnet_ids  = module.vpc.public_subnet_ids
  private_subnet_ids = module.vpc.private_app_subnet_ids

  alb_sg_id = module.security.alb_sg_id
}