data "aws_iam_policy_document" "assume_role" {
  statement {
    sid    = "AllowServiceAssumeRole"
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["ecs-tasks.amazonaws.com", "ec2.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]
  }
}

resource "aws_iam_role" "this" {
  name               = "${var.service_name}-${var.environment}-role"
  assume_role_policy = data.aws_iam_policy_document.assume_role.json

  tags = merge(var.tags, {
    Service     = var.service_name
    Environment = var.environment
  })
}

resource "aws_secretsmanager_secret" "this" {
  name                    = "${var.service_name}/${var.environment}/app-config"
  recovery_window_in_days = 7

  tags = merge(var.tags, {
    Service     = var.service_name
    Environment = var.environment
  })
}

resource "aws_secretsmanager_secret_version" "this" {
  secret_id     = aws_secretsmanager_secret.this.id
  secret_string = jsonencode(var.secret_values)
}

data "aws_iam_policy_document" "service_access" {
  statement {
    sid    = "AllowReadOwnSecret"
    effect = "Allow"

    actions = [
      "secretsmanager:GetSecretValue",
      "secretsmanager:DescribeSecret"
    ]

    resources = [aws_secretsmanager_secret.this.arn]
  }

  statement {
    sid    = "AllowECRPull"
    effect = "Allow"

    actions = [
      "ecr:GetAuthorizationToken",
      "ecr:BatchGetImage",
      "ecr:GetDownloadUrlForLayer",
      "ecr:BatchCheckLayerAvailability"
    ]

    resources = ["*"]
  }
}

resource "aws_iam_role_policy" "this" {
  name   = "${var.service_name}-${var.environment}-inline-policy"
  role   = aws_iam_role.this.id
  policy = data.aws_iam_policy_document.service_access.json
}
