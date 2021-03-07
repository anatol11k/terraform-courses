aws_region = "eu-central-1"
project_name = "my-terraform"
vpc_cidr = "10.111.0.0/16"
pub_cidrs = [
    "10.111.1.0/24",
    "10.111.2.0/24"
    ]
access_ip = "0.0.0.0/0"
key_name = "TF_KEY"
pub_key_path = "/home/ec2-user/.ssh/id_rsa.pub"
instance_type = "t2.micro"
instance_count = "2"
