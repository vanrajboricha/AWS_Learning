variable "aws_region" {
  description = "AWS region to deploy resources"
  type        = string
  default     = "ap-south-1"
}


variable "environment_name" {
  description = "Environment name used in resource names and tags"
  type        = string
  default     = "dev"
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

#variable "tags" {
#  description = "Global tags to apply to all resources"
#  type        = map(string)
#  default     = {
#    Terraform = "true"
#  }
#}

variable "tags" {
  default = {
    Environment = "test"
    DM = "dhaval.mehta@einfochips.com"
    Owner = "vanraj.boricha@einfochips.com"
    Department = "PES-IA"
    EndDate = "31/07/2026"
    BU = "PES"
    Project_Name = "EIC_Internal"
  }
  type = map(string)
}