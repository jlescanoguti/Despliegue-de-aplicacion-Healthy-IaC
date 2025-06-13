resource "aws_kms_key" "rds_kms" {
  description             = "KMS key for RDS encryption"
  deletion_window_in_days = 10
  enable_key_rotation     = true
}

resource "aws_subnet" "private_subnet_1" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.3.0/24"
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = false
  tags = {
    Name = "private-subnet-1"
  }
}

resource "aws_subnet" "private_subnet_2" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.4.0/24"
  availability_zone       = "us-east-1b"
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

resource "aws_db_instance" "healthy" {
  identifier                            = "healthy-db"
  allocated_storage                     = var.db_allocated_storage
  engine                                = "postgres"
  engine_version                        = "15.7"
  instance_class                        = var.db_instance_class
  db_name                               = var.db_name
  username                              = var.db_username
  password                              = var.db_password
  publicly_accessible                   = false
  skip_final_snapshot                   = false
  deletion_protection                   = true
  multi_az                              = true
  backup_retention_period               = 7
  storage_encrypted                     = true
  monitoring_interval                   = 60
  performance_insights_enabled          = true
  performance_insights_kms_key_id       = aws_kms_key.rds_kms.arn
  enabled_cloudwatch_logs_exports       = ["postgresql", "upgrade"]
  copy_tags_to_snapshot                 = true
  iam_database_authentication_enabled   = true
  vpc_security_group_ids                = [aws_security_group.rds_sg.id]
  db_subnet_group_name                  = aws_db_subnet_group.main.name
  tags = {
    Name = "healthy-db"
  }
}