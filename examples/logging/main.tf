provider "aws" {
  region = "us-east-1"
}
module "logging" {
  source = "../../modules/logging"
  name   = "example"
}
