# Configuración de CloudWatch Logs
resource "aws_iam_role" "grafana_cloudwatch_role" {
  name               = "grafana_cloudwatch_role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action    = "sts:AssumeRole"
        Effect    = "Allow"
        Principal = {
          Service = "cloudwatch.amazonaws.com"
        }
      }
    ]
  })
}