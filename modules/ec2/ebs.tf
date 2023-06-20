resource "aws_volume_attachment" "ec2-vol-attachment" {
  count       = var.ebs_size == null ? 0 : 1
  device_name = "/dev/sdh"
  volume_id   = aws_ebs_volume.ec2-ebs[0].id
  instance_id = var.is_spot ? aws_spot_instance_request.spot-instance[0].spot_instance_id : aws_instance.instance[0].id
}

resource "aws_ebs_volume" "ec2-ebs" {
  count             = var.ebs_size == null ? 0 : 1
  availability_zone = var.availability_zone
  size              = var.ebs_size
  tags = {
    Name = "${var.project}-${var.name}-ebs"
  }
}
