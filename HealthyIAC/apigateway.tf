# 1. API Gateway
resource "aws_apigatewayv2_api" "healthy_api" {
  name          = "healthy-api"
  protocol_type = "HTTP"
}

resource "aws_apigatewayv2_stage" "healthy_api_stage" {
  api_id      = aws_apigatewayv2_api.healthy_api.id
  name        = "dev"
  auto_deploy = true
}

output "api_gateway_url" {
  value = aws_apigatewayv2_stage.healthy_api_stage.invoke_url
}

# 2. Integración con Lambda
resource "aws_apigatewayv2_integration" "api_integration" {
  api_id                 = aws_apigatewayv2_api.healthy_api.id
  integration_type       = "AWS_PROXY"
  integration_uri        = aws_lambda_function.hello_world.invoke_arn
  payload_format_version = "2.0"
}

# 3. Ruta para invocar la Lambda
resource "aws_apigatewayv2_route" "api_route" {
  api_id    = aws_apigatewayv2_api.healthy_api.id
  route_key = "GET /hello"
  target    = "integrations/${aws_apigatewayv2_integration.api_integration.id}"
}

# 4. Permiso para que API Gateway invoque la Lambda
resource "aws_lambda_permission" "api_gateway_permission" {
  statement_id  = "AllowAPIGatewayInvoke"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.hello_world.function_name
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${aws_apigatewayv2_api.healthy_api.execution_arn}/*/*"
}