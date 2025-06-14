# Application Load Balancer
resource "aws_lb" "app_lb" {
  name               = "app-lb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.alb_sg.id]
  subnets            = [aws_subnet.main_subnet_1.id, aws_subnet.main_subnet_2.id]
  
  enable_deletion_protection = true

  drop_invalid_header_fields = true  # Asegurarse de que los campos de encabezado inválidos sean descartados

  access_logs {
    bucket  = aws_s3_bucket.access_logs.bucket
    enabled = true
  }

  # Enable desync mitigation
  desync_mitigation_mode = "strictest"  # Habilitar la mitigación de desincronización más estricta
}

resource "aws_lb_target_group" "app_tg" {
  name     = "app-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.main.id

  health_check {
    interval            = 30
    path                = "/health"  # Asegúrate de tener un endpoint adecuado para el HealthCheck
    protocol            = "HTTP"
    timeout             = 5
    healthy_threshold   = 3
    unhealthy_threshold = 3
  }
}
