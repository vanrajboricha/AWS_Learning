

# Amazon EBS CSI Driver Integration with Catalog MySQL StatefulSet on EKS

## Overview

This project demonstrates how to integrate the Amazon EBS CSI Driver with a MySQL StatefulSet running on Amazon EKS.

The setup includes:

* Dynamic provisioning of Amazon EBS volumes using a Kubernetes StorageClass
* Persistent storage integration with MySQL StatefulSet
* Replacement of `emptyDir` volumes with durable EBS-backed Persistent Volumes
* Validation of data persistence across Pod restarts
* Observation of EBS volume lifecycle management
* Integration of EKS Pod Identity with AWS Secrets Manager for secure secret access

---

# Architecture

```text
EKS Cluster
   |
   |-- Amazon EBS CSI Driver
   |       |
   |       --> Dynamically provisions EBS Volumes
   |
   |-- StorageClass (gp2/gp3)
   |
   |-- PersistentVolumeClaim
   |
   |-- MySQL StatefulSet
   |       |
   |       --> Mounted Persistent Storage
   |
   |-- AWS Secrets Manager
   |
   |-- SecretProviderClass
   |
   |-- EKS Pod Identity / IAM Role
```

---

# Objectives

* Integrate Amazon EBS CSI Driver with Kubernetes workloads
* Create dynamic EBS-backed storage using StorageClass
* Deploy MySQL StatefulSet with persistent storage
* Verify persistent data after Pod recreation
* Securely access secrets using AWS Secrets Manager
* Understand EBS volume lifecycle in Kubernetes

---

# Prerequisites

* AWS Account
* Amazon EKS Cluster
* kubectl configured
* AWS CLI configured
* Amazon EBS CSI Driver installed on EKS
* IAM permissions for EBS and Secrets Manager
* EKS Pod Identity configured

---

# Project Structure

```text
catalog-manifest-files/
│
├── catalog-db-secret-policy.json
├── ClusterIP.yaml
├── configmap.yaml
├── deployment.yaml
├── headless-svc.yaml
├── README.md
├── secret-provider-class.yaml
├── secrets.yaml
├── serviceaccount.yaml
├── statefulset.yaml
├── storage-class-ebs.yaml
└── trust-policy.json
```

---

# Components Description

| File                            | Purpose                                           |
| ------------------------------- | ------------------------------------------------- |
| `storage-class-ebs.yaml`        | Creates EBS-backed StorageClass                   |
| `statefulset.yaml`              | Deploys MySQL StatefulSet with persistent storage |
| `deployment.yaml`               | Deploys catalog application                       |
| `headless-svc.yaml`             | Headless service for StatefulSet                  |
| `ClusterIP.yaml`                | Internal service exposure                         |
| `configmap.yaml`                | Application configuration                         |
| `serviceaccount.yaml`           | Kubernetes Service Account for Pod Identity       |
| `secret-provider-class.yaml`    | CSI Secret Store integration                      |
| `secrets.yaml`                  | Kubernetes secrets configuration                  |
| `catalog-db-secret-policy.json` | IAM policy for Secrets Manager access             |
| `trust-policy.json`             | IAM trust relationship configuration              |

---

# Step 1: Create StorageClass

Apply the EBS StorageClass:

```bash
kubectl apply -f storage-class-ebs.yaml
```

Verify:

```bash
kubectl get storageclass
```

---

# Step 2: Configure IAM and Pod Identity

Create IAM policy:

```bash
aws iam create-policy \
  --policy-name CatalogDBSecretPolicy \
  --policy-document file://catalog-db-secret-policy.json
```

Create trust policy using:

```bash
trust-policy.json
```

Associate IAM role with Kubernetes Service Account.

Apply Service Account:

```bash
kubectl apply -f serviceaccount.yaml
```

---

# Step 3: Configure Secrets Store CSI Driver

Apply SecretProviderClass:

```bash
kubectl apply -f secret-provider-class.yaml
```

Verify:

```bash
kubectl get secretproviderclass
```

---

# Step 4: Deploy MySQL StatefulSet

Deploy StatefulSet and services:

```bash
kubectl apply -f headless-svc.yaml
kubectl apply -f statefulset.yaml
kubectl apply -f ClusterIP.yaml
```

Verify Pods:

```bash
kubectl get pods
```

Verify PVC creation:

```bash
kubectl get pvc
```

Verify PV creation:

```bash
kubectl get pv
```

---

# Step 5: Deploy Catalog Application

Apply application deployment:

```bash
kubectl apply -f configmap.yaml
kubectl apply -f deployment.yaml
```

Verify:

```bash
kubectl get deployments
kubectl get svc
```

---

# Validate Persistent Storage

## Insert Sample Data

Access MySQL Pod:

```bash
kubectl exec -it <mysql-pod-name> -- bash
```

Login to MySQL:

```bash
mysql -u root -p
```

Create sample database/table and insert records.

---

## Restart Pod

Delete MySQL Pod:

```bash
kubectl delete pod <mysql-pod-name>
```

Kubernetes recreates the Pod automatically.

---

## Verify Data Persistence

Reconnect to MySQL and confirm data still exists.

This validates persistent EBS-backed storage.

---

# Observe EBS Volume Lifecycle

List Persistent Volumes:

```bash
kubectl get pv
```

List Persistent Volume Claims:

```bash
kubectl get pvc
```

Verify EBS volume in AWS:

```bash
aws ec2 describe-volumes
```

Observe:

* Volume creation during PVC provisioning
* Volume attachment to worker node
* Volume detachment during Pod rescheduling
* Volume deletion based on reclaim policy

---

# Cleanup

Delete resources:

```bash
kubectl delete -f deployment.yaml
kubectl delete -f statefulset.yaml
kubectl delete -f ClusterIP.yaml
kubectl delete -f headless-svc.yaml
kubectl delete -f configmap.yaml
kubectl delete -f serviceaccount.yaml
kubectl delete -f secret-provider-class.yaml
kubectl delete -f storage-class-ebs.yaml
```

Verify cleanup:

```bash
kubectl get pvc
kubectl get pv
```

---

# Key Learnings

* Amazon EBS CSI Driver enables dynamic persistent storage provisioning
* StatefulSets maintain stable storage identity
* EBS volumes preserve MySQL data across Pod restarts
* Kubernetes PVC/PV lifecycle maps directly to AWS EBS lifecycle
* EKS Pod Identity securely integrates workloads with AWS Secrets Manager

---

# References

* Amazon EBS CSI Driver
* Amazon EKS Documentation
* Kubernetes StatefulSet Documentation
* AWS Secrets Manager
* Secrets Store CSI Driver


<img width="1920" height="1200" alt="Screenshot from 2026-05-14 11-53-47" src="https://github.com/user-attachments/assets/92ba6a32-e2c9-46e9-b489-46bd68d17ac5" />

<img width="1920" height="1200" alt="Screenshot from 2026-05-14 12-56-09" src="https://github.com/user-attachments/assets/7aef8f16-d1b4-4372-8f1e-ff23fddb72e3" />

<img width="1920" height="1200" alt="Screenshot from 2026-05-14 12-56-17" src="https://github.com/user-attachments/assets/0d6c672f-cae5-4a9d-a004-33751e728cfa" />

<img width="1920" height="1200" alt="Screenshot from 2026-05-14 14-28-16" src="https://github.com/user-attachments/assets/f745034a-b186-4374-98e0-eb9747a69790" />

<img width="1920" height="1200" alt="Screenshot from 2026-05-14 14-32-29" src="https://github.com/user-attachments/assets/623ab0e8-27a8-4f0a-88cb-9afa057c9313" />

<img width="1920" height="1200" alt="Screenshot from 2026-05-14 14-32-39" src="https://github.com/user-attachments/assets/934dc002-a0e9-49e0-b201-3eea07d9bfdb" />

<img width="1920" height="1200" alt="Screenshot from 2026-05-14 14-32-52" src="https://github.com/user-attachments/assets/45d02ee6-96c7-470e-a2f9-de42018c5c23" />
