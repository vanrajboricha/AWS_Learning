

Here’s a clean and professional `README.md` for your Kubernetes foundation project.

# Kubernetes Foundation - Basic Kubernetes Resources

## Overview

This project demonstrates the foundational Kubernetes objects required to deploy and expose an application inside a Kubernetes cluster.

The setup includes:

* Pod creation
* Deployment management
* ConfigMap usage
* ClusterIP Service exposure
* Basic Kubernetes resource validation

This project is intended for beginners learning Kubernetes core concepts and resource interactions.

---

# Project Structure

```text id="l9s0zv"
kubernetes-foundation/
│
└── k8s-basic
    ├── clusterip-svc.yaml
    ├── configmap.yaml
    ├── deployment.yaml
    ├── pod.yaml
    └── README.md
```

---

# Kubernetes Resources Used

| File                 | Description                                           |
| -------------------- | ----------------------------------------------------- |
| `pod.yaml`           | Creates a standalone Kubernetes Pod                   |
| `deployment.yaml`    | Creates a Deployment for managing replicas            |
| `configmap.yaml`     | Stores configuration data for applications            |
| `clusterip-svc.yaml` | Exposes the application internally within the cluster |

---

# Learning Objectives

By completing this project, you will understand:

* How Pods work in Kubernetes
* Difference between Pod and Deployment
* How Deployments manage application replicas
* How ConfigMaps externalize configuration
* How ClusterIP Services enable internal communication
* Basic kubectl commands for managing workloads

---

# Architecture Diagram

```text id="o7ex3m"
                 Kubernetes Cluster
 ┌─────────────────────────────────────────┐
 │                                         │
 │      ClusterIP Service                  │
 │               │                         │
 │               ▼                         │
 │         Deployment                      │
 │               │                         │
 │        ┌──────┴──────┐                  │
 │        ▼             ▼                  │
 │      Pod-1         Pod-2                │
 │                                         │
 │        ConfigMap provides               │
 │        application configuration        │
 │                                         │
 └─────────────────────────────────────────┘
```

---

# Prerequisites

Ensure the following tools are installed:

* Kubernetes Cluster

  * Minikube / Kind / Amazon EKS / Docker Desktop Kubernetes
* kubectl CLI
* Docker (optional for custom images)

---

# Step-01: Verify Kubernetes Cluster

Check cluster connectivity:

```bash id="mf8wwf"
kubectl cluster-info
```

Verify nodes:

```bash id="chv9q8"
kubectl get nodes
```

---

# Step-02: Create ConfigMap

Apply ConfigMap configuration:

```bash id="93fwv0"
kubectl apply -f configmap.yaml
```

Verify ConfigMap:

```bash id="8y3d6o"
kubectl get configmap
```

Describe ConfigMap:

```bash id="5m6tlj"
kubectl describe configmap
```

---

# Step-03: Deploy Standalone Pod

Create Pod:

```bash id="3emrxq"
kubectl apply -f pod.yaml
```

Verify Pod status:

```bash id="98y2yo"
kubectl get pods
```

Describe Pod:

```bash id="0n8c0u"
kubectl describe pod <pod-name>
```

View Pod logs:

```bash id="g18n8z"
kubectl logs <pod-name>
```

---

# Step-04: Create Deployment

Deploy application using Deployment resource:

```bash id="v0p6vn"
kubectl apply -f deployment.yaml
```

Verify Deployment:

```bash id="p3br5l"
kubectl get deployments
```

Check ReplicaSets:

```bash id="wl40mf"
kubectl get replicasets
```

Check Pods:

```bash id="z6mtlo"
kubectl get pods
```

---

# Step-05: Expose Application using ClusterIP Service

Apply Service manifest:

```bash id="q6i5f3"
kubectl apply -f clusterip-svc.yaml
```

Verify Service:

```bash id="jlwm5u"
kubectl get svc
```

Describe Service:

```bash id="k9x7l0"
kubectl describe svc <service-name>
```

---

# Access Application Internally

Since ClusterIP services are only accessible inside the cluster, test connectivity from another Pod:

```bash id="g0xk5u"
kubectl run test-pod --image=busybox -it --rm -- sh
```

Inside the Pod:

```bash id="h3s7l9"
wget -qO- http://<service-name>
```

---

# Useful Kubernetes Commands

## View All Resources

```bash id="9t0n7q"
kubectl get all
```

## Watch Resources Continuously

```bash id="g4x2s8"
kubectl get pods -w
```

## Delete Resources

```bash id="r7p5c0"
kubectl delete -f pod.yaml
kubectl delete -f deployment.yaml
kubectl delete -f configmap.yaml
kubectl delete -f clusterip-svc.yaml
```

---

# Understanding Key Concepts

## Pod

A Pod is the smallest deployable unit in Kubernetes.
It can contain one or more containers.

---

## Deployment

A Deployment manages:

* Replica creation
* Rolling updates
* Self-healing Pods
* Scaling

---

## ConfigMap

ConfigMaps store application configuration separately from container images.

Benefits:

* Easy configuration updates
* Environment separation
* Improved portability

---

## ClusterIP Service

ClusterIP is the default Kubernetes Service type.

It:

* Exposes applications internally
* Enables Pod-to-Pod communication
* Provides stable networking

---

# Validation Checklist

* ConfigMap created successfully
* Pod is running
* Deployment replicas are healthy
* Service is accessible internally
* Application logs are visible

---

# Cleanup

Remove all resources:

```bash id="6ecg2j"
kubectl delete -f .
```

Verify cleanup:

```bash id="6l0hff"
kubectl get all
```

---

# Key Takeaways

* Kubernetes Pods run containerized workloads
* Deployments provide scalability and self-healing
* ConfigMaps externalize application settings
* Services enable stable networking
* ClusterIP allows secure internal communication

---

AWS Console view:

<img width="1910" height="793" alt="image" src="https://github.com/user-attachments/assets/189cdb42-8852-475a-8cf6-719cf35abe29" />

Basic Files are created.
----------------------
einfochips@91P2S24:~/AWS_Learning/statefulset$ kubectl apply -f .
service/mysql unchanged
configmap/catalog unchanged
deployment.apps/catalog unchanged
service/mysql-service created
einfochips@91P2S24:~/AWS_Learning/statefulset$ 

---------------------------
Validate YAML Lynt Syntax
<img width="1408" height="298" alt="Screenshot from 2026-05-12 15-52-24" src="https://github.com/user-attachments/assets/c36aa3e0-d914-4c6c-9652-fe9d9b88b655" />

