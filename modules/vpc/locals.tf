locals {
  public_subnet_ids = [for k in aws_subnet.public_subnet : k.id]
  private_subnet_ids = [for k in aws_subnet.private_subnet : k.id]
}
