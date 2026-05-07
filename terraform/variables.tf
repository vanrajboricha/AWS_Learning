variable "aws_region" {
  default = "ap-south-1"
  description = "Region Name"
  type = string
}

variable "environment_name" {
  default = "test"
  description = "ENVIRONMENT Name"
  type = string
}

variable "aws_vpc" {
  default = "Bootcamp-vpc-do-not-delete-vpc"
  description = "Which VPC need to pick"
  type = string
}

variable "tags" {
  default = {
    Environment = "test"
    DM = "dhaval.mehta@einfochips.com"
    Owner = "vanraj.boricha@einfochips.com"
    Department = "PES-IA"
    EndDate = "20/07/2026"
  }
  type = map(string)
}
