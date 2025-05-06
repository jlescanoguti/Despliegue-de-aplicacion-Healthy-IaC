# Configuración de la VPC
resource "aws_vpc" "main" {
  cidr_block = var.vpc_cidr
}

# Configuración de la subred en la AZ us-east-1a
resource "aws_subnet" "main_subnet_1" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "us-east-1a"
}

# Configuración de la subred en la AZ us-east-1b
resource "aws_subnet" "main_subnet_2" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.2.0/24"
  availability_zone = "us-east-1b"
}

# Configuración del Security Group para la base de datos (PostgreSQL)
resource "aws_security_group" "rds_sg" {
  name        = "rds-security-group"
  description = "Permite acceso al puerto 5432"
  vpc_id      = aws_vpc.main.id

  ingress {
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # Solo para pruebas, restringe para producción
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
