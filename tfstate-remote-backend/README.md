````markdown
# Terraform AWS Subnet and Route Table Setup

This Terraform configuration was created to provision public and private subnets inside an existing AWS VPC along with their respective route tables and associations.

The setup helps separate internet-facing resources from internal/private resources following standard AWS networking practices.

---

## Resources Created

### Public Subnet

A public subnet was created with the following CIDR block:

```bash
10.0.24.0/24
````

Subnet Name:

```bash
vanbor-subnet-public
```

Purpose:

* Host public resources
* Allow internet access through Internet Gateway
* Suitable for bastion hosts, load balancers, or public-facing services

---

### Private Subnet

A private subnet was created with the following CIDR block:

```bash
10.0.124.0/24
```

Subnet Name:

```bash
vanbor-subnet-private
```

Purpose:

* Host internal/private resources
* Internet access provided through NAT Gateway
* Suitable for application servers or backend services

---

## Route Tables

### Public Route Table

A public route table was created and associated with the public subnet.

Configured route:

```bash
0.0.0.0/0 → Internet Gateway
```

Route Table Name:

```bash
vanbor-public-rt
```

This allows outbound internet connectivity from resources inside the public subnet.

---

### Private Route Table

A private route table was created and associated with the private subnet.

Configured route:

```bash
0.0.0.0/0 → NAT Gateway
```

Route Table Name:

```bash
vanbor-private-rt
```

This enables private resources to access the internet securely without exposing them directly.

---

## Route Table Associations

The following associations were configured:

| Subnet         | Route Table         |
| -------------- | ------------------- |
| Public Subnet  | Public Route Table  |
| Private Subnet | Private Route Table |

---

## Terraform Features Used

* AWS Subnet resources
* AWS Route Tables
* Route Table Associations
* Existing VPC Data Source
* Existing Internet Gateway Data Source
* Existing NAT Gateway Data Source
* `merge()` function for tag management

---

## Tags Applied

Common tags were inherited using the `merge(var.tags)` function along with custom resource names.

Example tags:

| Key         | Value                                                                 |
| ----------- | --------------------------------------------------------------------- |
| Environment | test                                                                  |
| Department  | PES-IA                                                                |
| Owner       | [vanraj.boricha@einfochips.com](mailto:vanraj.boricha@einfochips.com) |

---

## Commands Used

### Initialize Terraform

```bash
terraform init
```

### Validate Terraform Configuration

```bash
terraform validate
```

### Preview Changes

```bash
terraform plan
```

### Apply Infrastructure

```bash
terraform apply
Outputs:

private_subnet_ids = {
  "assign_ipv6_address_on_creation" = false
  "availability_zone" = "ap-south-1a"
  "availability_zone_id" = "aps1-az1"
  "cidr_block" = "10.0.24.0/24"
  "customer_owned_ipv4_pool" = ""
  "enable_dns64" = false
  "enable_lni_at_device_index" = 0
  "enable_resource_name_dns_a_record_on_launch" = false
  "enable_resource_name_dns_aaaa_record_on_launch" = false
  "id" = "subnet-0e2543c01fe8bcdc7"
  "ipv4_ipam_pool_id" = tostring(null)
  "ipv4_netmask_length" = tonumber(null)
  "ipv6_cidr_block" = ""
  "ipv6_cidr_block_association_id" = ""
  "ipv6_ipam_pool_id" = tostring(null)
  "ipv6_native" = false
  "ipv6_netmask_length" = tonumber(null)
  "map_customer_owned_ip_on_launch" = false
  "map_public_ip_on_launch" = false
  "outpost_arn" = ""
  "owner_id" = "454143665149"
  "private_dns_hostname_type_on_launch" = "ip-name"
  "region" = "ap-south-1"
  "tags" = tomap({
    "DM" = "dhaval.mehta@einfochips.com"
    "Department" = "PES-IA"
    "EndDate" = "31/07/2026"
    "Environment" = "test"
    "Name" = "vanbor-subnet-public"
    "Owner" = "vanraj.boricha@einfochips.com"
  })
  "tags_all" = tomap({
    "DM" = "dhaval.mehta@einfochips.com"
    "Department" = "PES-IA"
    "EndDate" = "31/07/2026"
    "Environment" = "test"
    "Name" = "vanbor-subnet-public"
    "Owner" = "vanraj.boricha@einfochips.com"
  })
  "timeouts" = null /* object */
  "vpc_id" = "vpc-02358ddc1cb955bcd"
}
public_subnet_ids = {
  "assign_ipv6_address_on_creation" = false
  "availability_zone" = "ap-south-1a"
  "availability_zone_id" = "aps1-az1"
  "cidr_block" = "10.0.24.0/24"
  "customer_owned_ipv4_pool" = ""
  "enable_dns64" = false
  "enable_lni_at_device_index" = 0
  "enable_resource_name_dns_a_record_on_launch" = false
  "enable_resource_name_dns_aaaa_record_on_launch" = false
  "id" = "subnet-0e2543c01fe8bcdc7"
  "ipv4_ipam_pool_id" = tostring(null)
  "ipv4_netmask_length" = tonumber(null)
  "ipv6_cidr_block" = ""
  "ipv6_cidr_block_association_id" = ""
  "ipv6_ipam_pool_id" = tostring(null)
  "ipv6_native" = false
  "ipv6_netmask_length" = tonumber(null)
  "map_customer_owned_ip_on_launch" = false
  "map_public_ip_on_launch" = false
  "outpost_arn" = ""
  "owner_id" = "454143665149"
  "private_dns_hostname_type_on_launch" = "ip-name"
  "region" = "ap-south-1"
  "tags" = tomap({
    "DM" = "dhaval.mehta@einfochips.com"
    "Department" = "PES-IA"
    "EndDate" = "31/07/2026"
    "Environment" = "test"
    "Name" = "vanbor-subnet-public"
    "Owner" = "vanraj.boricha@einfochips.com"
  })
  "tags_all" = tomap({
    "DM" = "dhaval.mehta@einfochips.com"
    "Department" = "PES-IA"
    "EndDate" = "31/07/2026"
    "Environment" = "test"
    "Name" = "vanbor-subnet-public"
    "Owner" = "vanraj.boricha@einfochips.com"
  })
  "timeouts" = null /* object */
  "vpc_id" = "vpc-02358ddc1cb955bcd"
}

---

```
```
