variable "environment" {
  type = string
}

variable "project" {
  type = string
}
variable "frontend_sg_id" {
  type = string
}

variable "backend_sg_id" {
  type = string
}

variable "frontend_target_group_arn" {
  description = "ARN of the frontend ALB target group"
  type        = string
}

variable "key_name" {
  description = "EC2 Key Pair"
  type        = string
}

variable "ami_id" {
  description = "Amazon Linux 2023 AMI"
  type        = string
}

variable "instance_type" {
  type    = string
  default = "t2.micro"
}
variable "public_subnet_ids" {
  description = "Public subnet IDs"
  type        = list(string)
}

variable "private_subnet_ids" {
  description = "Private application subnet IDs"
  type        = list(string)
}
variable "backend_target_group_arn" {
  type = string
}

variable "alarm_email" {
  description = "Email address for autoscaling notifications"
  type        = string
}

variable "scale_up_cpu_threshold" {
  description = "CPU threshold for scale-up alarms"
  type        = number
  default     = 70
}

variable "scale_down_cpu_threshold" {
  description = "CPU threshold for scale-down alarms"
  type        = number
  default     = 30
}