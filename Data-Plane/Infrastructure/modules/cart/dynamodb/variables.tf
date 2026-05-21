variable "aws_region" {
  description = "AWS REGION"
  default = "ap-south-1"
  type = string
}

variable "environment_name" {
  description = "Environment name used in resource name and tags"
  type = string
  default = "dev"
}


variable "business_division" {
  description = "Business Division"
  type = string
  default = "PES(IA)"
}

variable "created_person" {
  description = "person who has created same"
  type = string
  default = "vanbor"
}

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


variable "vpc_id" {
  type = string
}

variable "private_subnet_ids" {
  type = list(string)
}

variable "eks_cluster_security_group_id" {
  type = list(string)
}

variable "assume_role_policy" {
  type = string
}


variable "cluster_name" {
  type = string
}