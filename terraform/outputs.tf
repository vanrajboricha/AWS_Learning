output "s3_bucket_name" {
  value = aws_s3_bucket.vanbor-s3.bucket
}

output "s3_bucket_id" {
  value = aws_s3_bucket.vanbor-s3.id
}

output "s3_bucket_arn" {
  value = aws_s3_bucket.vanbor-s3.arn
}