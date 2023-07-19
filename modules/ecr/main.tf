# Create ECR
resource "aws_ecr_repository" "this" {
  for_each             = var.ecs_services
  name                 = "${var.name_prefix != null ? format("%s-", var.name_prefix) : ""}${each.key}"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = var.scan_on_push
  }

  tags = {
    Name = "${var.project}-${var.env}-${each.key}"
  }
}

resource "aws_ecr_lifecycle_policy" "this" {
  for_each   = aws_ecr_repository.this
  repository = each.value.name
  policy     = <<EOF
{
    "rules": [
        {
            "rulePriority": 10,
            "description": "Keep last ${keep_last} images any",
            "selection": {
                "tagStatus": "any",
                "countType": "imageCountMoreThan",
                "countNumber": ${keep_last}
            },
            "action": {
                "type": "expire"
            }
        }
    ]
}
EOF
}
