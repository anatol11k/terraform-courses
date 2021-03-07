variable "aws_region" {}
variable "project_name" {}
variable "vpc_cidr" {}

variable "pub_cidrs" {
  type = "list"
}

variable "access_ip" {}
variable "key_name" {}
variable "pub_key_path" {}
variable "instance_type" {}

variable "instance_count" {
  default = 1
}
