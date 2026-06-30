output "vpc_id" {
  value       = aws_vpc.main.id
  description = "ID of the VPC"
}
output "public_subnet_ids" {
  value       = [aws_subnet.public_subnet_1.id, aws_subnet.public_subnet_2.id]
  description = "IDs of the public subnets"
}
output "private_subnet_ids" {
  value       = [aws_subnet.private_subnet_1.id, aws_subnet.private_subnet_2.id]
  description = "IDs of the private subnets"
}
output "db_subnet_ids" {
  value       = [aws_subnet.db_subnet_1.id, aws_subnet.db_subnet_2.id]
  description = "IDs of the database subnets"
}
output "internet_gateway_id" {
  value       = aws_internet_gateway.main.id
  description = "ID of the Internet Gateway"
}
output "vpc_cidr" {
  value       = aws_vpc.main.cidr_block
  description = "CIDR block of the VPC"
}