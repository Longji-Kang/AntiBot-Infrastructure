locals {
    naming_prefix = "longji-"
    tags = {
        workload = "university-assignment"
    }

    storage_bucket_name = "${local.naming_prefix}${var.storage_bucket_name}"
    website_bucket_name = "${local.naming_prefix}${var.website_bucket_name}"

    admin_lambda_code_location = "lambda/admin/code.zip"
    delivery_lambda_code_location = "lambda/delivery/code.zip"

    admin_arn    = "arn:aws:iam::296274010522:user/longji-github-user"
    dev_role_arn = "arn:aws:iam::296274010522:role/aws-reserved/sso.amazonaws.com/eu-west-1/AWSReservedSSO_DeveloperAccess_a4a6262b8ec5160a"

    priv_subnet_a = "subnet-0df926d83a7ba1a6e"
    priv_subnet_b = "subnet-0c3bb0b2d113f0f57"
    vpc_id        = "vpc-01f8cf2855398cc3c"
    vpc_cidr      = "172.0.0.0/18"
}