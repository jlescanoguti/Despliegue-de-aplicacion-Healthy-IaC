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

output "api_gateway_authorizer_id" {
  description = "ID of the Cognito Authorizer in API Gateway"
  value       = aws_apigatewayv2_authorizer.healthy_api_cognito_authorizer.id
}

# CloudWatch
output "lambda_log_group_name" {
  value = aws_cloudwatch_log_group.lambda_log_group.name
}

# Terraform nos muestra la URL que podemos usar para acceder a la base de datos
output "rds_endpoint" {
  description = "Endpoint de conexión de la base de datos"
  value       = aws_db_instance.healthy.endpoint  # Aquí obtenemos el endpoint de la base de datos RDS creada
}

# Salida del nombre de la base de datos
# Este es el nombre de la base de datos que se definió en la variable "db_name"
output "rds_name" {
  description = "Nombre de la base de datos"
  value       = aws_db_instance.healthy.db_name  # Aquí obtenemos el nombre de la base de datos RDS creada
}

# Salida del nombre de usuario administrador de la base de datos
# Este es el nombre del usuario con el que se creó la base de datos
output "rds_username" {
  description = "Usuario administrador"
  value       = aws_db_instance.healthy.username  # Aquí obtenemos el nombre de usuario configurado
}

#Salida ec2_public_ip
#output "ec2_public_ip" {
#  description = "La IP pública de la instancia EC2"
#  value       = aws_instance.bastion.public_ip
#}
