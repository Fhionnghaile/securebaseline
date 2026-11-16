variable "name" {
  type        = string
  description = "Name prefix for network resources."
}
variable "cidr" {
  type        = string
  default     = "10.0.0.0/16"
  description = "VPC CIDR block."
}
variable "azs" {
  type        = list(string)
  description = "Availability zones to spread subnets across."
}
variable "tags" {
  type    = map(string)
  default = {}
}
