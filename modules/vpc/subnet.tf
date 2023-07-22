locals {
  public_subnet_ids  = [for subnet in aws_subnet.public_subnet : subnet.id]
  private_subnet_ids = [for subnet in aws_subnet.private_subnet : subnet.id]
}

resource "aws_subnet" "public_subnet" {
  count                   = length(var.public_cidrs)
  vpc_id                  = aws_vpc.this.id
  map_public_ip_on_launch = true
  cidr_block              = var.public_cidrs[count.index]
  availability_zone       = data.aws_availability_zones.this.names[count.index]
  depends_on              = [aws_vpc.this]
  tags = {
    Name = "${var.project}-${var.env}-subnet-public-${substr(data.aws_availability_zones.this.names[count.index], -2, -1)}"
  }
}

resource "aws_subnet" "private_subnet" {
  count             = var.private_cidrs != null ? length(var.private_cidrs) : 0
  vpc_id            = aws_vpc.this.id
  cidr_block        = var.private_cidrs[count.index]
  availability_zone = data.aws_availability_zones.this.names[count.index]
  depends_on        = [aws_vpc.this]
  tags = {
    Name = "${var.project}-${var.env}-subnet-private-${substr(data.aws_availability_zones.this.names[count.index], -2, -1)}"
  }
}
