variable "aws_region" {
  description = "The AWS region where resources will be created"
  type        = string
  default     = "ap-south-1"
}

variable "vpc_cidr" {
  description = "The CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "environment" {
  description = "The environment for the resources"
  type        = string
  default     = "Dev"
}

variable "project" {
  description = "The project name for the resources"
  type        = string
  default     = "three-tier-terraform"
}

variable "az_1" {
  description = "Primary Availability Zone"
  type        = string
}

variable "az_2" {
  description = "Secondary Availability Zone"
  type        = string
}
variable "ami_id" {
  type = string
}

variable "key_name" {
  type = string
}

variable "instance_type" {
  default = "t2.micro"
}