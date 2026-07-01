output "frontend_target_group_arn" {
  value       = aws_lb_target_group.external_frontend_tg.arn
  description = "ARN of the external ALB frontend target group"
}
output "backend_target_group_arn" {
  value = aws_lb_target_group.internal_backend_tg.arn
}