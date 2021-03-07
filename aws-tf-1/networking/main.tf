data "aws_availability_zones" "az" {}

resource "aws_vpc" "my_vpc" {
  cidr_block           = "${var.vpc_cidr}"
  enable_dns_hostnames = "true"
  enable_dns_support   = "true"

  tags {
    Name = "TF_VPC"
  }
}

resource "aws_internet_gateway" "tf_igw" {
  vpc_id = "${aws_vpc.my_vpc.id}"

  tags {
    Name = "TF_IGW"
  }
}

resource "aws_route_table" "tf_rt_pub" {
  vpc_id = "${aws_vpc.my_vpc.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.tf_igw.id}"
  }

  tags {
    name = "TF_RT_PUB"
  }
}

resource "aws_default_route_table" "tf_rt_pr" {
  default_route_table_id = "${aws_vpc.my_vpc.default_route_table_id}"

  tags {
    Name = "TF_RT_PR"
  }
}

resource "aws_subnet" "pub_sub" {
  count                   = 2
  vpc_id                  = "${aws_vpc.my_vpc.id}"
  cidr_block              = "${var.pub_cidrs[count.index]}"
  map_public_ip_on_launch = "true"
  availability_zone       = "${data.aws_availability_zones.az.names[count.index]}"

  tags {
    Name = "TF_PUB_${count.index+1}"
  }
}

resource "aws_route_table_association" "pub_sub_assoc" {
  count          = "${aws_subnet.pub_sub.count}"
  subnet_id      = "${aws_subnet.pub_sub.*.id[count.index]}"
  route_table_id = "${aws_route_table.tf_rt_pub.id}"
}

resource "aws_security_group" "pub_sg" {
  name        = "Public_SG"
  description = "Access SSH/HTTP"
  vpc_id      = "${aws_vpc.my_vpc.id}"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["${var.access_ip}"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["${var.access_ip}"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
