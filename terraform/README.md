STEP1 : Create versions.tf file for terraform

Under versions.tf file mention minimum terraform supported version.
Also provide aws and random provider minimum version inside there.

STEP2: Create s3bucket.tf file and outputs.tf file to create aws s3 bucket

Make sure to mention resources that you wants to create. 
Please use mandatory tags that are required to use.

Create outputs.tf file whichever file you wants to create.

STEP3: DO Terraform Validate and Terraform Plan

einfochips@91P2S24:~/AWS_DevOps_BootCamp/terraform$ terraform validate
Success! The configuration is valid.

einfochips@91P2S24:~/AWS_DevOps_BootCamp/terraform$ terraform plan

Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with the following symbols:
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
          + "Owner"       = "vanraj.boricha@einfochips.com"
        }
      + tags_all                    = {
          + "DM"          = "dhaval.mehta@einfochips.com"
          + "Department"  = "PES-IA"
          + "EndDate"     = "20/06/2026"
          + "Environment" = "test"
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

Plan: 2 to add, 0 to change, 0 to destroy.

Changes to Outputs:
  + s3_bucket_arn  = (known after apply)
  + s3_bucket_id   = (known after apply)
  + s3_bucket_name = (known after apply)

─────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────

Note: You didn't use the -out option to save this plan, so Terraform can't guarantee to take exactly these actions if you run "terraform apply"
now.


STEP 4 : DO Terraform Apply and Destroy.

We can apply once validation and Plan has been verified.

einfochips@91P2S24:~/AWS_DevOps_BootCamp/terraform$ terraform apply s3planoutv1 
aws_s3_bucket.vanbor-s3: Modifying... [id=vanbor-s3-rmhv]
aws_s3_bucket.vanbor-s3: Modifications complete after 1s [id=vanbor-s3-rmhv]

Apply complete! Resources: 0 added, 1 changed, 0 destroyed.

Outputs:

s3_bucket_arn = "arn:aws:s3:::vanbor-s3-rmhv"
s3_bucket_id = "vanbor-s3-rmhv"
s3_bucket_name = "vanbor-s3-rmhv"

----------------------------------------

Plan: 0 to add, 0 to change, 2 to destroy.

Changes to Outputs:
  - s3_bucket_arn  = "arn:aws:s3:::vanbor-s3-rmhv" -> null
  - s3_bucket_id   = "vanbor-s3-rmhv" -> null
  - s3_bucket_name = "vanbor-s3-rmhv" -> null

Do you really want to destroy all resources?
  Terraform will destroy all your managed infrastructure, as shown above.
  There is no undo. Only 'yes' will be accepted to confirm.

  Enter a value: yes

aws_s3_bucket.vanbor-s3: Destroying... [id=vanbor-s3-rmhv]
aws_s3_bucket.vanbor-s3: Destruction complete after 0s
random_string.suffix: Destroying... [id=rmhv]
random_string.suffix: Destruction complete after 0s

Destroy complete! Resources: 2 destroyed.


STEP 5 : 
