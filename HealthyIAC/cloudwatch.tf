# KMS key con política segura y específica
resource "aws_kms_key" "cloudwatch_logs_kms" {
  description         = "KMS key for encrypting CloudWatch Logs"
  enable_key_rotation = true
  is_enabled          = true

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Sid    = "AllowCloudWatchLogsService",
        Effect = "Allow",
        Principal = {
          Service = "logs.${var.region}.amazonaws.com"
        },
        Action = [
          "kms:Encrypt",
          "kms:Decrypt",
          "kms:ReEncrypt*",
          "kms:GenerateDataKey*",
          "kms:DescribeKey"
        ],
        Resource = "*"
      }
    ]
  })
}

# CloudWatch Log Group cifrado con la KMS
resource "aws_cloudwatch_log_group" "app_log_group" {
  name              = "/ecs/healthy-iac-app"
  retention_in_days = 365
  kms_key_id        = aws_kms_key.cloudwatch_logs_kms.arn

  tags = {
    Environment = "production"
    Application = "healthy-iac"
  }
}

# IAM Role para Grafana
resource "aws_iam_role" "grafana_cloudwatch_role" {
  name = "grafana-cloudwatch-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = "sts:AssumeRole",
        Effect = "Allow",
        Principal = {
          Service = "grafana.amazonaws.com"
        }
      }
    ]
  })
}

# Política con recursos explícitos
resource "aws_iam_policy" "grafana_cloudwatch_policy" {
  name        = "grafana-cloudwatch-policy"
  description = "Permite a Grafana leer métricas y logs de CloudWatch"

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Sid    = "AllowCloudWatchMetrics",
        Effect = "Allow",
        Action = [
          "cloudwatch:DescribeAlarmsForMetric",
          "cloudwatch:DescribeAlarms",
          "cloudwatch:ListMetrics",
          "cloudwatch:GetMetricStatistics",
          "cloudwatch:GetMetricData"
        ],
        Resource = [
          "arn:aws:cloudwatch:::alarm:*",
          "arn:aws:cloudwatch:::metric:*"
        ]
      },
      {
        Sid    = "AllowCloudWatchLogs",
        Effect = "Allow",
        Action = [
          "logs:DescribeLogGroups",
          "logs:GetLogGroupFields",
          "logs:StartQuery",
          "logs:StopQuery",
          "logs:GetQueryResults",
          "logs:GetLogEvents"
        ],
        Resource = aws_cloudwatch_log_group.app_log_group.arn
      }
    ]
  })
}

# Adjuntar política al rol
resource "aws_iam_role_policy_attachment" "grafana_cloudwatch" {
  role       = aws_iam_role.grafana_cloudwatch_role.name
  policy_arn = aws_iam_policy.grafana_cloudwatch_policy.arn
}

