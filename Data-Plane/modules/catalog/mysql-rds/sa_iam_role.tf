resource "aws_iam_role" "catalog_getsecrets" {
  name = "catalog-getsecrets"
  assume_role_policy = var.assume_role_policy

  tags = var.tags
}

resource "aws_iam_role_policy_attachment" "catalog_db_secret_attach" {
  policy_arn = var.policy_arn
  role = aws_iam_role.catalog_getsecrets.name
}

output "catalog_sa_getsecrets_role_arn" {
  value = aws_iam_role.catalog_getsecrets.arn
}
