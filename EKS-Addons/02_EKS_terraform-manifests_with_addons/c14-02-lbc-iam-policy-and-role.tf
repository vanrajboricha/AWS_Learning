resource "aws_iam_policy" "lbc_iam_policy" {
  name = "${local.name}-AWSLoadBalancerControllerIAMPolicy"
  path = "/"
  description = "AWS LB IAM Policy"
  policy = data.http.lbc_iam_policy.response_body
}

output "lbc_iam_policy_arn" {
  value = aws_iam_policy.lbc_iam_policy.arn
}

resource "aws_iam_role" "lbc_iam_role" {
  name = "${local.name}-lbc-iam-role"
  assume_role_policy = data.aws_iam_policy_document.assume_role.json
  tags = merge(var.tags, {
    Name        = "${local.name}-lbc-iam-role"
    Environment = var.environment_name
    Component   = "AWS Load Balancer Controller"
  })
}

resource "aws_iam_role_policy_attachment" "lbc_iam_role_policy_attachment" {
  policy_arn = aws_iam_policy.lbc_iam_policy.arn
  role = aws_iam_role.lbc_iam_role.name
}

output "lbc_iam_role_arn" {
  description = "AWS LB IAM role aren"
  value = aws_iam_role.lbc_iam_role.arn
}