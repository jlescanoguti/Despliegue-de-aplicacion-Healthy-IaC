# Configuración del grupo de subred para la base de datos (RDS)
resource "aws_db_subnet_group" "main" {
  name       = "main-subnet-group"
  subnet_ids = [
    aws_subnet.main_subnet_1.id,  # Subred en la AZ us-east-1a
    aws_subnet.main_subnet_2.id   # Subred en la AZ us-east-1b
  ]
  tags = {
    Name = "Main RDS Subnet Group"
  }
}

# Configuración de la instancia RDS PostgreSQL
resource "aws_db_instance" "healthy" {
  identifier             = "healthy-db"
  allocated_storage      = var.db_allocated_storage
  engine                 = "postgres"
  engine_version         = "15.7"
  instance_class         = var.db_instance_class
  db_name                 = var.db_name
  username               = var.db_username
  password               = var.db_password
  publicly_accessible    = false
  skip_final_snapshot    = true
  vpc_security_group_ids = [aws_security_group.rds_sg.id]
  db_subnet_group_name   = aws_db_subnet_group.main.name
}
