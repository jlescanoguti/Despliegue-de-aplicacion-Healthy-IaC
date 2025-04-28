# S3 Bucket
output "s3_bucket_name" {
  value = aws_s3_bucket.healthy_app_files.bucket
  description = "Nombre del bucket S3 creado"
}

# Cognito User Pool

output "cognito_user_pool_id" {
  value = aws_cognito_user_pool.healthy_user_pool.id
  description = "ID del User Pool de Cognito"
}

output "cognito_user_pool_client_id" {
  value = aws_cognito_user_pool_client.healthy_user_pool_client.id
  description = "ID del Cliente del User Pool de Cognito"
}

# IAM
output "lambda_execution_role_arn" {
  value       = aws_iam_role.lambda_execution_role.arn
  description = "ARN del rol de ejecución de Lambda"
}

# Lambda

output "lambda_function_arn" {
  value       = aws_lambda_function.hello_world.arn
  description = "ARN de la función Lambda"
}

# API Gateway
output "api_gateway_url" {
  value       = aws_apigatewayv2_stage.healthy_api_stage.invoke_url
  description = "URL de la API Gateway"
}