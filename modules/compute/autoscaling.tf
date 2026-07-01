resource "aws_autoscaling_group" "frontend_asg" {

  name = "${var.environment}-frontend-asg"

  desired_capacity = 2
  min_size         = 2
  max_size         = 4

  vpc_zone_identifier = var.private_subnet_ids
  target_group_arns = [
    var.frontend_target_group_arn
  ]

  launch_template {
    id      = aws_launch_template.frontend_lt.id
    version = "$Latest"
  }

  health_check_type = "ELB"

  tag {
    key                 = "Name"
    value               = "${var.environment}-frontend-instance"
    propagate_at_launch = true
  }
}
resource "aws_autoscaling_group" "backend_asg" {

  name = "${var.environment}-backend-asg"

  desired_capacity = 2
  min_size         = 2
  max_size         = 4

  vpc_zone_identifier = var.private_subnet_ids
  target_group_arns = [
    var.backend_target_group_arn
  ]

  launch_template {
    id      = aws_launch_template.backend_lt.id
    version = "$Latest"
  }

  health_check_type = "ELB"

  tag {
    key                 = "Name"
    value               = "${var.environment}-backend-instance"
    propagate_at_launch = true
  }
}