output "log_bucket" {
  value = aws_s3_bucket.logs.id
}
output "trail_arn" {
  value = aws_cloudtrail.this.arn
}
