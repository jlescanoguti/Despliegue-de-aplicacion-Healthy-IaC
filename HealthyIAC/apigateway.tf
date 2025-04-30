# 1. API Gateway
resource "aws_apigatewayv2_api" "healthy_api" {
  name          = var.api_gateway_name
  protocol_type = "HTTP"
}

resource "aws_apigatewayv2_stage" "healthy_api_stage" {
  api_id      = aws_apigatewayv2_api.healthy_api.id
  name        = var.api_stage_name
  auto_deploy = true
}

# 2. Authorizer (Cognito)
resource "aws_apigatewayv2_authorizer" "healthy_api_cognito_authorizer" {
  name               = "healthy-api-cognito-authorizer"
  api_id             = aws_apigatewayv2_api.healthy_api.id
  authorizer_type    = "JWT"
  identity_sources    = ["$request.header.Authorization"]
  
  jwt_configuration {
    audience = [aws_cognito_user_pool_client.healthy_user_pool_client.id]
    issuer   = "https://cognito-idp.${var.region}.amazonaws.com/${aws_cognito_user_pool.healthy_user_pool.id}"
  }
}

# 3. Integración con Lambda
resource "aws_apigatewayv2_integration" "api_integration" {
  api_id                 = aws_apigatewayv2_api.healthy_api.id
  integration_type       = "AWS_PROXY"
  integration_uri        = aws_lambda_function.hello_world.invoke_arn
  payload_format_version = "2.0"
}

# 4. Ruta para invocar la Lambda (con Cognito Authorizer)
resource "aws_apigatewayv2_route" "api_route" {
  api_id             = aws_apigatewayv2_api.healthy_api.id
  route_key          = "GET /hello"
  target             = "integrations/${aws_apigatewayv2_integration.api_integration.id}"
  authorization_type = "JWT"
  authorizer_id      = aws_apigatewayv2_authorizer.healthy_api_cognito_authorizer.id
}

# 5. Permiso para que API Gateway invoque la Lambda
resource "aws_lambda_permission" "api_gateway_permission" {
  statement_id  = "AllowAPIGatewayInvoke"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.hello_world.function_name
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${aws_apigatewayv2_api.healthy_api.execution_arn}/*/*"
}
