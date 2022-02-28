resource "aws_eip" "nat_eip" {
  count = length(var.azs)
  vpc   = true
  tags  = {
    Name = "EIP-${count.index+1}"
  }
}
resource "aws_nat_gateway" "nat_gateway" {
  count = length(var.azs)
  allocation_id = element(aws_eip.nat_eip.*.id, count.index)
  subnet_id     = element(aws_subnet.public.*.id, count.index)
  tags = {
    Name = "ngw.${var.vpc_name}.${var.aws_region}.${var.azs[count.index]}.${var.domain}"
  }
}

