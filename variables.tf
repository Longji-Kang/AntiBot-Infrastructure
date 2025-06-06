variable "storage_bucket_name" {
  type = string
}

variable "admin_lambda_role_name" {
  type = string
}

variable "admin_upload_function_name" {
  type = string
}

variable "backend_api_name" {
  type = string
}

variable "admin_api_stage_name" {
  type = string
}

variable "delivery_function_name" {
  type =  string
}

variable "delivery_lambda_role_name" {
  type = string
}

variable "website_bucket_name" {
  type = string
}

variable "cloudfront_role_name" {
  type = string
}

variable "dynamo_table_name" {
  type = string
}

variable "admin_pass" {
  type      = string
  sensitive = true
}