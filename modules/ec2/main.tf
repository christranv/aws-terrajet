resource "aws_instance" "this" {
  ami                    = var.ami
  instance_type          = var.instance_type
  subnet_id              = var.subnet_id
  vpc_security_group_ids = var.vpc_security_group_ids
  key_name               = var.key_name
  user_data              = var.user_data

  dynamic "root_block_device" {
    for_each = var.root_size != null ? [1] : []
    content {
      volume_size = var.root_size
    }
  }

  tags = {
    Name = "${var.project}-${var.env}-${var.name}"
  }
}
