resource "aws_eip" "eip" {
  count = var.assign_public_ip ? 1 : 0
  vpc   = true
}

resource "aws_eip_association" "eip_assoc" {
  count         = var.assign_public_ip ? 1 : 0
  allocation_id = aws_eip.eip[0].id
  instance_id   = var.use_spot ? aws_spot_instance_request.spot-instance[0].spot_instance_id : aws_instance.instance[0].id
}
