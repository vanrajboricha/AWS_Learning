# AWS VPC Provisioning using Terraform

## Overview

This project demonstrates how to provision an Amazon Virtual Private Cloud (VPC) using Terraform.

The Terraform configuration creates and manages foundational AWS networking components required for deploying cloud-native applications and services.

The setup includes:

* VPC creation
* Public and private subnet configuration
* Reusable Terraform variables
* Terraform provider version management
* Data source and local variable usage
* Infrastructure state management

---

# Project Structure

```text id="8v5pqx"
vpc_terraform/
│
├── datasourcesandlocals.tf
├── terraform.tfstate
├── terraform.tfstate.backup
├── variables.tf
├── versions.tf
└── vpc.tf
```

---

# Terraform File Descriptions

| File                       | Purpose                                          |
| -------------------------- | ------------------------------------------------ |
| `versions.tf`              | Defines Terraform and provider versions          |
| `variables.tf`             | Stores configurable Terraform variables          |
| `datasourcesandlocals.tf`  | Contains Terraform data sources and local values |
| `vpc.tf`                   | Main VPC infrastructure configuration            |
| `terraform.tfstate`        | Current Terraform state file                     |
| `terraform.tfstate.backup` | Backup of Terraform state                        |

---

# Infrastructure Components

This Terraform project provisions:

* Amazon VPC
* Public Subnets
* Private Subnets
* Internet Gateway
* Route Tables
* Route Table Associations
* Network configuration resources

---

# Architecture Diagram

```text id="v7l2gx"
                    AWS Cloud
 ┌────────────────────────────────────┐
 │                                    │
 │              VPC                   │
 │                                    │
 │   ┌────────────┐                   │
 │   │ Public     │                   │
 │   │ Subnets    │                   │
 │   └────────────┘                   │
 │          │                         │
 │          ▼                         │
 │    Internet Gateway                │
 │                                    │
 │   ┌────────────┐                   │
 │   │ Private    │                   │
 │   │ Subnets    │                   │
 │   └────────────┘                   │
 │                                    │
 └────────────────────────────────────┘
```

---

# Prerequisites

Before running this project, ensure the following tools are installed and configured:

* AWS Account
* AWS CLI
* Terraform
* IAM permissions for VPC creation

---

# Configure AWS Credentials

Verify AWS CLI configuration:

```bash id="1zv34g"
aws configure
```

Validate identity:

```bash id="p9xtf2"
aws sts get-caller-identity
```

---

# Step-01: Initialize Terraform

Initialize Terraform providers and modules:

```bash id="1k6w0o"
terraform init
```

This downloads required Terraform providers.

---

# Step-02: Validate Configuration

Validate Terraform syntax:

```bash id="i3p2v7"
terraform validate
```

Expected output:

```text id="fzl5x6"
Success! The configuration is valid.
```

---

# Step-03: Review Terraform Plan

Generate execution plan:

```bash id="d6y3ps"
terraform plan
```

This command displays:

* Resources to be created
* Changes Terraform will perform
* Infrastructure preview before deployment

---

# Step-04: Deploy Infrastructure

Apply Terraform configuration:

```bash id="d5m7z8"
terraform apply -auto-approve
```

Terraform provisions the AWS VPC infrastructure automatically.

---

# Step-05: Verify AWS Resources

Verify VPC creation:

```bash id="8f3i0k"
aws ec2 describe-vpcs
```

Verify subnets:

```bash id="q4p8h0"
aws ec2 describe-subnets
```

Verify route tables:

```bash id="v8k7b5"
aws ec2 describe-route-tables
```

---

# Understanding Terraform Files

## versions.tf

Defines:

* Terraform version constraints
* AWS provider version

Example purpose:

* Maintain consistent provider versions
* Avoid compatibility issues

---

## variables.tf

Contains reusable input variables such as:

* AWS region
* VPC CIDR
* Subnet CIDRs
* Environment names

Benefits:

* Easy customization
* Reusable infrastructure code
* Environment-specific deployments

---

## datasourcesandlocals.tf

This file typically contains:

### Data Sources

Used to fetch existing AWS information dynamically.

Example:

* Availability Zones
* Existing VPC details

### Local Values

Used for:

* Naming conventions
* Reusable expressions
* Simplified Terraform code

---

## vpc.tf

Core infrastructure definition file.

Usually includes:

* aws_vpc
* aws_subnet
* aws_internet_gateway
* aws_route_table
* aws_route_table_association

---

# Terraform State Management

Terraform uses:

```text id="s7t7gr"
terraform.tfstate
```

to track deployed infrastructure.

Important Notes:

* Do not manually edit state files
* Store state remotely for production environments
* Protect state files securely

---

# Useful Terraform Commands

## Show Current State

```bash id="v4d5o2"
terraform show
```

## List Managed Resources

```bash id="0t5m1l"
terraform state list
```

## Refresh Infrastructure State

```bash id="0s7n7p"
terraform refresh
```

## Format Terraform Files

```bash id="v7j8o4"
terraform fmt
```

---

# Cleanup Infrastructure

Destroy all created resources:

```bash id="0i2v7u"
terraform destroy -auto-approve
```

Verify deletion:

```bash id="f8g4f4"
aws ec2 describe-vpcs
```

---

# Best Practices

* Use remote backend for state management
* Enable state locking
* Use variables for reusable configurations
* Separate environments using workspaces
* Avoid storing secrets in Terraform files

---

# Key Learnings

* Terraform automates AWS infrastructure provisioning
* VPC is the foundational AWS networking component
* Infrastructure as Code improves consistency
* Terraform state tracks deployed resources
* Variables and locals improve code reusability
* Terraform plans help preview infrastructure changes

---

# Common Terraform Workflow

```text id="z6u2x4"
terraform init
terraform validate
terraform plan
terraform apply
```

---

# Useful AWS Services Related to VPC

* Amazon EC2
* Amazon EKS
* AWS Load Balancer
* NAT Gateway
* Route53
* AWS Transit Gateway

---
