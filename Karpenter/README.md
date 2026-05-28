


Here’s a professional and structured `README.md` for your Karpenter setup.

# Karpenter Autoscaling Setup on Amazon EKS

## Overview

This project demonstrates how to deploy and configure Karpenter on Amazon EKS using Terraform and Kubernetes manifests.

Karpenter is a high-performance Kubernetes cluster autoscaler that dynamically provisions EC2 instances based on workload requirements. This setup includes:

* Karpenter installation using Terraform
* IAM Roles and Pod Identity configuration
* Spot and On-Demand NodePools
* NodeClass configuration
* EventBridge and SQS interruption handling
* Workload testing for autoscaling scenarios

---

# Solution Architecture

```text id="5w53q0"
Application Workloads
        |
        v
 Kubernetes Scheduler
        |
        v
     Karpenter
        |
        +-----------------------------+
        |                             |
        v                             v
 On-Demand Nodes                Spot Nodes
        |
        v
 Amazon EC2 Instances
```

---

# Features Implemented

* Karpenter deployment using Terraform
* Dynamic EC2 node provisioning
* Spot and On-Demand capacity support
* AWS IAM integration for Karpenter Controller
* EKS Pod Identity association
* Event-driven interruption handling using SQS and EventBridge
* Kubernetes NodePool and EC2NodeClass configuration
* Workload testing manifests

---

# Directory Structure

```text id="k5g6hk"
Karpenter/
│
├── Karpenter_kubernetes_menifest
│   ├── nodeclass.yaml
│   ├── ondemand-nodepool.yaml
│   └── spot-nodepool.yaml
│
├── Karpenter_terraform_manifest
│   ├── datasources_locals.tf
│   ├── helmandk8sproviders.tf
│   ├── karpenter_access_entry.tf
│   ├── karpenter_controller_iam_policy.tf
│   ├── karpenter_controller_iam_role.tf
│   ├── karpenter_event_bridge.tf
│   ├── karpenter_helm.tf
│   ├── karpenter_node_iam_role.tf
│   ├── karpenter_Pod_ID_asso.tf
│   ├── karpenter_sqs_queues.tf
│   ├── remotestate_eks.tf
│   ├── remotestate_vpc.tf
│   ├── variables.tf
│   └── versions.tf
│
├── testing
│   ├── ondemand.yaml
│   ├── PDBandSpotInterruption.yaml
│   └── spot.yaml
│
└── README.md
```

---

# Terraform Components

## Core Infrastructure Files

| File                     | Purpose                          |
| ------------------------ | -------------------------------- |
| `versions.tf`            | Terraform provider versions      |
| `variables.tf`           | Input variables                  |
| `datasources_locals.tf`  | Local variables and data sources |
| `helmandk8sproviders.tf` | Helm and Kubernetes providers    |

---

## Karpenter IAM & Access Configuration

| File                                 | Description                         |
| ------------------------------------ | ----------------------------------- |
| `karpenter_controller_iam_policy.tf` | IAM policy for Karpenter controller |
| `karpenter_controller_iam_role.tf`   | IAM role for Karpenter controller   |
| `karpenter_node_iam_role.tf`         | IAM role for worker nodes           |
| `karpenter_Pod_ID_asso.tf`           | Pod Identity association            |
| `karpenter_access_entry.tf`          | EKS access configuration            |

---

## Event Handling Resources

| File                        | Purpose                                   |
| --------------------------- | ----------------------------------------- |
| `karpenter_event_bridge.tf` | EventBridge rules for interruption events |
| `karpenter_sqs_queues.tf`   | SQS queues for Spot interruption handling |

---

## Karpenter Deployment

| File                | Description                       |
| ------------------- | --------------------------------- |
| `karpenter_helm.tf` | Karpenter Helm chart installation |

---

# Kubernetes Manifests

## Node Configuration

| File                     | Purpose                            |
| ------------------------ | ---------------------------------- |
| `nodeclass.yaml`         | Defines EC2NodeClass configuration |
| `ondemand-nodepool.yaml` | On-Demand NodePool configuration   |
| `spot-nodepool.yaml`     | Spot NodePool configuration        |

---

# Testing Workloads

| File                          | Purpose                                             |
| ----------------------------- | --------------------------------------------------- |
| `ondemand.yaml`               | Testing workloads for On-Demand nodes               |
| `spot.yaml`                   | Testing workloads for Spot nodes                    |
| `PDBandSpotInterruption.yaml` | Pod Disruption Budget and Spot interruption testing |

---

# Prerequisites

Before deployment, ensure the following are available:

* AWS Account
* Existing Amazon EKS Cluster
* Existing VPC
* Terraform installed
* kubectl configured
* AWS CLI configured
* Helm installed

---

# Step-01: Initialize Terraform

Navigate to Terraform manifests directory:

```bash id="k0n5jx"
cd Karpenter_terraform_manifest
```

Initialize Terraform:

```bash id="gm7d4z"
terraform init
```

Validate Terraform configuration:

```bash id="91abf4"
terraform validate
```

Review execution plan:

```bash id="d27e1m"
terraform plan
```

---

# Step-02: Deploy Karpenter Infrastructure

Apply Terraform configuration:

```bash id="w99zpo"
terraform apply -auto-approve
```

This step creates:

* IAM Roles and Policies
* Pod Identity Association
* EventBridge Rules
* SQS Queues
* Karpenter Helm Deployment

---

# Step-03: Verify Karpenter Installation

Check Karpenter namespace:

```bash id="4m8f3h"
kubectl get ns
```

Verify Karpenter Pods:

```bash id="crjlwm"
kubectl get pods -n kube-system
```

Verify Karpenter deployment:

```bash id="0m0y8v"
kubectl get deployment -n kube-system
```

Check logs:

```bash id="gxsfpg"
kubectl logs -n kube-system -l app.kubernetes.io/name=karpenter
```

---

# Step-04: Deploy NodeClass and NodePools

Navigate to Kubernetes manifests:

```bash id="11d5g7"
cd ../Karpenter_kubernetes_menifest
```

Deploy EC2NodeClass:

```bash id="6xoz26"
kubectl apply -f nodeclass.yaml
```

Deploy On-Demand NodePool:

```bash id="p9fy1s"
kubectl apply -f ondemand-nodepool.yaml
```

Deploy Spot NodePool:

```bash id="30b0cf"
kubectl apply -f spot-nodepool.yaml
```

---

# Step-05: Validate Node Provisioning

Check NodePools:

```bash id="k7m2xt"
kubectl get nodepool
```

Check EC2NodeClass:

```bash id="d6od6f"
kubectl get ec2nodeclass
```

Verify nodes:

```bash id="7g8ykf"
kubectl get nodes
```

---

# Step-06: Test Autoscaling

Navigate to testing directory:

```bash id="gvtj0d"
cd ../testing
```

Deploy Spot workload:

```bash id="bz8e7n"
kubectl apply -f spot.yaml
```

Deploy On-Demand workload:

```bash id="3r4k6g"
kubectl apply -f ondemand.yaml
```

Observe automatic node provisioning:

```bash id="8t6m8j"
kubectl get pods -w
```

Monitor nodes:

```bash id="e0gmkm"
kubectl get nodes -w
```

---

# Spot Interruption Handling

Deploy Pod Disruption Budget test:

```bash id="j6ff5d"
kubectl apply -f PDBandSpotInterruption.yaml
```

Karpenter automatically handles:

* Spot interruption notifications
* Graceful Pod eviction
* Replacement node provisioning
* Workload rescheduling

---

# Cleanup

## Delete Testing Workloads

```bash id="t0jxf8"
kubectl delete -f testing/
```

## Delete NodePools

```bash id="bn29ta"
kubectl delete -f Karpenter_kubernetes_menifest/
```

## Destroy Terraform Resources

```bash id="0c5s4f"
cd Karpenter_terraform_manifest

terraform destroy -auto-approve
```

---

# Key Learnings

* Karpenter dynamically provisions Kubernetes worker nodes
* Spot and On-Demand instances can coexist efficiently
* Pod Identity securely connects Kubernetes workloads with AWS services
* EventBridge and SQS enable interruption-aware autoscaling
* NodePools provide workload-specific capacity management
* Karpenter improves cluster scaling speed and cost optimization

---

# Useful Commands

## View Karpenter Resources

```bash id="0mz1t7"
kubectl get nodepool
kubectl get ec2nodeclass
kubectl get nodes
```

## Check Karpenter Logs

```bash id="4r5pdw"
kubectl logs -n kube-system -l app.kubernetes.io/name=karpenter
```

## Monitor Autoscaling

```bash id="39z7e2"
kubectl get pods -A -w
```

---




<img width="1920" height="1200" alt="Screenshot from 2026-05-22 18-28-44" src="https://github.com/user-attachments/assets/00d41943-11bb-4eef-85a3-a52745395072" />

<img width="1920" height="1200" alt="Screenshot from 2026-05-22 17-46-17" src="https://github.com/user-attachments/assets/6d9317c7-6346-4581-bd19-01cc4b33e131" />

<img width="1920" height="1200" alt="Screenshot from 2026-05-22 16-42-06" src="https://github.com/user-attachments/assets/e338dbec-4c1b-4e5b-98db-edebb1debcb9" />


<img width="1907" height="1063" alt="Screenshot from 2026-05-22 16-41-57" src="https://github.com/user-attachments/assets/2e938c56-9324-4a4b-ae92-7e677834a77c" />


<img width="1920" height="1200" alt="Screenshot from 2026-05-22 18-33-48" src="https://github.com/user-attachments/assets/8f0f8127-757f-4b4e-ba1d-c9e111fccb62" />

