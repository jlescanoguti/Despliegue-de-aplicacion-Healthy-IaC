# Cognito User Pool
resource "aws_cognito_user_pool" "healthy_user_pool" {
  name = "healthy-user-pool"

  password_policy {
    minimum_length    = 8
    require_uppercase = true
    require_numbers   = true
    require_symbols   = true
  }

  alias_attributes = ["email"]  # Permite a los usuarios iniciar sesión con su email
}

# Cognito User Pool Client
resource "aws_cognito_user_pool_client" "healthy_user_pool_client" {
  name         = "healthy-client"
  user_pool_id = aws_cognito_user_pool.healthy_user_pool.id
  generate_secret = false  # No generamos un secreto para el cliente
}
