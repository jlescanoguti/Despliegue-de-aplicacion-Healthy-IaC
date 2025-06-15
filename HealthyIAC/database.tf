# Configuración del grupo de subred para la base de datos (RDS)
# Idealmente subnets privadas, así EC2 accede internamente sin exponer RDS a internet

resource "aws_subnet" "private_subnet_1" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.3.0/24"
  availability_zone = "us-east-1a"
  map_public_ip_on_launch = false 
  tags = {
    Name = "private-subnet-1"
  }
}

resource "aws_subnet" "private_subnet_2" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.4.0/24"
  availability_zone = "us-east-1b"
  map_public_ip_on_launch = false
  tags = {
    Name = "private-subnet-2"
  }
}

resource "aws_db_subnet_group" "main" {
  name       = "main-subnet-group"
  subnet_ids = [
    aws_subnet.private_subnet_1.id,
    aws_subnet.private_subnet_2.id
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
  db_name                = var.db_name
  username               = var.db_username
  password               = var.db_password
  publicly_accessible    = false  # Para que no sea accesible públicamente
  skip_final_snapshot    = true
  vpc_security_group_ids = [aws_security_group.rds_sg.id]
  db_subnet_group_name   = aws_db_subnet_group.main.name

  deletion_protection              = true
  multi_az                         = true
  auto_minor_version_upgrade       = true
  monitoring_interval              = 60
  monitoring_role_arn              = aws_iam_role.rds_monitoring_role.arn
  iam_database_authentication_enabled = true
  
  performance_insights_enabled          = true
  performance_insights_retention_period = 90

  storage_encrypted = true

  enabled_cloudwatch_logs_exports = ["postgresql", "upgrade", "error", "slowquery"]

  backup_retention_period           = 7
  copy_tags_to_snapshot             = true

  tags = {
    Name = "healthy-db"
  }

}