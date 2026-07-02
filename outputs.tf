output "frontend_alb_dns_name" {
  description = "Public frontend ALB DNS name"
  value       = module.alb.frontend_alb_dns_name
}

output "frontend_alb_zone_id" {
  description = "Public frontend ALB zone ID"
  value       = module.alb.frontend_alb_zone_id
}
