# AWS Config managed rules that FLAG drift. (A Config rule detects; it does not block an apply.)
# Organization SCPs that DENY these are created from the management account and are intentionally
# out of scope for a standalone sandbox (see README).

resource "aws_config_config_rule" "s3_public_read" {
  name = "s3-bucket-public-read-prohibited"
  source {
    owner             = "AWS"
    source_identifier = "S3_BUCKET_PUBLIC_READ_PROHIBITED"
  }
}
resource "aws_config_config_rule" "s3_public_write" {
  name = "s3-bucket-public-write-prohibited"
  source {
    owner             = "AWS"
    source_identifier = "S3_BUCKET_PUBLIC_WRITE_PROHIBITED"
  }
}
resource "aws_config_config_rule" "encrypted_volumes" {
  name = "encrypted-volumes"
  source {
    owner             = "AWS"
    source_identifier = "ENCRYPTED_VOLUMES"
  }
}
resource "aws_config_config_rule" "required_tags" {
  name             = "required-tags"
  input_parameters = jsonencode({ tag1Key = var.required_tag_key })
  source {
    owner             = "AWS"
    source_identifier = "REQUIRED_TAGS"
  }
}
