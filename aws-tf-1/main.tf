provider "aws" {
  region = "${var.aws_region}"
}

terraform {
  backend "s3" {
    bucket = "tolia-tf-test-bucket2021"
    key = "terraform/terraform.tfstate"
    region = "eu-central-1"
  }
}

###Deploy S3
module "storage" {
  source       = "./storage"
  project_name = "${var.project_name}"
}

###Deploy Network part
module "networking" {
  source    = "./networking"
  vpc_cidr  = "${var.vpc_cidr}"
  pub_cidrs = "${var.pub_cidrs}"
  access_ip = "${var.access_ip}"
}

###Deploy EC2 part
module "compute" {
  source         = "./compute"
  instance_count = "${var.instance_count}"
  key_name       = "${var.key_name}"
  pub_key_path   = "${var.pub_key_path}"
  instance_type  = "${var.instance_type}"
  subnets        = "${module.networking.pub_subnets}"
  security_group = "${module.networking.pub_security_group}"
  subnet_ips     = "${module.networking.subnet_ips}"
}
