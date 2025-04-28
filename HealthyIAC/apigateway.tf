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
