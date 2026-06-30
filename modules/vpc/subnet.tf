resource "aws_subnet" "public_subnet_1" {

  vpc_id = aws_vpc.main.id

  cidr_block = "10.0.1.0/24"

  availability_zone = var.az_1

  map_public_ip_on_launch = true

  tags = {
    Name = "${var.environment}-public-subnet-1"
  }

}
resource "aws_subnet" "public_subnet_2" {

  vpc_id = aws_vpc.main.id

  cidr_block = "10.0.2.0/24"

  availability_zone = var.az_2

  map_public_ip_on_launch = true

  tags = {
    Name = "${var.environment}-public-subnet-2"
  }

}
resource "aws_subnet" "private_subnet_1" {

  vpc_id = aws_vpc.main.id

  cidr_block = "10.0.11.0/24"

  availability_zone = var.az_1

  map_public_ip_on_launch = false

  tags = {
    Name = "${var.environment}-private-subnet-1"
  }
}
resource "aws_subnet" "private_subnet_2" {

  vpc_id = aws_vpc.main.id

  cidr_block = "10.0.12.0/24"

  availability_zone = var.az_2

  map_public_ip_on_launch = false

  tags = {
    Name = "${var.environment}-private-subnet-2"
  }
}
resource "aws_subnet" "db_subnet_1" {

  vpc_id = aws_vpc.main.id

  cidr_block = "10.0.21.0/24"

  availability_zone = var.az_1

  map_public_ip_on_launch = false

  tags = {
    Name = "${var.environment}-db-subnet-1"
  }
}
resource "aws_subnet" "db_subnet_2" {

  vpc_id = aws_vpc.main.id

  cidr_block = "10.0.22.0/24"

  availability_zone = var.az_2

  map_public_ip_on_launch = false

  tags = {
    Name = "${var.environment}-db-subnet-2"
  }
}