# Configuración de la VPC
resource "aws_vpc" "main" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true
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
    cidr_blocks = [var.my_ip]  
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Internet Gateway
resource "aws_internet_gateway" "main_igw" {
  vpc_id = aws_vpc.main.id
  tags = {
    Name = "main-igw"
  }
}

# Tabla de rutas para subred pública
resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main_igw.id
  }

  tags = {
    Name = "public-route-table"
  }
}

# Asociación de tabla de rutas con la subred pública (subnet_1)
resource "aws_route_table_association" "public_rt_assoc" {
  subnet_id      = aws_subnet.main_subnet_1.id
  route_table_id = aws_route_table.public_rt.id
}

# Asociación de tabla de rutas con la subred pública (subnet_2)
resource "aws_route_table_association" "public_rt_assoc_2" {
  subnet_id      = aws_subnet.main_subnet_2.id
  route_table_id = aws_route_table.public_rt.id
}