resource "aws_launch_template" "frontend_lt" {

  name_prefix = "${var.environment}-frontend-"

  image_id      = var.ami_id
  instance_type = var.instance_type
  key_name      = var.key_name

  vpc_security_group_ids = [
    var.frontend_sg_id
  ]

  iam_instance_profile {
    name = aws_iam_instance_profile.ec2_profile.name
  }

  tag_specifications {

    resource_type = "instance"

    tags = {
      Name        = "${var.environment}-frontend-instance"
      Environment = var.environment
      Project     = var.project
      ManagedBy   = "Terraform"
    }

  }

}
resource "aws_launch_template" "backend_lt" {

  name_prefix = "${var.environment}-backend-"

  image_id      = var.ami_id
  instance_type = var.instance_type
  key_name      = var.key_name

  vpc_security_group_ids = [
    var.backend_sg_id
  ]

  iam_instance_profile {
    name = aws_iam_instance_profile.ec2_profile.name
  }

  tag_specifications {

    resource_type = "instance"

    tags = {
      Name        = "${var.environment}-backend-instance"
      Environment = var.environment
      Project     = var.project
      ManagedBy   = "Terraform"
    }

  }

}