data "aws_canonical_user_id" "current" {}

data "template_file" "definitions_s3_policy" {
  template = file("${path.module}/policies/s3_public_access.json")

  vars = {
    lambda_role = aws_iam_role.admin_lambda_role.arn
    dev_role    = local.dev_role_arn
    admin_user  = local.admin_arn
  }
}

data "template_file" "assume_role_lambda" {
    template = file("${path.module}/policies/assume_role.json")

    vars = {
        service = "lambda.amazonaws.com"
    }
}

data "template_file" "assume_role_apigateway" {
    template = file("${path.module}/policies/assume_role.json")

    vars = {
        service = "apigateway.amazonaws.com"
    }
}


data "template_file" "website_s3_policy" {
  template = file("${path.module}/policies/s3_website_access.json")

  vars = {
    s3_arn              = aws_s3_bucket.website_bucket.arn
    cloudfront_role_arn = aws_cloudfront_origin_access_identity.cloudfront_identity.iam_arn
    dev_role_arn        = local.dev_role_arn
    admin_role_arn      = local.admin_arn
  }
}

data "template_file" "admin_lambda_role_policy" {
  template = file("${path.module}/policies/lambda_execution.json")

  vars = {
    dynamo_arn = aws_dynamodb_table.version_db.arn
  }
}

data "template_file" "delivery_lambda_role_policy" {
  template = file("${path.module}/policies/delivery_lambda_execution.json")

  vars = {
    dynamo_arn = aws_dynamodb_table.version_db.arn
  }
}