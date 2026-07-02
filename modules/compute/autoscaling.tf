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

resource "aws_autoscaling_policy" "frontend_scale_up" {
  name                   = "${var.environment}-frontend-scale-up"
  autoscaling_group_name = aws_autoscaling_group.frontend_asg.name
  adjustment_type        = "ChangeInCapacity"
  scaling_adjustment     = 1
  cooldown               = 300
  policy_type            = "SimpleScaling"
}

resource "aws_autoscaling_policy" "frontend_scale_down" {
  name                   = "${var.environment}-frontend-scale-down"
  autoscaling_group_name = aws_autoscaling_group.frontend_asg.name
  adjustment_type        = "ChangeInCapacity"
  scaling_adjustment     = -1
  cooldown               = 300
  policy_type            = "SimpleScaling"
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

resource "aws_autoscaling_policy" "backend_scale_up" {
  name                   = "${var.environment}-backend-scale-up"
  autoscaling_group_name = aws_autoscaling_group.backend_asg.name
  adjustment_type        = "ChangeInCapacity"
  scaling_adjustment     = 1
  cooldown               = 300
  policy_type            = "SimpleScaling"
}

resource "aws_autoscaling_policy" "backend_scale_down" {
  name                   = "${var.environment}-backend-scale-down"
  autoscaling_group_name = aws_autoscaling_group.backend_asg.name
  adjustment_type        = "ChangeInCapacity"
  scaling_adjustment     = -1
  cooldown               = 300
  policy_type            = "SimpleScaling"
}