resource "aws_iam_policy" "retailstore_db_secret_policy" {
  name = "retailstore-db-secret-policy"
  description = "DB Policy to access secrets"
  path = "/"
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect   = "Allow"
        Action   = [
          "secretsmanager:GetSecretValue",
          "secretsmanager:DescribeSecret"
        ]
        Resource = "arn:aws:secretsmanager:${var.aws_region}:${data.aws_caller_identity.current.account_id}:secret:retailstore-db-secret*"
      }
    ]
  })
}

output "retailstore_db_secret_policy_arn" {
  description = "IAM Policy ARN for retailstore-db-secret access"
  value       = aws_iam_policy.retailstore_db_secret_policy.arn
}