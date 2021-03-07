resource "random_id" "bucket_id" {
  byte_length = 2
}

resource "aws_s3_bucket" "storage" {
  bucket = "${var.project_name}-${random_id.bucket_id.dec}"
  acl    = "private"

  tags = {
    Name        = "My bucket"
    Environment = "Dev"
  }

  force_destroy = true
}
