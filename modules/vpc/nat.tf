resource "aws_eip" "nat" {

  domain = "vpc"

  tags = merge(local.common_tags, {
    Name = "${var.environment}-nat-eip"
  })

}
resource "aws_nat_gateway" "main" {

  allocation_id = aws_eip.nat.id

  subnet_id = aws_subnet.public_subnet_1.id

  tags = merge(local.common_tags, {
    Name = "${var.environment}-nat-gateway"
  })

  depends_on = [
    aws_internet_gateway.main
  ]
}