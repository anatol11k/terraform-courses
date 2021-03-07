output "pub_subnets" {
  value = "${aws_subnet.pub_sub.*.id}"
}

output "pub_security_group" {
  value = "${aws_security_group.pub_sg.id}"
}

output "subnet_ips" {
  value = "${aws_subnet.pub_sub.*.cidr_block}"
}
