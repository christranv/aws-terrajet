resource "aws_security_group" "sg" {
  name   = "${var.project}-${var.env}-${var.sg_name}-sg"
  vpc_id = var.vpc_id
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.project}-${var.env}-${var.sg_name}-sg"
  }
}

resource "aws_security_group_rule" "ingress-sg-target" {
  for_each                 = { for idx, value in var.ingress_port_sg_targets : idx => value }
  type                     = "ingress"
  security_group_id        = aws_security_group.sg.id
  from_port                = each.value.port
  to_port                  = each.value.port
  protocol                 = each.value.protocol
  description              = lookup(each.value, "description", null)
  source_security_group_id = each.value.security_group_id
}

resource "aws_security_group_rule" "ingress-cidr-target" {
  for_each          = { for idx, value in var.ingress_port_cidr_targets : idx => value }
  type              = "ingress"
  security_group_id = aws_security_group.sg.id
  protocol          = each.value.protocol
  from_port         = each.value.port
  to_port           = each.value.port
  description       = lookup(each.value, "description", null)
  cidr_blocks       = each.value.cidr_blocks
}

resource "aws_security_group_rule" "ingress-range-sg-target" {
  for_each                 = { for idx, value in var.ingress_range_sg_targets : idx => value }
  type                     = "ingress"
  security_group_id        = aws_security_group.sg.id
  protocol                 = each.value.protocol
  from_port                = each.value.from_port
  to_port                  = each.value.to_port
  description              = lookup(each.value, "description", null)
  source_security_group_id = each.value.security_group_id
}

resource "aws_security_group_rule" "ingress-range-cidr-target" {
  for_each          = { for idx, value in var.ingress_range_cidr_targets : idx => value }
  type              = "ingress"
  security_group_id = aws_security_group.sg.id
  protocol          = each.value.protocol
  from_port         = each.value.from_port
  to_port           = each.value.to_port
  description       = lookup(each.value, "description", null)
  cidr_blocks       = each.value.cidr_blocks
}
