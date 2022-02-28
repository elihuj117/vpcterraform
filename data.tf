data "aws_subnet" "publicsubnet" {
  count	 = length(var.subnets_public_network)
  id 	 = element(aws_subnet.public.*.id, count.index)
}
