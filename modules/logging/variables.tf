variable "name" {
  type    = string
  default = "securebaseline"
}
variable "log_retention_days" {
  type        = number
  default     = 365
  description = "Days to keep CloudTrail events in CloudWatch Logs (CIS/checkov expect at least 365)."
}
