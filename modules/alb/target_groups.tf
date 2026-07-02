resource "aws_lb_target_group" "external_frontend_tg" {
  name        = "${var.environment}-frontend-tg"
  port        = 80
  protocol    = "HTTP"
  target_type = "instance"
  vpc_id      = var.vpc_id

  health_check {
    protocol            = "HTTP"
    path                = "/"
    matcher             = "200-399"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 2
  }

  tags = {
    Name        = "${var.environment}-frontend-tg"
    Environment = var.environment
    Project     = var.project
    ManagedBy   = "Terraform"
  }
}
resource "aws_lb_target_group" "internal_backend_tg" {

  name = "${var.environment}-backend-tg"

  port     = 80
  protocol = "HTTP"

  vpc_id = var.vpc_id

  target_type = "instance"

  health_check {

    path = "/"

    protocol = "HTTP"

    matcher = "200-399"

    healthy_threshold   = 2
    unhealthy_threshold = 2

    interval = 30
    timeout  = 5
  }

  tags = {
    Name        = "${var.environment}-backend-tg"
    Environment = var.environment
    Project     = var.project
    ManagedBy   = "Terraform"
  }

}