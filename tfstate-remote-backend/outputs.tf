output "public_subnet_ids" {
  value       = aws_subnet.public
  description = "List of public subnet IDs"
}

output "private_subnet_ids" {
  value       = aws_subnet.public
  description = "List of private subnet IDs"
}