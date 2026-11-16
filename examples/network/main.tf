provider "aws" {
  region = "us-east-1"
}
module "network" {
  source = "../../modules/network"
  name   = "example"
  azs    = ["us-east-1a", "us-east-1b"]
  tags   = { owner = "platform" }
}
