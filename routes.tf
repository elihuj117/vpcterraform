resource "aws_route_table" "public" {
  vpc_id = aws_vpc.vpc01.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
  tags = {
    Name = "rt.pub.${var.vpc_name}.${var.aws_region}.${var.domain}"
  }
}
  
resource "aws_route_table" "vpn" {
  vpc_id = aws_vpc.vpc01.id
  tags = {
    Name = "rt.vpn.${var.vpc_name}.${var.aws_region}.${var.domain}"
  }
}

resource "aws_route_table" "ngw" {
  count = length(var.subnets_private_network)
  vpc_id = aws_vpc.vpc01.id
  tags = {
    Name = "rt.ngw.${var.vpc_name}.${var.aws_region}.${var.domain}"
  }
}

resource "aws_route_table_association" "public" {
  count = length(var.subnets_public_network)
  subnet_id = element(aws_subnet.public.*.id, count.index)
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "vpn" {
  count = length(var.subnets_vpn_network)
  subnet_id = element(aws_subnet.vpn.*.id, count.index)
  route_table_id = aws_route_table.vpn.id
}

resource "aws_route_table_association" "ngw" {
  count = length(var.subnets_private_network)
  subnet_id = element(aws_subnet.private.*.id, count.index)
  route_table_id = element(aws_route_table.ngw.*.id, count.index)
}

resource "aws_route" "private_route_table" {
  count = length(var.subnets_private_network)
  route_table_id = element(aws_route_table.ngw.*.id, count.index)
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id = element(aws_nat_gateway.nat_gateway.*.id, count.index)
}
