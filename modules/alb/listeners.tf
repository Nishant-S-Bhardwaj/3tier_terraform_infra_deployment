resource "aws_lb_listener" "external_http_listener" {
  load_balancer_arn = aws_lb.external_alb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.external_frontend_tg.arn
  }
}
resource "aws_lb_listener" "internal_http_listener" {

  load_balancer_arn = aws_lb.internal_alb.arn

  port = 80

  protocol = "HTTP"

  default_action {

    type = "forward"

    target_group_arn = aws_lb_target_group.internal_backend_tg.arn

  }

}
