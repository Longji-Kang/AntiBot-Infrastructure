resource "aws_dynamodb_table" "version_db" {
  name = "${local.naming_prefix}${var.dynamo_table_name}"
  billing_mode = "PAY_PER_REQUEST"

  attribute {
    name = "Version"
    type = "S"
  }

  attribute {
    name = "Url"
    type = "S"
  }

  tags = local.tags
}