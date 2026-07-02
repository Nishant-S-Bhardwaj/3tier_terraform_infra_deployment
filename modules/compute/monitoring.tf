resource "aws_sns_topic" "asg_alerts" {
  name = "${var.environment}-asg-alerts"

  tags = {
    Name        = "${var.environment}-asg-alerts"
    Environment = var.environment
    Project     = var.project
    ManagedBy   = "Terraform"
  }
}

resource "aws_sns_topic_subscription" "asg_email_subscription" {
  topic_arn = aws_sns_topic.asg_alerts.arn
  protocol  = "email"
  endpoint  = var.alarm_email
}

resource "aws_cloudwatch_metric_alarm" "frontend_scale_up" {
  alarm_name          = "${var.environment}-frontend-scale-up"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = "2"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = "120"
  statistic           = "Average"
  threshold           = var.scale_up_cpu_threshold
  alarm_description   = "Scale up frontend ASG when CPU exceeds ${var.scale_up_cpu_threshold}%"
  treat_missing_data  = "missing"
  alarm_actions       = [aws_autoscaling_policy.frontend_scale_up.arn, aws_sns_topic.asg_alerts.arn]
  dimensions = {
    AutoScalingGroupName = aws_autoscaling_group.frontend_asg.name
  }
}

resource "aws_cloudwatch_metric_alarm" "frontend_scale_down" {
  alarm_name          = "${var.environment}-frontend-scale-down"
  comparison_operator = "LessThanThreshold"
  evaluation_periods  = "2"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = "120"
  statistic           = "Average"
  threshold           = var.scale_down_cpu_threshold
  alarm_description   = "Scale down frontend ASG when CPU drops below ${var.scale_down_cpu_threshold}%"
  treat_missing_data  = "missing"
  alarm_actions       = [aws_autoscaling_policy.frontend_scale_down.arn, aws_sns_topic.asg_alerts.arn]
  dimensions = {
    AutoScalingGroupName = aws_autoscaling_group.frontend_asg.name
  }
}

resource "aws_cloudwatch_metric_alarm" "backend_scale_up" {
  alarm_name          = "${var.environment}-backend-scale-up"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = "2"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = "120"
  statistic           = "Average"
  threshold           = var.scale_up_cpu_threshold
  alarm_description   = "Scale up backend ASG when CPU exceeds ${var.scale_up_cpu_threshold}%"
  treat_missing_data  = "missing"
  alarm_actions       = [aws_autoscaling_policy.backend_scale_up.arn, aws_sns_topic.asg_alerts.arn]
  dimensions = {
    AutoScalingGroupName = aws_autoscaling_group.backend_asg.name
  }
}

resource "aws_cloudwatch_metric_alarm" "backend_scale_down" {
  alarm_name          = "${var.environment}-backend-scale-down"
  comparison_operator = "LessThanThreshold"
  evaluation_periods  = "2"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = "120"
  statistic           = "Average"
  threshold           = var.scale_down_cpu_threshold
  alarm_description   = "Scale down backend ASG when CPU drops below ${var.scale_down_cpu_threshold}%"
  treat_missing_data  = "missing"
  alarm_actions       = [aws_autoscaling_policy.backend_scale_down.arn, aws_sns_topic.asg_alerts.arn]
  dimensions = {
    AutoScalingGroupName = aws_autoscaling_group.backend_asg.name
  }
}
