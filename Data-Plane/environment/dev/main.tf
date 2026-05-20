module "catalog_mysql" {

  source = "../../modules/catalog/mysql-rds"

  environment_name = var.environment_name
  business_division = var.business_division

  vpc_id = data.terraform_remote_state.vpc.outputs.aws_vpc

  private_subnet_ids = data.terraform_remote_state.vpc.outputs.private_subnet_ids
  eks_cluster_security_group_id = [data.terraform_remote_state.eks.outputs.eks_cluster_security_group_id]
  assume_role_policy = data.aws_iam_policy_document.assume_role.json
  policy_arn = aws_iam_policy.retailstore_db_secret_policy.arn
  cluster_name = data.terraform_remote_state.eks.outputs.eks_cluster_name
}

module "cart_dynamodb" {

  source = "../../modules/cart/dynamodb"

  vpc_id = data.terraform_remote_state.vpc.outputs.aws_vpc
  environment_name = var.environment_name
  business_division = var.business_division

  private_subnet_ids = data.terraform_remote_state.vpc.outputs.private_subnet_ids
  eks_cluster_security_group_id = [data.terraform_remote_state.eks.outputs.eks_cluster_security_group_id]
  assume_role_policy = data.aws_iam_policy_document.assume_role.json
  cluster_name = data.terraform_remote_state.eks.outputs.eks_cluster_name

 }

# module "checkout_redis" {

#   source = "../../modules/checkout/redis"

#   vpc_id = data.terraform_remote_state.vpc.outputs.aws_vpc
#   environment_name = var.environment_name
#   business_division = var.business_division

#   private_subnet_ids = data.terraform_remote_state.vpc.outputs.private_subnet_ids
#   eks_cluster_security_group_id = [data.terraform_remote_state.eks.outputs.eks_cluster_security_group_id]
#   assume_role_policy = data.aws_iam_policy_document.assume_role.json
#   cluster_name = data.terraform_remote_state.eks.outputs.eks_cluster_name
#   policy_arn = aws_iam_policy.retailstore_db_secret_policy.arn
# }

module "orders_postgres_sqs" {

  source = "../../modules/orders/postgres-sqs"
  environment_name = var.environment_name
  business_division = var.business_division

  vpc_id = data.terraform_remote_state.vpc.outputs.aws_vpc

  private_subnet_ids = data.terraform_remote_state.vpc.outputs.private_subnet_ids
  eks_cluster_security_group_id = [data.terraform_remote_state.eks.outputs.eks_cluster_security_group_id]
  assume_role_policy = data.aws_iam_policy_document.assume_role.json
  policy_arn = aws_iam_policy.retailstore_db_secret_policy.arn
  cluster_name = data.terraform_remote_state.eks.outputs.eks_cluster_name
 }