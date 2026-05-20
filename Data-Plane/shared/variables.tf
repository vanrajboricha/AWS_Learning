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


variable "cluster_name" {
  description = "Name of the EKS cluster. Also used as a prefix in names of related resources."
  type        = string
  default     = "eks-vanbor"
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
