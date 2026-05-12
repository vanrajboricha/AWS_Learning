output "public_subnet_ids" {
  value       = aws_subnet.public.id
  description = "List of public subnet IDs"
}

output "private_subnet_ids" {
  value = [ for s in aws_subnet.private : s.id ]
  description = "List of PVT Subnet IDs"
}

output "aws_vpc" {
  value = data.aws_vpc.main
  description = "AWS VPC ID"
}