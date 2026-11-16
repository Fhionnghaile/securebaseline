output "rule_names" {
  value = [
    aws_config_config_rule.s3_public_read.name,
    aws_config_config_rule.s3_public_write.name,
    aws_config_config_rule.encrypted_volumes.name,
    aws_config_config_rule.required_tags.name,
  ]
}
