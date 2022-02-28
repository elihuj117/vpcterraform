resource "aws_vpc" "vpc01" {
  cidr_block = var.vpc_cidr
  instance_tenancy = "default"
  tags = {
    Name = "${var.vpc_name}.${var.aws_region}.${var.domain}"
  }
}
