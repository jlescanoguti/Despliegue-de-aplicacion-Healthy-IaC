resource "aws_db_instance" "healthy" {
  identifier          = "healthy-db"
  allocated_storage   = 20
  db_instance_class   = "db.t3.micro"
  engine              = "postgres"
  engine_version      = "13.3"
  username            = var.db_username
  password            = var.db_password
  db_name             = var.db_name
  multi_az            = true
  publicly_accessible = false
  deletion_protection = true  # Habilitar protección contra eliminación
  backup_retention_period = 7
  storage_encrypted   = true  # Habilitar cifrado en reposo
  storage_type        = "gp2"
}
