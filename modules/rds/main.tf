resource "aws_db_instance" "this" {
  name                   = "${var.project}-${var.env}-${var.name}-db"
  backup_window          = "03:00-06:00"
  db_subnet_group_name   = aws_db_subnet_group.this.name
  engine                 = var.engine
  engine_version         = var.engine_version
  instance_class         = var.instance_class
  identifier             = var.env
  vpc_security_group_ids = var.sg_ids
  skip_final_snapshot    = true
  maintenance_window     = "Mon:00:00-Mon:03:00"
  # parameter_group_name    = "default.postgres13"
  port                    = var.port
  allocated_storage       = var.allocated_storage
  multi_az                = false
  backup_retention_period = 7
  username                = var.username
  password                = var.password
}

resource "aws_db_subnet_group" "this" {
  name       = "${var.name}-db-subnet-group"
  subnet_ids = var.subnet_ids
}
