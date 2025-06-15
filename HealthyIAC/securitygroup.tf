# Security Group para RDS (PostgreSQL)
resource "aws_security_group" "rds_sg" {
  name        = "rds-security-group"
  description = "Permite acceso al puerto 5432 para PostgreSQL"
  vpc_id      = aws_vpc.main.id

  ingress {
    from_port       = 5432
    to_port         = 5432
    protocol        = "tcp"
    security_groups = [aws_security_group.ec2_sg.id]
    description     = "Permite conexión desde EC2 a RDS PostgreSQL"
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [aws_vpc.main.cidr_block]
    description = "Permite tráfico saliente dentro del VPC"
  }

  tags = {
    Name = "rds-security-group"
  }
}

# Security Group para EC2
resource "aws_security_group" "ec2_sg" {
  name        = "ec2-security-group"
  description = "Permite acceso SSH desde IP específica y tráfico desde ALB"
  vpc_id      = aws_vpc.main.id

  ingress {
    description = "Acceso SSH desde IP específica"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.my_ip]
  }

  ingress {
    description     = "Tráfico desde el ALB hacia la app (puerto 8080)"
    from_port       = 8080
    to_port         = 8080
    protocol        = "tcp"
    security_groups = [aws_security_group.alb_sg.id]
  }

  egress {
    description = "Permite tráfico saliente solo dentro del VPC"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [aws_vpc.main.cidr_block]
  }

  tags = {
    Name = "ec2-security-group"
  }
}

# Security Group para ALB
resource "aws_security_group" "alb_sg" {
  name        = "alb-security-group"
  description = "Security group for ALB (HTTPS público)"
  vpc_id      = aws_vpc.main.id

  ingress {
    description = "HTTPS desde cualquier origen (usuarios web)"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # (Opcional) si necesitas redirigir tráfico HTTP a HTTPS, activa esta regla solo temporalmente
  # ingress {
  #   description = "HTTP desde cualquier origen (redirige a HTTPS)"
  #   from_port   = 80
  #   to_port     = 80
  #   protocol    = "tcp"
  #   cidr_blocks = ["0.0.0.0/0"]
  # }

  egress {
    description = "Permite tráfico saliente dentro del VPC"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [aws_vpc.main.cidr_block]
  }

  tags = {
    Name = "alb-sg"
  }
}


# Añadir este recurso para restringir el security group default
resource "aws_default_security_group" "default" {
  vpc_id = aws_vpc.main.id

  ingress {
    protocol  = -1
    self      = true  # Solo permite tráfico interno
    from_port = 0
    to_port   = 0
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]  # Permite salida a internet
  }
}