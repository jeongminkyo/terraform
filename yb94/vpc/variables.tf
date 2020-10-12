// my key pair
variable "keypair" {
  default = "yb94-aws"
}

// availability zones
data "aws_availability_zones" "available" {
}
