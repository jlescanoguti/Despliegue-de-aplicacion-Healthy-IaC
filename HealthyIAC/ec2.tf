resource "aws_instance" "backend" {
  ami                    = var.ec2_ami
  instance_type          = var.ec2_instance_type
  key_name               = var.key_pair_name
  subnet_id              = aws_subnet.main_subnet_1.id
  vpc_security_group_ids = [aws_security_group.ec2_sg.id]
  iam_instance_profile = aws_iam_instance_profile.ec2_profile.name

  monitoring = true
  ebs_optimized  = true

  associate_public_ip_address = false  

  metadata_options {
  http_endpoint = "enabled"
  http_tokens   = "required"
  }

  root_block_device {
  volume_type = "gp3"
  volume_size = 20
  encrypted   = true 
  }

  tags = {
    Name = "backend-ec2-instance"
  }

   user_data = file("setup_backend.sh")
}
