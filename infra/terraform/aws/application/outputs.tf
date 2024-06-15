output "website_url" {
  description = "Website URL (HTTPS)"
  value       = aws_cloudfront_distribution.cdn.domain_name
}

output "s3_url" {
  description = "S3 hosting URL (HTTP)"
  value       = aws_s3_bucket_website_configuration.this.website_endpoint
}