output "tfstate_bucket_arn" {
  description = "tfstatebucket arn"
  value = aws_s3_bucket.vanbor-s3.arn
}

output "tfstate_bucket_id" {
  description = "tfstatebucket id"
  value = aws_s3_bucket.vanbor-s3.id
}