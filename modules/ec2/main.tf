resource "aws_instance" "instance" {
  count                  = var.is_spot ? 0 : 1
  ami                    = var.ami
  instance_type          = var.instance_type
  availability_zone      = var.availability_zone
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

  # provisioner "local-exec" {
  #   command = "aws ec2 create-tags --resources ${self.id} --tags Key=Name,Value=${var.project}-${var.name} --profile ${var.profile} --region ${var.region}"
  # }

  tags = {
    Name = "${var.project}-${var.name}"
  }
}

resource "aws_spot_instance_request" "spot-instance" {
  count                  = var.is_spot ? 1 : 0
  ami                    = var.ami
  instance_type          = var.instance_type
  availability_zone      = var.availability_zone
  subnet_id              = var.subnet_id
  vpc_security_group_ids = var.vpc_security_group_ids
  key_name               = var.key_name
  user_data              = var.user_data
  spot_price             = var.spot_price
  wait_for_fulfillment   = true

  # provisioner "local-exec" {
  #   command = "aws ec2 create-tags --resources ${self.spot_instance_id} --tags Key=Name,Value=${var.project}-${var.name} --profile ${var.profile} --region ${var.region}"
  # }

  tags = {
    Name = "${var.project}-${var.name}-spot"
  }
}

