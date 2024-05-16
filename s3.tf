# Definitions storage bucket
resource "aws_s3_bucket" "storage_bucket" {
  bucket = local.storage_bucket_name

  tags = merge(
    local.tags,
    {
        Name = local.storage_bucket_name
    }
  )

  force_destroy = true
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

resource "aws_s3_bucket_policy" "storage_bucket_policy" {
  bucket = aws_s3_bucket.storage_bucket.id
  policy = data.template_file.definitions_s3_policy.template
}

# Admin Lambda Empty Code Object
resource "aws_s3_object" "admin_lambda_object" {
  bucket = aws_s3_bucket.storage_bucket.id
  key    = local.admin_lambda_code_location
  source = "./lambda_base/code.zip"
  etag   = filemd5("./lambda_base/code.zip") 
}

# Delivery Lambda Empty Code Object
resource "aws_s3_object" "delivery_lambda_object" {
  bucket = aws_s3_bucket.storage_bucket.id
  key    = local.delivery_lambda_code_location
  source = "./lambda_base/code.zip"
  etag   = filemd5("./lambda_base/code.zip") 
}

# Admin Portal Website Bucket
resource "aws_s3_bucket" "website_bucket" {
  bucket = local.website_bucket_name

  tags = merge(
    local.tags,
    {
        Name = local.storage_bucket_name
    }
  )

  force_destroy = true
}

resource "aws_s3_bucket_public_access_block" "website_bucket_block_public" {
    bucket = aws_s3_bucket.website_bucket.id

    block_public_acls       = true
    block_public_policy     = true
    ignore_public_acls      = true
    restrict_public_buckets = true
}

resource "aws_s3_bucket_ownership_controls" "website_bucket_object_ownership" {
  bucket = aws_s3_bucket.website_bucket.id

  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

resource "aws_s3_bucket_acl" "website_bucket_acl" {
  depends_on = [ 
    aws_s3_bucket_ownership_controls.website_bucket_object_ownership,
    aws_s3_bucket_public_access_block.website_bucket_block_public
  ]

  bucket = aws_s3_bucket.website_bucket.id
  acl    = "private"
}

resource "aws_s3_bucket_versioning" "website_bucket_versioning" {
  bucket = aws_s3_bucket.website_bucket.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_policy" "website_policy" {
  bucket = aws_s3_bucket.website_bucket.id
  policy = data.template_file.website_s3_policy.rendered
}