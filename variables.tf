variable "aws_access_key" {
}

variable "aws_secret_key" {
}

variable "aws_region" {
}

variable "domain" {
}

variable "vpc_name" {
}

variable "vpc_cidr" {
}

variable "vpn_cidr" {
}

variable "subnets_private_network" {
  type = list
  default = []
}

variable "subnets_private_name" {
  type = list
  default = []
}

variable "subnets_public_network" {
  type = list
  default = []
}

variable "subnets_public_name" {
  type = list
  default = []
}

variable "subnets_vpn_network" {
  type = list
  default = []
}

variable "subnets_vpn_name" {
  type = list
  default = []
}

variable "azs" {
  type = list
  default = []
}

variable "myip" {
}

variable "labip" {
}

variable "bgpasn" {
}

variable "bgpipaddress" {
}

