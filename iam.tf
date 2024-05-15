# Upload and Admin API Lambda API role
resource "aws_iam_role" "admin_lambda_role" {
  name = "${local.naming_prefix}${var.admin_lambda_role_name}"

  assume_role_policy = data.template_file.assume_role_lambda.rendered

  tags = local.tags
}