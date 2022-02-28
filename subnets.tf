resource "aws_subnet" "public" {
  count = "${length(var.subnets_public_network)}"
  vpc_id = aws_vpc.vpc01.id
  cidr_block = "${var.subnets_public_network[count.index]}"
  availability_zone = "${var.azs[count.index]}"
  map_public_ip_on_launch = "true"
  tags = {
    Name = "${var.subnets_public_name[count.index]}.${var.vpc_name}.${var.azs[count.index]}.${var.domain}"
    Type = "Public"
  }
}

resource "aws_subnet" "private" {
  count = "${length(var.subnets_private_network)}"
  vpc_id = aws_vpc.vpc01.id
  cidr_block = "${var.subnets_private_network[count.index]}"
  availability_zone = "${var.azs[count.index]}"
  tags = {
    Name = "${var.subnets_private_name[count.index]}.${var.vpc_name}.${var.azs[count.index]}.${var.domain}"
    Type = "Private"
  }
}

resource "aws_subnet" "vpn" {
  count = "${length(var.subnets_vpn_network)}"
  vpc_id = aws_vpc.vpc01.id
  cidr_block = "${var.subnets_vpn_network[count.index]}"
  availability_zone = "${var.azs[count.index]}"
  tags = {
    Name = "${var.subnets_vpn_name[count.index]}.${var.vpc_name}.${var.azs[count.index]}.${var.domain}"
    Type = "VPN"
  }
}
