variable "environment" {
  type = string
}

variable "project" {
  type = string
}

variable "vpc_id" {
  type = string
}

variable "public_subnet_ids" {
  type = list(string)
}

variable "alb_sg_id" {
  type = string
}
variable "private_subnet_ids" {
  description = "Private subnet IDs"
  type        = list(string)
}