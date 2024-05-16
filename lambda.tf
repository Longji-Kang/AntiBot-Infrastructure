# Upload and Admin API Lambda functions
resource "aws_lambda_function" "admin_upload_function" {
  depends_on = [ 
    aws_efs_mount_target.efs_mount,
    aws_efs_mount_target.efs_mount_b
  ]

  function_name = "${local.naming_prefix}${var.admin_upload_function_name}"
	role          = aws_iam_role.admin_lambda_role.arn

	s3_bucket 		= "${aws_s3_bucket.storage_bucket.id}"
	s3_key 				= local.admin_lambda_code_location

	handler = "lambda.handler"
	runtime = "python3.12"

	environment {
	  variables = {
		pass = var.admin_pass
		s3_bucket = aws_s3_bucket.storage_bucket.id
		s3_folder = "definitions"
	  }
	}

	vpc_config {
	  subnet_ids = [
		local.priv_subnet_a,
		local.priv_subnet_b
	  ]

	  security_group_ids = [
		aws_security_group.lambda_sg.id
	  ]
	}

  file_system_config {
    arn = aws_efs_access_point.efs_ap.arn
    local_mount_path = "/mnt/lambda"
  }

  timeout = 300
}

resource "aws_lambda_permission" "admin_gateway_permission" {
	statement_id = "AllowAdminApiGateway"
	action = "lambda:InvokeFunction"
	function_name = aws_lambda_function.admin_upload_function.function_name
	principal = "apigateway.amazonaws.com"

	source_arn = "${aws_api_gateway_rest_api.backend_api.execution_arn}/*/*"
}

# Delivery API Lambda Function
resource "aws_lambda_function" "delivery_function" {
	function_name = "${local.naming_prefix}${var.delivery_function_name}"
	role          = aws_iam_role.delivery_lambda_role.arn

	s3_bucket 		= "${aws_s3_bucket.storage_bucket.id}"
	s3_key 				= local.delivery_lambda_code_location

	handler = "lambda.handler"
	runtime = "python3.12"
}

resource "aws_lambda_permission" "delivery_gateway_permission" {
	statement_id = "AllowDeliveryGateway"
	action = "lambda:InvokeFunction"
	function_name = aws_lambda_function.delivery_function.function_name
	principal = "apigateway.amazonaws.com"

	source_arn = "${aws_api_gateway_rest_api.backend_api.execution_arn}/*/*"
}