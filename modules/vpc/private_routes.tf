#Private Route Table
resource "aws_route_table" "private" {

  vpc_id = aws_vpc.main.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.main.id
  }

  tags = merge(local.common_tags, {
    Name = "${var.environment}-private-route-table"
  })
}
#Associate Private App Subnet 1
resource "aws_route_table_association" "private_app_1" {

  subnet_id      = aws_subnet.private_subnet_1.id
  route_table_id = aws_route_table.private.id

}
#Associate Private App Subnet 2
resource "aws_route_table_association" "private_app_2" {

  subnet_id      = aws_subnet.private_subnet_2.id
  route_table_id = aws_route_table.private.id

}
#Associate Database Subnet 1
resource "aws_route_table_association" "private_db_1" {

  subnet_id      = aws_subnet.db_subnet_1.id
  route_table_id = aws_route_table.private.id

}
#Associate Database Subnet 2
resource "aws_route_table_association" "private_db_2" {

  subnet_id      = aws_subnet.db_subnet_2.id
  route_table_id = aws_route_table.private.id

}