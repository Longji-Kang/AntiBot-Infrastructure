resource "aws_api_gateway_rest_api" "backend_api" {
    name        = "${local.naming_prefix}${var.backend_api_name}"
    description = "API Gateway for assignment system"
}

# Admin API
resource "aws_api_gateway_resource" "admin_api_login_resource" {
  rest_api_id = aws_api_gateway_rest_api.backend_api.id
  parent_id   = aws_api_gateway_rest_api.backend_api.root_resource_id
  path_part   = "{proxy+}"
}

resource "aws_api_gateway_method" "admin_api_login_method" {
  rest_api_id   = aws_api_gateway_rest_api.backend_api.id
  resource_id   = aws_api_gateway_resource.admin_api_login_resource.id
  http_method   = "POST"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "admin_api_login_integration" {
  rest_api_id = aws_api_gateway_rest_api.backend_api.id
  resource_id = aws_api_gateway_method.admin_api_login_method.resource_id
  http_method = aws_api_gateway_method.admin_api_login_method.http_method

  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = aws_lambda_function.admin_upload_function.invoke_arn
}

resource "aws_api_gateway_deployment" "admin_api_login_deployment" {
  rest_api_id = aws_api_gateway_rest_api.backend_api.id

  triggers = {
    redeployment = sha1(jsonencode(aws_api_gateway_rest_api.backend_api.body))
  }
}

resource "aws_api_gateway_stage" "admin_api_stage" {
    deployment_id = aws_api_gateway_deployment.admin_api_login_deployment.id
    rest_api_id   = aws_api_gateway_rest_api.backend_api.id 
    stage_name    = "${local.naming_prefix}${var.admin_api_stage_name}"
}

output "base_url" {
  value = "${aws_api_gateway_deployment.admin_api_login_deployment.invoke_url}"
}