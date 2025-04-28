# Función Lambda para el API
resource "aws_lambda_function" "hello_world" {
  function_name = var.lambda_function_name
  handler       = "index.handler"
  runtime       = var.lambda_runtime

  filename         = "${path.module}/${var.lambda_function_zip}"
  source_code_hash = filebase64sha256("${path.module}/${var.lambda_function_zip}")

  role = aws_iam_role.lambda_execution_role.arn
}