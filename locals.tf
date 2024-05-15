locals {
    naming_prefix = "longji-"
    tags = {
        workload = "university-assignment"
    }

    storage_bucket_name = "${local.naming_prefix}${var.storage_bucket_name}"

    admin_lambda_code_location = "lambda/admin/code.zip"
    delivery_lambda_code_location = "lambda/delivery/code.zip"
}