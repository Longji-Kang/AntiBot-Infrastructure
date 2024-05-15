locals {
    naming_prefix = "longji-"
    tags = {
        workload = "university-assignment"
    }

    storage_bucket_name = "${local.naming_prefix}${var.storage_bucket_name}"
}