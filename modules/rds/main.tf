resource "aws_db_instance" "this" {
  db_name                 = "${var.name}db"
  backup_window           = "03:00-06:00"
  db_subnet_group_name    = aws_db_subnet_group.this.name
  engine                  = var.engine
  engine_version          = var.engine_version
  instance_class          = var.instance_class
  identifier              = var.env
  vpc_security_group_ids  = var.sg_ids
  skip_final_snapshot     = true
  maintenance_window      = "Mon:00:00-Mon:03:00"
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
