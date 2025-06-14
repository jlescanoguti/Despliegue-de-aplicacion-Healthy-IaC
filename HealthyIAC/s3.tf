resource "aws_s3_bucket" "healthy_app_files" {
  bucket = var.bucket_name

  acl    = "private"  # Asegurarse de que el ACL sea privado

  versioning {
    enabled = true
  }

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }

  website {
    index_document = "index.html"
    error_document = "error.html"
  }

  tags = {
    Name = "healthy-app-files"
  }
}

resource "aws_s3_bucket_policy" "public_read_policy" {
  bucket = aws_s3_bucket.healthy_app_files.id
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect    = "Deny"
        Action    = "s3:GetObject"
        Resource  = "${aws_s3_bucket.healthy_app_files.arn}/*"
        Condition = {
          Bool = {
            "aws:SecureTransport" = "false"
          }
        }
      }
    ]
  })
}
