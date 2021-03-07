output "server_id" {
  value = "${join(", ", aws_instance.my_server.*.id)}"
}

output "server_ip" {
  value = "${join(", ", aws_instance.my_server.*.public_ip)}"
}
