resource "aws_subnet" "public_subnet" {
  count                   = length(var.public_cidrs)
  vpc_id                  = aws_vpc.vpc.id
  map_public_ip_on_launch = true
  cidr_block              = var.public_cidrs[count.index]
  availability_zone       = data.aws_availability_zones.available.names[count.index]
  depends_on              = [aws_vpc.vpc]
  tags = {
    Name = "${var.project}-${var.env}-subnet-public-${substr(data.aws_availability_zones.available.names[count.index], -2, -1)}"
  }
}

resource "aws_subnet" "private_subnet" {
  count             = var.private_cidrs != null ? length(var.private_cidrs) : 0
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = var.private_cidrs[count.index]
  availability_zone = data.aws_availability_zones.available.names[count.index]
  depends_on        = [aws_vpc.vpc]
  tags = {
    Name = "${var.project}-${var.env}-subnet-private-${substr(data.aws_availability_zones.available.names[count.index], -2, -1)}"
  }
}
