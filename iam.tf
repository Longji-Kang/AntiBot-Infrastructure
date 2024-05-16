# Upload and Admin API Lambda API role
resource "aws_iam_role" "admin_lambda_role" {
  name = "${local.naming_prefix}${var.admin_lambda_role_name}"

  assume_role_policy = data.template_file.assume_role_lambda.rendered

  tags = local.tags
}

resource "aws_iam_role_policy_attachment" "admin_lambda_execution_attachment" {
  role = aws_iam_role.admin_lambda_role.id
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

resource "aws_iam_role_policy" "admin_lambda_policy" {
  role = aws_iam_role.admin_lambda_role.id
  policy = data.template_file.admin_lambda_role_policy.rendered
}

# Content delivery lambda role
resource "aws_iam_role" "delivery_lambda_role" {
  name = "${local.naming_prefix}${var.delivery_lambda_role_name}"

  assume_role_policy = data.template_file.assume_role_lambda.rendered

  tags = local.tags
}

resource "aws_iam_role_policy_attachment" "delivery_lambda_execution_attachment" {
  role = aws_iam_role.delivery_lambda_role.id
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

resource "aws_iam_role_policy" "delivery_role_policy" {
  role = aws_iam_role.delivery_lambda_role.id
  policy = data.template_file.delivery_lambda_role_policy.rendered
}