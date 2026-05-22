
variable "aws_region" {
  description = "AWS region to deploy resources"
  type = string
  default = "ap-south-1"
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
##EKS CLUSTER Configuration
variable "cluster_service_ipv4_cidr" {
  description = "Service CIDR range for k8s service"
  type = string
  default = "null"
}

variable "cluster_endpoint_private_access" {
  description = "Enable private access to EKS control plane endpoint yer or no"
  type = string
  default = false
}

variable "cluster_endpoint_public_access" {
  description = "Enable public access to EKS control plane endpoint yer or no"
  type = string
  default = true
}

variable "cluster_endpoint_public_access_cidrs" {
  description = "List of CIDR blocks allowed to access public EKS endpoint"
  type        = list(string)
  default     = ["0.0.0.0/0"]
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


variable "cluster_version" {
  description = "cluster_version"
  type = string
  default = "null"
}

variable "aws_vpc_main" {
  description = "vpc id"
  type = string
  default = "vpc-02358ddc1cb955bcd"
}

variable "node_capacity_type" {
  description = "Instance capacity type: ON DEMAND or SPOT"
  type = string
  default = "ON_DEMAND"
}

variable "node_instance_types" {
  description = "Node Type"
  type        = list(string)
  default     = ["t3.medium"]
}

variable "node_disk_size" {
  description = "Disk Size for Worker Node"
  type = string
  default = 20
}