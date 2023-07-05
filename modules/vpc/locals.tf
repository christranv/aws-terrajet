locals {
  public_subnet_ids  = [for subnet in aws_subnet.public_subnet : subnet.id]
  private_subnet_ids = [for subnet in aws_subnet.private_subnet : subnet.id]
}
