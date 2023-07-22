resource "aws_eip" "eip" {
  count  = var.assign_public_ip ? 1 : 0
  domain = "vpc"
  tags = {
    Name = "${var.project}-${var.env}-${var.name}-eip"
  }
}

resource "aws_eip_association" "eip_assoc" {
  count         = var.assign_public_ip ? 1 : 0
  allocation_id = aws_eip.eip[0].id
  instance_id   = aws_instance.this.id
}
