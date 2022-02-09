resource "aws_s3_bucket" "px" {
  bucket_prefix = "px-"
  acl           = "private"
}
