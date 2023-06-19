# Route tables for the subnets
resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.vpc.id
  tags = {
    Name = "${var.project}-public-rtb"
  }
}

resource "aws_route_table" "private_route_table" {
  vpc_id = aws_vpc.vpc.id
  tags = {
    Name = "${var.project}-private-rtb"
  }
}

# Associate the newly created route tables to the subnets
resource "aws_route_table_association" "public_route_association" {
  count          = length(var.public_cidrs)
  route_table_id = aws_route_table.public_route_table.id
  subnet_id      = aws_subnet.public_subnet[count.index].id
}

resource "aws_route_table_association" "private_route_association" {
  count          = length(var.private_cidrs)
  route_table_id = aws_route_table.private_route_table.id
  subnet_id      = aws_subnet.private_subnet[count.index].id
}

resource "aws_route" "nat_gw_route" {
  count                  = length(aws_nat_gateway.nat_gateway)
  route_table_id         = aws_route_table.private_route_table.id
  nat_gateway_id         = aws_nat_gateway.nat_gateway[count.index].id
  destination_cidr_block = "0.0.0.0/0"
  depends_on             = [aws_nat_gateway.nat_gateway]
}

# Route the public subnet traffic through the Internet Gateway
resource "aws_route" "public_internet_igw_route" {
  route_table_id         = aws_route_table.public_route_table.id
  gateway_id             = aws_internet_gateway.internet_gateway.id
  destination_cidr_block = "0.0.0.0/0"
  depends_on             = [aws_internet_gateway.internet_gateway]
}

