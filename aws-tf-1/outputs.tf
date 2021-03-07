output "Bucket-Name" {
  value = "${module.storage.bucket_name}"
}

output "Public Subnets" {
  value = "${join(", ", module.networking.pub_subnets)}"
}

output "Subnet IP's" {
  value = "${join(", ", module.networking.subnet_ips)}"
}

output "Public SG" {
  value = "${module.networking.pub_security_group}"
}

output "Public Server IP's" {
  value = "${module.compute.server_ip}"
}

output "Public Server ID's" {
  value = "${module.compute.server_id}"
}
