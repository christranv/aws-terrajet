resource "aws_ecs_account_setting_default" "insights" {
  name  = "containerInsights"
  value = "disabled"
}

resource "aws_ecs_account_setting_default" "trunking" {
  name  = "awsvpcTrunking"
  value = "enabled"
}
