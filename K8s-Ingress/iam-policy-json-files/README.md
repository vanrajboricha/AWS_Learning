Here’s a professional `README.md` draft for your Kubernetes Ingress creation project using AWS Load Balancer Controller on Amazon EKS.

# Kubernetes Ingress Creation using AWS Load Balancer Controller on Amazon EKS

---

# Overview

This project demonstrates how to create Kubernetes Ingress resources on Amazon EKS using the AWS Load Balancer Controller.

The AWS Load Balancer Controller automatically provisions and manages:

* Application Load Balancers (ALB)
* Target Groups
* Listeners
* Routing Rules

for Kubernetes Ingress resources.

The project includes:

* IAM policies for AWS Load Balancer Controller
* IAM trust relationship configuration
* Kubernetes Ingress manifests
* ALB Ingress configuration examples

---

# Project Structure

```text id="c77k9l"
iam-policy-json-files/
├── aws-load-balancer-controller-policy.json
├── aws-load-balancer-controller-trust-policy.json
├── ingress_http_mode.yaml
└── ingress_ip_mode.yaml
```

---

# File Descriptions

## 1. aws-load-balancer-controller-policy.json

IAM policy required for AWS Load Balancer Controller.

This policy grants permissions to:

* Create and manage ALBs
* Configure Target Groups
* Register Kubernetes pods/instances
* Manage listeners and routing rules
* Integrate with AWS networking resources

---

## 2. aws-load-balancer-controller-trust-policy.json

IAM trust policy used for:

* IAM Role for Service Account (IRSA)
* EKS Pod Identity integration

Allows Kubernetes service accounts to assume IAM roles securely.

---

## 3. ingress_http_mode.yaml

Ingress manifest using:

* HTTP routing
* Instance target mode

Traffic flow:

```text id="mjlwm4"
ALB → NodePort Service → Kubernetes Nodes → Pods
```

---

## 4. ingress_ip_mode.yaml

Ingress manifest using:

* IP target mode
* Direct pod routing

Traffic flow:

```text id="aq3n0f"
ALB → Pod IPs directly
```

Benefits:

* Better performance
* Reduced network hops
* Native pod-level load balancing

---

# Architecture

## AWS EKS with ALB Ingress Controller

```text id="7nrlra"
Internet
   │
   ▼
Application Load Balancer (ALB)
   │
   ▼
Kubernetes Ingress
   │
   ▼
Kubernetes Services
   │
   ▼
Pods
```

---

# Prerequisites

Before proceeding, ensure the following are installed and configured:

* AWS CLI
* kubectl
* eksctl
* Helm v3+
* Amazon EKS Cluster
* OIDC Provider enabled for EKS

---

# Step-01: Associate IAM OIDC Provider

```bash id="t7bjlwm"
eksctl utils associate-iam-oidc-provider \
  --region ap-south-1 \
  --cluster <cluster-name> \
  --approve
```

---

# Step-02: Create IAM Policy

```bash id="knb5os"
aws iam create-policy \
  --policy-name AWSLoadBalancerControllerIAMPolicy \
  --policy-document file://aws-load-balancer-controller-policy.json
```

---

# Step-03: Create IAM Service Account

```bash id="l8w2ef"
eksctl create iamserviceaccount \
  --cluster=<cluster-name> \
  --namespace=kube-system \
  --name=aws-load-balancer-controller \
  --attach-policy-arn=arn:aws:iam::<account-id>:policy/AWSLoadBalancerControllerIAMPolicy \
  --override-existing-serviceaccounts \
  --approve
```

---

# Step-04: Install AWS Load Balancer Controller

## Add Helm Repository

```bash id="cbxqfh"
helm repo add eks https://aws.github.io/eks-charts
helm repo update
```

---

## Install Controller

```bash id="wnjlwm"
helm install aws-load-balancer-controller eks/aws-load-balancer-controller \
  -n kube-system \
  --set clusterName=<cluster-name> \
  --set serviceAccount.create=false \
  --set serviceAccount.name=aws-load-balancer-controller \
  --set region=ap-south-1 \
  --set vpcId=<vpc-id>
```

---

# Step-05: Verify Controller Installation

```bash id="fefq8s"
kubectl get deployment -n kube-system aws-load-balancer-controller
```

```bash id="0a5gze"
kubectl get pods -n kube-system
```

---

# Step-06: Deploy Sample Application

```bash id="2gmjlwm"
kubectl apply -f app-deployment.yaml
kubectl apply -f app-service.yaml
```

---

# Step-07: Create Kubernetes Ingress

## HTTP Mode Ingress

```bash id="jlwmte"
kubectl apply -f ingress_http_mode.yaml
```

---

## IP Mode Ingress

```bash id="zvjlwm"
kubectl apply -f ingress_ip_mode.yaml
```

---

# Step-08: Verify Ingress

```bash id="9w2ktl"
kubectl get ingress
```

Example Output:

```text id="8cqtmy"
NAME          CLASS   HOSTS   ADDRESS
sample-app    alb     *       k8s-default-xxxx.ap-south-1.elb.amazonaws.com
```

---

# Step-09: Access Application

# Important Ingress Annotations

## Common ALB Annotations

```yaml id="ybfc6t"
alb.ingress.kubernetes.io/scheme: internet-facing
alb.ingress.kubernetes.io/target-type: ip
alb.ingress.kubernetes.io/listen-ports: '[{"HTTP":80}]'
alb.ingress.kubernetes.io/healthcheck-path: /
```

---

# Instance Mode vs IP Mode

| Feature       | Instance Mode    | IP Mode            |
| ------------- | ---------------- | ------------------ |
| Routing       | Through NodePort | Direct Pod Routing |
| Performance   | Moderate         | Better             |
| Network Hops  | More             | Fewer              |
| Pod Awareness | No               | Yes                |
| Recommended   | Older setups     | Modern EKS         |

---

# Verify AWS Resources

## List ALBs

```bash id="qjlwmu"
aws elbv2 describe-load-balancers
```

---

## List Target Groups

```bash id="kjlwmf"
aws elbv2 describe-target-groups
```

---

# Cleanup

## Delete Ingress

```bash id="hz3q2l"
kubectl delete -f ingress_http_mode.yaml
kubectl delete -f ingress_ip_mode.yaml
```

---

## Uninstall AWS Load Balancer Controller

```bash id="lfjlwm"
helm uninstall aws-load-balancer-controller -n kube-system
```

---

# Benefits of AWS Load Balancer Controller

* Automatic ALB provisioning
* Native Kubernetes Ingress integration
* Dynamic target registration
* SSL/TLS support
* Path-based routing
* Host-based routing
* Better scalability
* AWS-native integration

---

# Technologies Used

* Kubernetes
* Amazon EKS
* AWS Load Balancer Controller
* Application Load Balancer (ALB)
* IAM Roles for Service Accounts (IRSA)
* Helm
* AWS CLI

---

# Author

Cloud Native / DevOps Learning Project

---

