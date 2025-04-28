resource "aws_lambda_function" "hello_world" {
  function_name = "healthy-hello-world"
  handler       = "index.handler"
  runtime       = "nodejs18.x"

  filename         = "${path.module}/lambda_function_payload.zip"
  source_code_hash = filebase64sha256("${path.module}/lambda_function_payload.zip")

  role = aws_iam_role.lambda_execution_role.arn
}
