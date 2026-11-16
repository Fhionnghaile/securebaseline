resource "aws_iam_account_password_policy" "this" {
  minimum_password_length        = var.minimum_password_length
  require_uppercase_characters   = true
  require_lowercase_characters   = true
  require_numbers                = true
  require_symbols                = true
  allow_users_to_change_password = true
  max_password_age               = 90
  password_reuse_prevention      = 24
}

# IAM Access Analyzer surfaces resources shared outside the account.
resource "aws_accessanalyzer_analyzer" "this" {
  analyzer_name = "account-analyzer"
  type          = "ACCOUNT"
}
