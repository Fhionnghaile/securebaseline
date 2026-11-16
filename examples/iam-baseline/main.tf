provider "aws" {
  region = "us-east-1"
}
module "iam_baseline" {
  source = "../../modules/iam-baseline"
}
