output "frontend_target_group_arn" {
  value       = aws_lb_target_group.external_frontend_tg.arn
  description = "ARN of the external ALB frontend target group"
}

output "backend_target_group_arn" {
  value = aws_lb_target_group.internal_backend_tg.arn
}

output "frontend_alb_dns_name" {
  value       = aws_lb.external_alb.dns_name
  description = "DNS name of the public frontend ALB"
}

output "frontend_alb_zone_id" {
  value       = aws_lb.external_alb.zone_id
  description = "Zone ID of the public frontend ALB"
}