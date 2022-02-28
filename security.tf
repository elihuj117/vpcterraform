resource "aws_security_group" "lab_access" {
  name = "sg.lab.${var.vpc_name}.${var.aws_region}.${var.domain}"
  description = "Lab Security Group"
  vpc_id = aws_vpc.vpc01.id

  tags = {
    Name = "sg.lab.${var.vpc_name}.${var.aws_region}.${var.domain}"
  }

  ingress {
    description = "HTTP IntraVPC"
    from_port = 80
    to_port = 80
    protocol = "tcp"
    self = true
  }
  ingress {
    description = "Kubernetes API Server"
    from_port = 6443
    to_port = 6443
    protocol = "tcp"
    self = true
  }
  ingress {
    description = "ETCD Server"
    from_port = 2379
    to_port = 2380
    protocol = "tcp"
    self = true
  }
  ingress {
    description = "Kubelet Health Check"
    from_port = 10250
    to_port = 10250
    protocol = "tcp"
    self = true
  }
  ingress {
    description = "Kube Controller"
    from_port = 10252
    to_port = 10252
    protocol = "tcp"
    self = true
  }
  ingress {
    description = "Kubelet API"
    from_port = 10255
    to_port = 10255
    protocol = "tcp"
    self = true
  }
  ingress {
    description = "HTTP Outside"
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = var.myip
  }
  ingress {
    description = "HTTP Outside"
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = var.labip
  }
  ingress {
    description = "SSH VPN"
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = [var.vpn_cidr]
  }
  ingress {
    description = "HTTP 8080"
    from_port = 8080
    to_port = 8080
    protocol = "tcp"
    self = true
  }
  ingress {
    description = "RDP Access"
    from_port = 3389
    to_port = 3389
    protocol = "tcp"
    cidr_blocks = var.myip
  }
  ingress {
    description = "SSH Outside"
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = var.myip
  }
  ingress {
    description = "SSH Outside"
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = var.labip
  }
  ingress {
    description = "SSH IntraVPC"
    from_port = 22
    to_port = 22
    protocol = "tcp"
    self = true
  }
  ingress {
    description = "DNS IntraVPC"
    from_port = 53
    to_port = 53
    protocol = "udp"
    self = true
  }
  ingress {
    description = "HTTPS IntraVPC"
    from_port = 443
    to_port = 443
    protocol = "tcp"
    self = true
  }
  ingress {
    description = "WinRM-HTTP"
    from_port = 5985
    to_port = 5985
    protocol = "tcp"
    self = true
  }
  ingress {
    description = "Ping IntraVPC"
    from_port = -1
    to_port = -1
    protocol = "icmp"
    self = true
  }
  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "rds_access" {
  name = "sg.rds.${var.vpc_name}.${var.aws_region}.${var.domain}"
  description = "RDS Security Group"
  vpc_id = aws_vpc.vpc01.id

  tags = {
    Name = "sg.rds.${var.vpc_name}.${var.aws_region}.${var.domain}"
  }

  ingress {
    description = "MySQL-In"
    from_port = 3306
    to_port = 3306
    protocol = "tcp"
    cidr_blocks = [var.vpc_cidr]
  }
  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "efs_access" {
  name = "sg.efs.${var.vpc_name}.${var.aws_region}.${var.domain}"
  description = "EFS Security Group"
  vpc_id = aws_vpc.vpc01.id

  tags = {
    Name = "sg.efs.${var.vpc_name}.${var.aws_region}.${var.domain}"
  }

  ingress {
    description = "EFS IntraVPC"
    from_port = 2049
    to_port = 2049
    protocol = "tcp"
    cidr_blocks = [var.vpc_cidr]
  }
  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

