resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc01.id
  tags = {
    Name = "igw.${var.vpc_name}.${var.aws_region}.${var.domain}"
  }
}
