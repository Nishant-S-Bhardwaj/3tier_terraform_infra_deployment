resource "aws_security_group" "alb_sg" {

  name        = "${var.environment}-alb-sg"
  description = "Security Group for External ALB"
  vpc_id      = var.vpc_id

  ingress {

    description = "HTTP"

    from_port = 80
    to_port   = 80
    protocol  = "tcp"

    cidr_blocks = ["0.0.0.0/0"]

  }

  ingress {

    description = "HTTPS"

    from_port = 443
    to_port   = 443
    protocol  = "tcp"

    cidr_blocks = ["0.0.0.0/0"]

  }

  egress {

    from_port = 0
    to_port   = 0
    protocol  = "-1"

    cidr_blocks = ["0.0.0.0/0"]

  }

  tags = {
    Name = "${var.environment}-alb-sg"
  }

}


resource "aws_security_group" "frontend_sg" {

  name        = "${var.environment}-frontend-sg"
  description = "Security Group for Frontend EC2"
  vpc_id      = var.vpc_id

  ingress {

    description = "HTTP from ALB"

    from_port = 80
    to_port   = 80
    protocol  = "tcp"

    security_groups = [
      aws_security_group.alb_sg.id
    ]

  }

  egress {

    from_port = 0
    to_port   = 0
    protocol  = "-1"

    cidr_blocks = ["0.0.0.0/0"]

  }

  tags = {
    Name = "${var.environment}-frontend-sg"
  }

}

resource "aws_security_group" "backend_sg" {

  name        = "${var.environment}-backend-sg"
  description = "Security Group for Backend EC2"
  vpc_id      = var.vpc_id

  ingress {

    description = "HTTP from Frontend"

    from_port = 80
    to_port   = 80
    protocol  = "tcp"

    security_groups = [
      aws_security_group.frontend_sg.id
    ]

  }

  egress {

    from_port = 0
    to_port   = 0
    protocol  = "-1"

    cidr_blocks = ["0.0.0.0/0"]

  }

  tags = {
    Name = "${var.environment}-backend-sg"
  }

}

resource "aws_security_group" "database_sg" {

  name        = "${var.environment}-database-sg"
  description = "Security Group for RDS Database"
  vpc_id      = var.vpc_id

  ingress {

    description = "MySQL from Backend"

    from_port = 3306
    to_port   = 3306
    protocol  = "tcp"

    security_groups = [
      aws_security_group.backend_sg.id
    ]

  }

  egress {

    from_port = 0
    to_port   = 0
    protocol  = "-1"

    cidr_blocks = ["0.0.0.0/0"]

  }

  tags = {
    Name = "${var.environment}-database-sg"
  }

}