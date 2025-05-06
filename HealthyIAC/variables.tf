## variables.tf

#S3 Bucket

variable "bucket_name" {
  description = "Nombre del bucket S3"
  type        = string
  default     = "healthy-app-files-1234567890"  # Aquí puedes cambiar el nombre por uno único
}

# Cognito User Pool

variable "cognito_user_pool_name" {
  description = "Nombre del User Pool de Cognito"
  type        = string
  default     = "healthy-user-pool"
}

variable "cognito_user_pool_client_name" {
  description = "Nombre del Cliente de Cognito"
  type        = string
  default     = "healthy-client"
}

# IAM

variable "lambda_execution_role_name" {
  description = "Nombre del rol de ejecución de Lambda"
  type        = string
  default     = "lambda-execution-role-healthy"
}

# Lambda

variable "lambda_function_name" {
  description = "Nombre de la función Lambda"
  type        = string
  default     = "healthy-hello-world"
}

variable "lambda_runtime" {
  description = "Runtime de la función Lambda"
  type        = string
  default     = "nodejs18.x"
}

variable "lambda_function_zip" {
  description = "Ruta del archivo ZIP con el código de Lambda"
  type        = string
  default     = "lambda_function_payload.zip"
}

# API Gateway

variable "api_gateway_name" {
  description = "Nombre de la API Gateway"
  type        = string
  default     = "healthy-api"
}

variable "api_stage_name" {
  description = "Nombre del stage para la API Gateway"
  type        = string
  default     = "dev"
}

variable "region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}

# Rango de direcciones IP privadas para la red principal (VPC)
variable "vpc_cidr" {
  default = "10.0.0.0/16"
}

# Rango de direcciones IP para una subred dentro de la VPC
variable "subnet_cidr" {
  default = "10.0.1.0/24"
}

# Zona de disponibilidad en la que se desplegará los recursos (como la subred)

variable "availability_zone" {
  default = "us-east-1a"
}

# Nombre de la base de datos PostgreSQL que se creará dentro de RDS
variable "db_name" {
  default = "healthy_db"
}

# Usuario administrador para la base de datos
variable "db_username" {
  default = "healthyadmin"
}

# Contraseña del usuario administrador
# `sensitive = true` evita que Terraform la muestre en consola
variable "db_password" {
  description = "Contraseña de la base de datos"
  sensitive   = true
  default     = "PasswordSegura123"
}

# Tipo de instancia que se usará para RDS
# db.t3.micro es válida para pruebas y entra dentro del Free Tier
variable "db_instance_class" {
  default = "db.t3.micro"
}

# Cantidad de almacenamiento asignado (en GB) para la base de datos
# El mínimo permitido es 20 GB
variable "db_allocated_storage" {
  default = 20
}
