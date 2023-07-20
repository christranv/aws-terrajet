# Instance profile
resource "aws_iam_instance_profile" "ecs" {
  name = "${var.project}-${var.env}-ecs-profile"
  path = "/"
  role = aws_iam_role.ecs_host_role.name
}

resource "aws_iam_role" "ecs_host_role" {
  name               = "${var.project}-${var.env}-ecs-host-role"
  assume_role_policy = file("${path.module}/templates/ecs-role.json")
}

resource "aws_iam_role_policy" "ecs_instance_role_policy" {
  name   = "${var.project}-${var.env}-ecs-instance-role-policy"
  policy = file("${path.module}/templates/ecs-instance-role-policy.json")
  role   = aws_iam_role.ecs_host_role.id
}

# Service scale role
resource "aws_iam_role" "ecs_autoscale_role" {
  name               = "${var.project}-${var.env}-service-autoscale"
  assume_role_policy = file("${path.module}/templates/ecs-service-autoscale.json")
}
resource "aws_iam_role_policy_attachment" "ecs_autoscale_role_policy_attachment" {
  role       = aws_iam_role.ecs_autoscale_role.id
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEC2ContainerServiceAutoscaleRole"
}

# Task role
resource "aws_iam_role" "ecs_task_role" {
  name               = "${var.project}-${var.env}-ecs-task-role"
  assume_role_policy = file("${path.module}/templates/ecs-task-role.json")
}

resource "aws_iam_role_policy" "ecs_task_role_policy" {
  name   = "${var.project}-${var.env}-ecs-task-role-policy"
  policy = file("${path.module}/templates/ecs-task-role-policy.json")
  role   = aws_iam_role.ecs_task_role.id
}
