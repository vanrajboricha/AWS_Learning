````markdown
# Terraform AWS S3 Remote State Setup

This project was created to provision an AWS S3 bucket using Terraform and prepare it for storing Terraform remote state files securely.

## What was done

- Configured Terraform with the AWS provider
- Created an S3 bucket in the `ap-south-1` region
- Added a random suffix to the bucket name to avoid naming conflicts
- Enabled server-side encryption using AES256
- Enabled bucket versioning for state recovery and rollback
- Blocked all public access to the bucket
- Added standard project/resource tags for tracking and ownership
- Exported useful outputs like bucket ARN and bucket name

---

## Resources Created

### S3 Bucket

Created bucket:

```bash
tfstate-vanbor-s3-ap-south-1-t4hb
````

Purpose:

* Store Terraform state files remotely
* Centralized and secure state management

---

## Security Configurations

### Public Access Block

Configured the following:

* Block public ACLs
* Block public bucket policies
* Ignore public ACLs
* Restrict public bucket access

### Server-Side Encryption

Enabled AES256 encryption for objects stored in the bucket.

### Versioning

Bucket versioning was enabled to maintain history of Terraform state changes and support recovery if needed.

---

## Tags Applied

| Key         | Value                                                                 |
| ----------- | --------------------------------------------------------------------- |
| Environment | test                                                                  |
| DM          | [dhaval.mehta@einfochips.com](mailto:dhaval.mehta@einfochips.com)     |
| Owner       | [vanraj.boricha@einfochips.com](mailto:vanraj.boricha@einfochips.com) |
| Department  | PES-IA                                                                |
| EndDate     | 20/06/2026                                                            |

---

## Terraform Outputs

| Output             | Description           |
| ------------------ | --------------------- |
| tfstate_bucket_id  | Name of the S3 bucket |
| tfstate_bucket_arn | ARN of the S3 bucket  |

---

## Commands Used

### Initialize Terraform

```bash
terraform init
```

### Validate Configuration

```bash
terraform validate
```

### Preview Infrastructure Changes

```bash
terraform plan
einfochips@91P2S24:~/AWS_Learning/s3-bucket$ terraform plan

Terraform used the selected providers to generate the following execution plan. Resource actions are
indicated with the following symbols:
  + create

Terraform will perform the following actions:

  # aws_s3_bucket.vanbor-s3 will be created
  + resource "aws_s3_bucket" "vanbor-s3" {
      + acceleration_status         = (known after apply)
      + acl                         = (known after apply)
      + arn                         = (known after apply)
      + bucket                      = (known after apply)
      + bucket_domain_name          = (known after apply)
      + bucket_namespace            = (known after apply)
      + bucket_prefix               = (known after apply)
      + bucket_region               = (known after apply)
      + bucket_regional_domain_name = (known after apply)
      + force_destroy               = false
      + hosted_zone_id              = (known after apply)
      + id                          = (known after apply)
      + object_lock_enabled         = (known after apply)
      + policy                      = (known after apply)
      + region                      = "ap-south-1"
      + request_payer               = (known after apply)
      + tags                        = {
          + "DM"          = "dhaval.mehta@einfochips.com"
          + "Department"  = "PES-IA"
          + "EndDate"     = "20/06/2026"
          + "Environment" = "test"
          + "Name"        = "vanbor-s3"
          + "Owner"       = "vanraj.boricha@einfochips.com"
        }
      + tags_all                    = {
          + "DM"          = "dhaval.mehta@einfochips.com"
          + "Department"  = "PES-IA"
          + "EndDate"     = "20/06/2026"
          + "Environment" = "test"
          + "Name"        = "vanbor-s3"
          + "Owner"       = "vanraj.boricha@einfochips.com"
        }
      + website_domain              = (known after apply)
      + website_endpoint            = (known after apply)

      + cors_rule (known after apply)

      + grant (known after apply)

      + lifecycle_rule (known after apply)

      + logging (known after apply)

      + object_lock_configuration (known after apply)

      + replication_configuration (known after apply)

      + server_side_encryption_configuration (known after apply)

      + versioning (known after apply)

      + website (known after apply)
    }

  # aws_s3_bucket_public_access_block.tfstate_block_public will be created
  + resource "aws_s3_bucket_public_access_block" "tfstate_block_public" {
      + block_public_acls       = true
      + block_public_policy     = true
      + bucket                  = (known after apply)
      + id                      = (known after apply)
      + ignore_public_acls      = true
      + region                  = "ap-south-1"
      + restrict_public_buckets = true
    }

  # aws_s3_bucket_server_side_encryption_configuration.tfstate_encryption will be created
  + resource "aws_s3_bucket_server_side_encryption_configuration" "tfstate_encryption" {
      + bucket = (known after apply)
      + id     = (known after apply)
      + region = "ap-south-1"

      + rule {
          + blocked_encryption_types = (known after apply)
          + bucket_key_enabled       = (known after apply)

          + apply_server_side_encryption_by_default {
              + kms_master_key_id = (known after apply)
              + sse_algorithm     = "AES256"
            }
        }
    }

  # aws_s3_bucket_versioning.tfstate_versioning will be created
  + resource "aws_s3_bucket_versioning" "tfstate_versioning" {
      + bucket = (known after apply)
      + id     = (known after apply)
      + region = "ap-south-1"

      + versioning_configuration {
          + mfa_delete = (known after apply)
          + status     = "Enabled"
        }
    }

  # random_string.suffix will be created
  + resource "random_string" "suffix" {
      + id          = (known after apply)
      + length      = 4
      + lower       = true
      + min_lower   = 0
      + min_numeric = 0
      + min_special = 0
      + min_upper   = 0
      + number      = true
      + numeric     = true
      + result      = (known after apply)
      + special     = false
      + upper       = false
    }

Plan: 5 to add, 0 to change, 0 to destroy.

Changes to Outputs:
  + tfstate_bucket_arn = (known after apply)
  + tfstate_bucket_id  = (known after apply)

─────────────────────────────────────────────────────────────────────────────────────────────────────────────

Note: You didn't use the -out option to save this plan, so Terraform can't guarantee to take exactly these
actions if you run "terraform apply" now.

### Create Resources

```bash
terraform apply
```
einfochips@91P2S24:~/AWS_Learning/s3-bucket$ terraform output
tfstate_bucket_arn = "arn:aws:s3:::tfstate-vanbor-s3-ap-south-1-t4hb"
tfstate_bucket_id = "tfstate-vanbor-s3-ap-south-1-t4hb"
---

```
```
