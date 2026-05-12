

````markdown id="qv48lv"
# Terraform AWS VPC Module

This Terraform module provisions networking resources inside AWS.

The module creates:

- VPC
- Public subnet
- Private subnets
- Public route table
- Private route table
- Route table associations
- Internet Gateway routing
- NAT Gateway routing

---

# Architecture

## Public Resources
- 1 Public Subnet
- Public Route Table
- Internet Gateway Route

## Private Resources
- Multiple Private Subnets
- Private Route Table
- NAT Gateway Route

---

# Module Structure

```text
.
├── main.tf
├── variables.tf
├── outputs.tf
├── terraform.tfvars
└── modules
    └── vpc
        ├── main.tf
        ├── variables.tf
        └── outputs.tf
```

---

# Root Module Usage

The VPC module is called from the root directory as shown below:

```hcl
module "vpc" {
  source = "./modules/vpc"

  vpc_cidr         = var.vpc_cidr
  tags             = var.tags
  environment_name = var.environment_name
  aws_region       = var.aws_region
}
```

---

# Resources Created

| Resource | Description |
|----------|-------------|
| `aws_vpc` | Creates VPC |
| `aws_subnet.public` | Creates public subnet |
| `aws_subnet.private` | Creates private subnets |
| `aws_route_table.public_rt` | Public route table |
| `aws_route_table.private_rt` | Private route table |
| `aws_route_table_association.public_rt_assoc` | Public subnet route association |
| `aws_route_table_association.private_rt_assoc` | Private subnet route associations |

---

# Variables

## Root Module Variables

| Name | Description | Type |
|------|-------------|------|
| `vpc_cidr` | CIDR block for VPC | `string` |
| `environment_name` | Environment name | `string` |
| `aws_region` | AWS region | `string` |
| `tags` | Common tags | `map(string)` |

---

# Example terraform.tfvars

```hcl
vpc_cidr = "10.0.0.0/16"

environment_name = "dev"

aws_region = "ap-south-1"

tags = {
  Project     = "k8s-basic"
  Environment = "dev"
  Owner       = "vanraj"
}
```

---

# Public Subnet

Creates a public subnet with:

- Internet access via Internet Gateway
- Public Route Table association

Example route:

```text
0.0.0.0/0 --> Internet Gateway
```

---

# Private Subnets

Creates private subnets dynamically across Availability Zones.

Private subnet traffic is routed through the NAT Gateway:

```text
0.0.0.0/0 --> NAT Gateway
```

---

# Tags

All resources use common tags provided through:

```hcl
var.tags
```

Additional `Name` tags are automatically added.

---

# Terraform Workflow

## Initialize Terraform

```bash
terraform init
```

## Validate Configuration

```bash
terraform validate
```

## Preview Infrastructure Changes

```bash
terraform plan
```

## Apply Infrastructure

```bash
terraform apply
```

## Destroy Infrastructure

```bash
terraform destroy
```

---

# Outputs

Example outputs that can be exported:

| Output | Description |
|--------|-------------|
| `vpc_id` | Created VPC ID |
| `public_subnet_id` | Public subnet ID |
| `private_subnet_ids` | List of private subnet IDs |

---

# Notes

- Public subnet is intended for internet-facing workloads.
- Private subnets are intended for internal services.
- NAT Gateway allows outbound internet access for private resources.
- Multi-AZ deployment improves availability.
- Module supports reusable infrastructure deployment across environments.
````
