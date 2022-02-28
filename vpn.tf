resource "aws_vpn_gateway" "vpw" {
#  vpc_id = aws_vpc.vpc01.id
  tags = {
    Name = "vgw.${var.vpc_name}.${var.aws_region}.${var.domain}"
  }
}

resource "aws_customer_gateway" "cgw" {
  bgp_asn = "${var.bgpasn}"
  ip_address = "${var.bgpipaddress}"
  type = "ipsec.1"
  tags = {
    Name = "cgw.${var.vpc_name}.${var.aws_region}.${var.domain}"
  }
}

