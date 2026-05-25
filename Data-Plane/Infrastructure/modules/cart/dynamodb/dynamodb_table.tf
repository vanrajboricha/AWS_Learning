resource "aws_dynamodb_table" "items_ap-south-1" {
  provider       = aws
  name           = "vanbor-Items"
  billing_mode   = "PAY_PER_REQUEST"    # On-demand pricing (no capacity planning)
  hash_key       = "id"

  attribute {
    name = "id"
    type = "S"
  }

  attribute {
    name = "customerId"
    type = "S"
  }

  # Global Secondary Index for customer-based lookups
  global_secondary_index {
    name               = "idx_global_customerId"
    key_schema {
      attribute_name = "customerId"
      key_type       = "HASH"
    }
    projection_type    = "ALL"
  }

tags = var.tags
}