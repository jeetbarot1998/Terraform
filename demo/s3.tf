resource "aws_s3_bucket" "example_05082024" {
  bucket = "my-tf-test-bucket-05082024"

  tags = {
    Name        = "my-tf-test-bucket-05082024"
    Environment = "Dev"
  }
}
