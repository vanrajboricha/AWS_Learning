data "aws_secretsmanager_secret" "retailstore_secret" {
    name = "retailstore-db-secret-vanbor"
}

data "aws_secretsmanager_secret_version" "retailstore_secret_value"{
    secret_id = data.aws_secretsmanager_secret.retailstore_secret.id
}

locals {
  retailstore_secret_json = jsondecode(data.aws_secretsmanager_secret_version.retailstore_secret_value.secret_string)
}

output "debug_secretstore_username" {
  value = local.retailstore_secret_json.username
}

output "debug_secretstore_password" {
  value = local.retailstore_secret_json.password
}