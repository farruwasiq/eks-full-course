variable "region" {
  type    = string
  default = "us-east-1"
}

variable "main_vpc_cidr" {
  type = string

}
variable "public_subnet_1a_cidr" {
  type = string
}
variable "private_subnet_1a_cidr" {
  type = string
}
variable "public_subnet_1b_cidr" {
  type = string
}
variable "private_subnet_1b_cidr" {
  type = string
}
variable "instance_types" {
  type        = map(string)
  description = "instance types"
}
variable "allowed_source" {
  type = string
}

variable "ami" {
  type = map
  default = {
    us-east-1 = "ami-0885b1f6bd170450c"
    us-west-2 = "ami-07dd19a7900a1f049"

  }
}
