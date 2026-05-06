resource "random_string" "suffix" {
  length           = 4
  special          = false
  upper            = false
}


resource "aws_s3_bucket" "vanbor-s3" {
  bucket = "vanbor-s3-${random_string.suffix.result}"

  tags = {
    Environment = "test"
    DM = "dhaval.mehta@einfochips.com"
    Owner = "vanraj.boricha@einfochips.com"
    Department = "PES-IA"
    EndDate = "20/06/2026"
    Name = "vanbor-s3"
  }
}

