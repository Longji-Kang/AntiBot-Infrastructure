data "aws_canonical_user_id" "current" {}

data "template_file" "definitions_s3_policy" {
  template = file("${path.module}/policies/s3_public_access.json")
}