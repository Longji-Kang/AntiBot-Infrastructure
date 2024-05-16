resource "aws_cloudfront_origin_access_identity" "cloudfront_identity" {
  comment = "CloudFront identity for accessing website S3 bucket"
}

resource "aws_cloudfront_distribution" "website_cloudfront" {
  restrictions {
    geo_restriction {
      restriction_type = "whitelist"
      locations = ["ZA"]
    }
  }

  enabled             = true
  default_root_object = "index.html"

  origin {
    domain_name = aws_s3_bucket.website_bucket.bucket_regional_domain_name
    origin_id   = local.website_bucket_name
    s3_origin_config {
      origin_access_identity = aws_cloudfront_origin_access_identity.cloudfront_identity.cloudfront_access_identity_path
    }
  }

  viewer_certificate {
    cloudfront_default_certificate = true
  }

  price_class = "PriceClass_200"

  default_cache_behavior {
    cached_methods = ["HEAD", "GET"]
    allowed_methods = ["HEAD", "GET"]
    target_origin_id = local.website_bucket_name
    viewer_protocol_policy = "allow-all"

    forwarded_values {
      query_string = false

      cookies {
        forward = "none"
      }
    }
  }
}