// Capture the certificate
data "aws_acm_certificate" "tls_cert" {
  domain = var.certificate_domain
  most_recent = true
}

// Create CF distribution with the captured certification
resource "aws_cloudfront_distribution" "domain_distribution" {
  origin {
    custom_origin_config {
      http_port              = "80"
      https_port             = "443"
      origin_protocol_policy = "http-only"
      origin_ssl_protocols   = ["TLSv1", "TLSv1.1", "TLSv1.2"]
    }

    // Endpoint
    domain_name = aws_s3_bucket.web_content.website_endpoint
    origin_id   = var.domain
  }

  enabled             = true
  default_root_object = "index.html"

  default_cache_behavior {
    viewer_protocol_policy = "redirect-to-https"
    compress               = true
    allowed_methods        = ["GET", "HEAD"]
    cached_methods         = ["GET", "HEAD"]
    target_origin_id       = var.domain
    min_ttl                = 0
    default_ttl            = 86400
    max_ttl                = 31536000

    forwarded_values {
      query_string = false
      cookies {
        forward = "none"
      }
    }
  }

  // Alias
  aliases = ["${var.domain}"]

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  // Certification goes here
  viewer_certificate {
    acm_certificate_arn = "${data.aws_acm_certificate.tls_cert.arn}"
    ssl_support_method  = "sni-only"
  }
}
