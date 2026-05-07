resource "random_string" "suffix" {
  length           = 4
  special          = false
  upper            = false
}


resource "aws_s3_bucket" "vanbor-s3" {
  bucket = "tfstate-vanbor-s3-${var.aws_region}-${random_string.suffix.result}"

  lifecycle {
    prevent_destroy = false
  }
  tags = {
    Environment = "test"
    DM = "dhaval.mehta@einfochips.com"
    Owner = "vanraj.boricha@einfochips.com"
    Department = "PES-IA"
    EndDate = "20/06/2026"
    Name = "vanbor-s3"
  }
}

resource "aws_s3_bucket_versioning" "tfstate_versioning" {
  bucket = aws_s3_bucket.vanbor-s3.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "tfstate_encryption" {
  bucket = aws_s3_bucket.vanbor-s3.id
  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_s3_bucket_public_access_block" "tfstate_block_public" {
  bucket = aws_s3_bucket.vanbor-s3.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}
