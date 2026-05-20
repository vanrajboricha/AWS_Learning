resource "aws_sqs_queue" "orders_sqs_queue" {
  name = "orders-sqs-queue-vanbor"
  message_retention_seconds   = 86400     # 1 day
  visibility_timeout_seconds  = 30
  delay_seconds               = 0
  receive_wait_time_seconds   = 10
  tags = var.tags
}

output "orders_sqs_queue_arn" {
  value = aws_sqs_queue.orders_sqs_queue.arn
}