# Definitions storage bucket
resource "aws_s3_bucket" "storage_bucket" {
  bucket = local.storage_bucket_name

  tags = merge(
    local.tags,
    {
        Name = local.storage_bucket_name
    }
  )
}

resource "aws_s3_bucket_ownership_controls" "storage_bucket_object_ownership" {
  bucket = aws_s3_bucket.storage_bucket.id

  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

resource "aws_s3_bucket_public_access_block" "storage_bucket_public" {
    bucket = aws_s3_bucket.storage_bucket.id

    block_public_acls       = false
    block_public_policy     = false
    ignore_public_acls      = false
    restrict_public_buckets = false
}

resource "aws_s3_bucket_acl" "storage_bucket_acl" {
  depends_on = [ 
    aws_s3_bucket_ownership_controls.storage_bucket_object_ownership,
    aws_s3_bucket_public_access_block.storage_bucket_public
  ]

  bucket = aws_s3_bucket.storage_bucket.id
  acl    = "public-read"
}