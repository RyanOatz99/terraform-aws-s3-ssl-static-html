// Capture the hosted zone
data "aws_route53_zone" "hosted_zone" {
  name = var.fqdd
}

// Create the record to point to the bucket
resource "aws_route53_record" "domain_record" {
  zone_id = data.aws_route53_zone.hosted_zone.zone_id
  name = var.domain
  type = "A"

  // Alias the domain name supplied by cloudfront
  alias {
    name = aws_cloudfront_distribution.domain_distribution.domain_name
    zone_id = aws_cloudfront_distribution.domain_distribution.hosted_zone_id
    evaluate_target_health = false
  }
}
