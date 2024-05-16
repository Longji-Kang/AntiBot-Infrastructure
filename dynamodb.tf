resource "aws_dynamodb_table" "version_db" {
  name = "${local.naming_prefix}${var.dynamo_table_name}"
  billing_mode = "PAY_PER_REQUEST"

  range_key = "Version"
  hash_key = "Id"

  attribute {
    name = "Id"
    type = "N"
  }

  attribute {
    name = "Version"
    type = "S"
  }

  attribute {
    name = "Url"
    type = "S"
  }

  local_secondary_index {
    name = "UrlIndex"
    projection_type = "ALL"
    range_key = "Url"
  }

  tags = local.tags
}