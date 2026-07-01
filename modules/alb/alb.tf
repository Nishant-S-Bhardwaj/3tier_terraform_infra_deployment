resource "aws_lb" "external_alb" {

  name = "${var.environment}-external-alb"

  internal = false

  load_balancer_type = "application"

  security_groups = [
    var.alb_sg_id
  ]

  subnets = var.public_subnet_ids

  enable_deletion_protection = false

  tags = {
    Name        = "${var.environment}-external-alb"
    Environment = var.environment
    Project     = var.project
    ManagedBy   = "Terraform"
  }

}
resource "aws_lb" "internal_alb" {

  name = "${var.environment}-internal-alb"

  internal = true

  load_balancer_type = "application"

  security_groups = [
    var.alb_sg_id
  ]

  subnets = var.private_subnet_ids

  enable_deletion_protection = false

  tags = {
    Name        = "${var.environment}-internal-alb"
    Environment = var.environment
    Project     = var.project
    ManagedBy   = "Terraform"
  }
}