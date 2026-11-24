output "log_bucket" {
  value = aws_s3_bucket.logs.id
}
output "trail_arn" {
  value = aws_cloudtrail.this.arn
}
output "kms_key_arn" {
  value = aws_kms_key.logs.arn
}
