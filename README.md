# AWS_Learning
Here’s a professional and well-structured `README.md` for your complete AWS Learning course repository.

# AWS DevOps & Kubernetes Learning Repository

## Course Overview

This repository contains hands-on implementations, infrastructure automation examples, Kubernetes workloads, observability solutions, CI/CD pipelines, and AWS cloud-native services designed for practical DevOps and Platform Engineering learning.

The course focuses on real-world AWS and Kubernetes scenarios using:

* Terraform
* Amazon EKS
* Docker
* Helm
* ArgoCD
* Karpenter
* OpenTelemetry
* AWS Add-ons
* Kubernetes Networking & Storage
* CI/CD Automation

The repository is structured into modular learning sections, allowing step-by-step understanding of modern cloud infrastructure and Kubernetes ecosystem components.

---

# Learning Objectives

By completing this course, you will learn:

* Infrastructure as Code using Terraform
* AWS networking fundamentals
* Kubernetes core concepts
* Containerization with Docker
* Amazon EKS cluster provisioning
* GitOps using ArgoCD
* Kubernetes autoscaling with Karpenter
* Application deployment using Helm
* Observability with OpenTelemetry
* Persistent storage with EBS CSI Driver
* Kubernetes Ingress and DNS management
* Secure secret management in Kubernetes
* CI/CD pipeline implementation

---

# Repository Structure

```text id="d3q4ly"
AWS_Learning/
│
├── ArgoCD-CI-CD
├── check_topology.sh
├── Data-Plane
├── Docker-Compose
├── DOckerfiles
├── EBS-Volume
├── EKS-Addons
├── EKS_Terraform
├── External-DNS
├── helm
├── HPA&Charts
├── K8s-Ingress
├── K8s-Secrets
├── Karpenter
├── kubernetes-foundation
├── module-vpc
├── OpenTelemetry
├── s3-bucket
├── statefulset
├── terraform
├── tfstate-remote-backend
├── vpc_terraform
└── README.md
```

---

# Course Modules

---

## 1. Terraform Fundamentals

### Directory

```text id="j9u9pm"
terraform/
```

Topics Covered:

* Terraform basics
* Providers and resources
* Variables and outputs
* State management
* Infrastructure provisioning

---

## 2. AWS VPC Automation

### Directories

```text id="9v3bbg"
vpc_terraform/
module-vpc/
```

Topics Covered:

* VPC creation
* Public and private subnets
* Route tables
* Internet Gateway
* Terraform modules
* Reusable infrastructure

---

## 3. Remote Terraform State Management

### Directory

```text id="bg5xtg"
tfstate-remote-backend/
```

Topics Covered:

* Remote backend setup
* S3 backend configuration
* State locking
* Team collaboration

---

## 4. Amazon EKS Provisioning

### Directory

```text id="0tbp8j"
EKS_Terraform/
```

Topics Covered:

* EKS cluster creation
* Managed Node Groups
* IAM Roles
* Terraform automation
* Kubernetes cluster provisioning

---

## 5. Kubernetes Foundations

### Directory

```text id="2qz5s7"
kubernetes-foundation/
```

Topics Covered:

* Pods
* Deployments
* Services
* ConfigMaps
* ClusterIP networking
* Kubernetes basics

---

## 6. Stateful Applications in Kubernetes

### Directory

```text id="o6i8wc"
statefulset/
```

Topics Covered:

* StatefulSets
* Headless Services
* Stable Pod identity
* Stateful workloads

---

## 7. Docker & Containerization

### Directories

```text id="s9j0v1"
DOckerfiles/
Docker-Compose/
```

Topics Covered:

* Docker images
* Dockerfiles
* Multi-container applications
* Docker Compose

---

## 8. Helm Package Management

### Directory

```text id="l8l7v9"
helm/
```

Topics Covered:

* Helm charts
* Templating
* Helm values
* Kubernetes package management

---

## 9. Horizontal Pod Autoscaling

### Directory

```text id="8m7xq5"
HPA&Charts/
```

Topics Covered:

* HPA configuration
* CPU/Memory scaling
* Metrics-based autoscaling

---

## 10. Kubernetes Ingress

### Directory

```text id="j4x9z1"
K8s-Ingress/
```

Topics Covered:

* Ingress Controllers
* Application routing
* HTTP/HTTPS exposure
* Load balancing

---

## 11. Kubernetes Secrets Management

### Directory

```text id="h1q4rk"
K8s-Secrets/
```

Topics Covered:

* Kubernetes Secrets
* Secret mounting
* Environment variables
* Secure configuration management

---

## 12. Amazon EBS CSI Driver

### Directory

```text id="6m3p4u"
EBS-Volume/
```

Topics Covered:

* Persistent Volumes
* Persistent Volume Claims
* StorageClass
* Stateful storage
* EBS CSI integration

---

## 13. EKS Add-ons

### Directory

```text id="x8k5n7"
EKS-Addons/
```

Topics Covered:

* AWS-managed EKS Add-ons
* CSI drivers
* Metrics server
* Cluster integrations

---

## 14. External DNS Integration

### Directory

```text id="y0v5sz"
External-DNS/
```

Topics Covered:

* Route53 automation
* Kubernetes DNS management
* ExternalDNS controller
* Ingress DNS automation

---

## 15. Karpenter Autoscaling

### Directory

```text id="f8m4s9"
Karpenter/
```

Topics Covered:

* Dynamic node provisioning
* Spot and On-Demand nodes
* NodePools
* EC2NodeClass
* Cluster autoscaling optimization

---

## 16. OpenTelemetry Observability

### Directory

```text id="t7z4m1"
OpenTelemetry/
```

Topics Covered:

* Distributed tracing
* Metrics collection
* Log aggregation
* ADOT Collector
* Prometheus integration
* Observability pipelines

---

## 17. GitOps & CI/CD with ArgoCD

### Directory

```text id="r8x2zp"
ArgoCD-CI-CD/
```

Topics Covered:

* GitOps workflows
* ArgoCD deployments
* CI/CD pipelines
* Kubernetes continuous delivery

---

## 18. Data Plane Applications

### Directory

```text id="0f9lq2"
Data-Plane/
```

Topics Covered:

* Application deployment workflows
* Kubernetes runtime services
* Platform operations

---

## 19. S3 Bucket Automation

### Directory

```text id="m5v4a0"
s3-bucket/
```

Topics Covered:

* S3 bucket provisioning
* Terraform automation
* Object storage management

---

# Technologies Used

| Technology    | Purpose                       |
| ------------- | ----------------------------- |
| Terraform     | Infrastructure as Code        |
| AWS           | Cloud Platform                |
| Kubernetes    | Container Orchestration       |
| Docker        | Containerization              |
| Helm          | Kubernetes Package Management |
| ArgoCD        | GitOps CI/CD                  |
| Karpenter     | Kubernetes Autoscaling        |
| OpenTelemetry | Observability                 |
| Prometheus    | Metrics Monitoring            |
| Amazon EKS    | Managed Kubernetes            |
| Amazon EBS    | Persistent Storage            |
| Route53       | DNS Management                |

---

# Prerequisites

Before starting the course, ensure you have:

* AWS Account
* AWS CLI configured
* kubectl installed
* Terraform installed
* Docker installed
* Helm installed
* Basic Linux command knowledge

---

# Recommended Learning Path

```text id="t4r4oe"
Terraform Basics
      ↓
VPC Provisioning
      ↓
Remote Backend Setup
      ↓
EKS Cluster Deployment
      ↓
Kubernetes Fundamentals
      ↓
Docker & Helm
      ↓
Ingress & Secrets
      ↓
Stateful Applications
      ↓
Storage & EBS CSI
      ↓
Autoscaling with HPA & Karpenter
      ↓
Observability with OpenTelemetry
      ↓
GitOps with ArgoCD
```

---

# Common Commands

## Kubernetes

```bash id="j2k4m6"
kubectl get pods
kubectl get svc
kubectl get nodes
```

## Terraform

```bash id="n0r8t3"
terraform init
terraform plan
terraform apply
```

## Helm

```bash id="k8m3x9"
helm list
helm install
helm upgrade
```

---

# Key Outcomes

After completing this course, you will be able to:

* Build production-ready AWS infrastructure
* Deploy and manage Kubernetes applications
* Implement GitOps workflows
* Configure Kubernetes autoscaling
* Manage persistent storage
* Build observability pipelines
* Automate infrastructure provisioning
* Operate cloud-native applications efficiently

---

# Best Practices Covered

* Infrastructure as Code
* GitOps workflows
* Secure secret management
* Autoscaling optimization
* High availability architecture
* Kubernetes resource management
* Observability and monitoring
* Cost optimization strategies

---

# Target Audience

This repository is useful for:

* DevOps Engineers
* Cloud Engineers
* Platform Engineers
* Kubernetes Administrators
* AWS Learners
* SRE Engineers
* Infrastructure Automation Engineers

---

# Conclusion

This repository provides practical exposure to AWS cloud-native technologies and Kubernetes ecosystem tools through real-world implementation examples and infrastructure automation practices.

It is designed to help learners build strong foundational and advanced DevOps skills using modern cloud technologies.

---
