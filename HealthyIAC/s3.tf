# S3 Bucket
resource "aws_s3_bucket" "healthy_app_files" {
  bucket = var.bucket_name  # Usamos la variable definida en variables.tf
  acl    = "private"        # Acceso privado
}
