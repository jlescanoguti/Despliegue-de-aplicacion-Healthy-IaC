resource "aws_s3_bucket" "healthy_app_files" {
  bucket = "healthy-app-files-1234567890"  # Asegúrate de que este nombre sea único globalmente
  acl    = "private"  # Acceso privado
}
