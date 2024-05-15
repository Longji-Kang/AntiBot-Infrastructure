# Upload and Admin API Lambda functions
resource "aws_lambda_function" "admin_upload_function" {
  function_name = "${local.naming_prefix}${var.admin_upload_function_name}"
	role          = aws_iam_role.admin_lambda_role.arn

	s3_bucket 		= "${aws_s3_bucket.storage_bucket.id}"
	s3_key 				= local.admin_lambda_code_location

	handler = "lambda.handler"
	runtime = "python3.12"
}