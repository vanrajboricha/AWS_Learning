Here’s a professional `README.md` for your Kubernetes StatefulSet project.

# Kubernetes StatefulSet Deployment

## Overview

This project demonstrates how to deploy and manage stateful applications in Kubernetes using StatefulSets.

The setup includes:

* StatefulSet deployment
* Headless Service configuration
* ClusterIP Service exposure
* ConfigMap integration
* Application Deployment resources
* Stable network identity for Pods

This implementation helps understand the difference between Deployments and StatefulSets and how Kubernetes handles stateful workloads.

---

# Project Structure

```text id="i0ffz5"
statefulset/
│
├── ClusterIP.yaml
├── configmap.yaml
├── deployment.yaml
├── headless-svc.yaml
├── README.md
└── statefulset.yaml
```

---

# Components Description

| File                | Purpose                                  |
| ------------------- | ---------------------------------------- |
| `statefulset.yaml`  | Deploys StatefulSet application          |
| `headless-svc.yaml` | Creates Headless Service for StatefulSet |
| `ClusterIP.yaml`    | Internal application access              |
| `deployment.yaml`   | Standard Kubernetes Deployment           |
| `configmap.yaml`    | Externalized configuration data          |

---

# Learning Objectives

This project helps you understand:

* StatefulSet architecture
* Stable Pod identities
* Ordered Pod creation and deletion
* Headless Services
* Internal Kubernetes networking
* ConfigMap usage
* Difference between StatefulSet and Deployment

---

# StatefulSet Architecture

```text id="y0w1rb"
                 Kubernetes Cluster
 ┌───────────────────────────────────────┐
 │                                       │
 │        Headless Service               │
 │               │                       │
 │               ▼                       │
 │         StatefulSet                   │
 │       ┌──────┼──────┐                 │
 │       ▼      ▼      ▼                 │
 │    Pod-0   Pod-1   Pod-2              │
 │                                       │
 │   Stable DNS and Pod Identity         │
 │                                       │
 │        ClusterIP Service              │
 │             │                         │
 │             ▼                         │
 │        Application Access             │
 │                                       │
 └───────────────────────────────────────┘
```

---

# Prerequisites

Before starting, ensure:

* Kubernetes Cluster is running
* kubectl is configured
* Access to Kubernetes namespace
* Basic understanding of Kubernetes objects

---

# Step-01: Verify Kubernetes Cluster

Check cluster status:

```bash id="x8q7ga"
kubectl cluster-info
```

Verify worker nodes:

```bash id="r9l6bk"
kubectl get nodes
```

---

# Step-02: Create ConfigMap

Apply ConfigMap manifest:

```bash id="vq2t85"
kubectl apply -f configmap.yaml
```

Verify ConfigMap:

```bash id="z3h8s6"
kubectl get configmap
```

Describe ConfigMap:

```bash id="c7v0x2"
kubectl describe configmap
```

---

# Step-03: Create Headless Service

Deploy Headless Service:

```bash id="g1r2kb"
kubectl apply -f headless-svc.yaml
```

Verify Service:

```bash id="q0j3tm"
kubectl get svc
```

Headless Services provide:

* Stable DNS entries
* Direct Pod communication
* StatefulSet network identity

---

# Step-04: Deploy StatefulSet

Apply StatefulSet manifest:

```bash id="m8x5yv"
kubectl apply -f statefulset.yaml
```

Verify StatefulSet:

```bash id="w5g9pz"
kubectl get statefulset
```

Check Pods:

```bash id="p2j7gh"
kubectl get pods
```

Observe ordered Pod naming:

```text id="4wlw5q"
app-0
app-1
app-2
```

---

# Step-05: Deploy ClusterIP Service

Create ClusterIP Service:

```bash id="0ynzpm"
kubectl apply -f ClusterIP.yaml
```

Verify Service:

```bash id="10dwy6"
kubectl get svc
```

---

# Step-06: Deploy Standard Deployment

Deploy additional application resources:

```bash id="p7zv3m"
kubectl apply -f deployment.yaml
```

Verify Deployment:

```bash id="ph2lpr"
kubectl get deployment
```

Check ReplicaSets:

```bash id="4tm9j6"
kubectl get rs
```

---

# Validate StatefulSet Behavior

## Check Stable Pod Names

```bash id="3i9e8f"
kubectl get pods -o wide
```

Pods maintain consistent names even after restart.

---

## Delete a Pod

```bash id="zzg4e0"
kubectl delete pod <pod-name>
```

Kubernetes recreates the Pod with:

* Same identity
* Same hostname
* Same ordering

---

## Verify DNS Resolution

Launch temporary Pod:

```bash id="x8a5q9"
kubectl run dns-test --image=busybox -it --rm -- sh
```

Test Pod DNS:

```bash id="d8h1j2"
nslookup <pod-name>.<headless-service-name>
```

---

# Difference: Deployment vs StatefulSet

| Feature          | Deployment       | StatefulSet |
| ---------------- | ---------------- | ----------- |
| Pod Identity     | Dynamic          | Stable      |
| Pod Naming       | Random           | Ordered     |
| Scaling          | Parallel         | Sequential  |
| Storage          | Shared/Temporary | Persistent  |
| Network Identity | No               | Yes         |

---

# Useful Commands

## View All Resources

```bash id="vk6j4w"
kubectl get all
```

## Watch Pod Creation

```bash id="2zk4mu"
kubectl get pods -w
```

## Describe StatefulSet

```bash id="k2h0vb"
kubectl describe statefulset
```

## Check Logs

```bash id="e0t7xa"
kubectl logs <pod-name>
```

---

# Cleanup

Delete all Kubernetes resources:

```bash id="o3z6n8"
kubectl delete -f .
```

Verify cleanup:

```bash id="t9q0pz"
kubectl get all
```

---

# Key Takeaways

* StatefulSets are designed for stateful applications
* Pods receive stable hostnames and identities
* Headless Services enable direct Pod communication
* StatefulSets manage ordered deployment and scaling
* ConfigMaps externalize configuration management
* ClusterIP Services expose applications internally

---

# Common Use Cases for StatefulSets

* Databases
* Message Queues
* Distributed Systems
* Elasticsearch
* Kafka
* Redis Clusters

---
