provider "aws" {
  region = "us-east-1"
}
module "guardrails" {
  source = "../../modules/guardrails"
}
