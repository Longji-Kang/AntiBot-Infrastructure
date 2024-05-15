data "aws_canonical_user_id" "current" {}

data "template_file" "definitions_s3_policy" {
  template = file("${path.module}/policies/s3_public_access.json")
}

data "template_file" "assume_role_lambda" {
    template = file("${path.module}/policies/assume_role.json")

    vars = {
        service = "lambda.amazonaws.com"
    }
}
