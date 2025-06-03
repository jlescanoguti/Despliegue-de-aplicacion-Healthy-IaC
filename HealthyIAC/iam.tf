resource "aws_iam_role" "ec2_s3_read_role" {
  name = "ec2-s3-read-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Effect = "Allow",
      Principal = {
        Service = "ec2.amazonaws.com"
      },
      Action = "sts:AssumeRole"
    }]
  })
}

resource "aws_iam_policy_attachment" "s3_read_attach" {
  name       = "s3-read-attachment"
  roles      = [aws_iam_role.ec2_s3_read_role.name]
  policy_arn = "arn:aws:iam::aws:policy/AmazonS3ReadOnlyAccess"
}

resource "aws_iam_instance_profile" "ec2_profile" {
  name = "ec2-s3-read-profile"
  role = aws_iam_role.ec2_s3_read_role.name
}
