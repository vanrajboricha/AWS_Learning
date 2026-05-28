
# TITLE: Install ExternalDNS on Amazon EKS using Terraform

---

# Step-01: Introduction

In this section, we will install **ExternalDNS** on our Amazon EKS cluster using Terraform.

ExternalDNS automatically manages DNS records in Amazon Route53 for Kubernetes Services and Ingress resources. Whenever a new LoadBalancer Service or Ingress is created, ExternalDNS dynamically creates or updates the corresponding DNS records in Route53.

This eliminates the need for manual DNS management and enables fully automated Kubernetes ingress and service discovery.

In this implementation:

* ExternalDNS will be installed as an Amazon EKS Add-On
* IAM permissions will be configured using EKS Pod Identity
* Route53 permissions will be restricted using least-privilege access
* Terraform will be used to provision and manage all resources

Once configured, your EKS cluster will automatically manage Route53 DNS records for Kubernetes workloads.

---

# Architecture - Amazon EKS Cluster with ExternalDNS

<img width="1766" height="1093" alt="16_02_RetailStore_Ingress_ExternalDNS" src="https://github.com/user-attachments/assets/7eb94c53-180d-4406-abbd-8abf11b8f742" />

## Amazon EKS Cluster with ExternalDNS

![EKS Cluster with ExternalDNS](../images/15_EKS_Cluster_with_ExternalDNS_EKSaddon.png)

---

# Step-02: Copy Existing VPC and EKS Terraform Projects

Reuse the Terraform configurations created in Section-13.

## Reference Projects

* [Section-13](../13_Terraform_EKS_Cluster_with_AddOns/)
* [VPC Terraform Project](../13_Terraform_EKS_Cluster_with_AddOns/01_VPC_terraform-manifests/)
* [EKS Terraform Project](../13_Terraform_EKS_Cluster_with_AddOns/02_EKS_terraform-manifests_with_addons/)

Copy the existing VPC and EKS Terraform manifests, then add the ExternalDNS Terraform configurations to the EKS Terraform project.

---

# Step-03: Review ExternalDNS Terraform Files

## Folder Location

```text
02_EKS_terraform-manifests_with_addons
```

## Terraform Files

1. `c17-01-externaldns-iam-policy-and-role.tf`

   * Creates IAM policy and IAM role for ExternalDNS

2. `c17-02-externaldns-pod-identity-association.tf`

   * Configures EKS Pod Identity association

3. `c17-03-externaldns-eksaddon.tf`

   * Installs ExternalDNS as an EKS Add-On

---

# Step-04: Execute Terraform Commands to Install ExternalDNS

## Important Note

Update the Terraform backend S3 bucket configuration before running Terraform commands.

### Files to Update

```text
vpc/c1-versions.tf
eks/c1_versions.tf
eks/c3_remote-state.tf
```

## Terraform Commands

```bash
# Terraform Initialize
terraform init

# Terraform Validate
terraform validate

# Terraform Plan
terraform plan

# Terraform Apply
terraform apply -auto-approve
```

---

# Step-05: Verify ExternalDNS Installation

## List EKS Add-Ons

```bash
aws eks list-addons --cluster-name retail-dev-eksdemo1
```

## Verify ExternalDNS Deployment

```bash
kubectl -n external-dns get deploy
```

## Verify ExternalDNS Pods

```bash
kubectl -n external-dns get pods
```

## Check ExternalDNS Logs

```bash
kubectl -n external-dns logs -f -l app.kubernetes.io/name=external-dns
```

---

# Expected Outcome

After successful installation:

* ExternalDNS pods should be in `Running` state
* ExternalDNS should automatically monitor Kubernetes Services and Ingress resources
* Route53 DNS records should be created and updated automatically
* DNS management for Kubernetes workloads becomes fully automated

---
