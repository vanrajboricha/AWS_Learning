resource "aws_iam_role" "postgres_getsecrets" {
  name = "vanbor-postgres-getsecrets"
  assume_role_policy = var.assume_role_policy
  tags = var.tags
}

resource "aws_iam_role_policy_attachment" "orders_policy_attach" {
  policy_arn = var.policy_arn
  role = aws_iam_role.postgres_getsecrets.name
}

output "orders_iam_role_postgres_arn" {
  value = aws_iam_role.postgres_getsecrets.arn
}