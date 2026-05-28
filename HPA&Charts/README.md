# Kubernetes HPA and PDB with Helm Charts for Retail Store Sample Application

## Overview

This project demonstrates how to implement:

* Horizontal Pod Autoscaler (HPA)
* Pod Disruption Budget (PDB)
* Helm Chart Packaging and Versioning

for a microservices-based Retail Store Sample Application running on Kubernetes.

The project uses Helm charts to deploy and manage multiple microservices with autoscaling and high availability configurations.

---

# Architecture Components

The application contains the following microservices:

* carts
* catalog
* checkout
* orders
* ui

Each service includes:

* Deployment
* Service
* ConfigMap
* ServiceAccount
* HPA
* PDB

Some services also include supporting components such as:

* MySQL
* PostgreSQL
* RabbitMQ
* Redis
* DynamoDB Local

---

# Project Structure

```text
.
├── helm_charts
│   ├── charts_base
│   ├── charts_v1.0.0
│   ├── charts_v2.0.0
│   └── values
├── HPA
├── PDB
└── README.md
```

---

# Folder Details

## 1. helm_charts/charts_base

Contains base Helm charts for all retail application services.

Each chart contains:

* deployment.yaml
* service.yaml
* hpa.yaml
* pdb.yaml
* values.yaml

---

## 2. helm_charts/charts_v1.0.0

Contains packaged and versioned Helm charts (`v1.0.0`).

Example:

```text
retail-store-sample-cart-chart-1.0.0.tgz
```

---

## 3. helm_charts/charts_v2.0.0

Contains upgraded Helm chart versions (`v2.0.0`) with additional features such as:

* SecretProviderClass
* Enhanced secret management
* Security improvements

---

## 4. helm_charts/values

Contains reusable Helm values files and installation scripts.

### Installation Scripts

| Script                                  | Description                       |
| --------------------------------------- | --------------------------------- |
| 01-uninstall-retail-apps.sh             | Uninstall all applications        |
| 02-v1.0.0-install-local-helm-charts.sh  | Install local Helm charts v1.0.0  |
| 03-v1.0.0-install-remote-helm-charts.sh | Install remote Helm charts v1.0.0 |
| 04-v2.0.0-install-local-helm-charts.sh  | Install local Helm charts v2.0.0  |
| 05-v2.0.0-install-remote-helm-charts.sh | Install remote Helm charts v2.0.0 |

---

# Horizontal Pod Autoscaler (HPA)

The `HPA/` folder contains standalone HPA manifests for all services.

## HPA Files

```text
HPA/
├── carts.yaml
├── catalog.yaml
├── checkout.yaml
├── orders.yaml
└── ui.yaml
```

## HPA Features

* CPU-based autoscaling
* Automatic pod scaling
* Improved application performance
* Better resource utilization

## Example HPA Configuration

```yaml
apiVersion: autoscaling/v2
kind: HorizontalPodAutoscaler
metadata:
  name: ui-hpa
  namespace: default
  labels:
    app.kubernetes.io/name: ui
    app.kubernetes.io/instance: ui
    app.kubernetes.io/component: autoscaling
    app.kubernetes.io/owner: retail-store-sample

spec:
  scaleTargetRef:
    apiVersion: apps/v1
    kind: Deployment
    name: ui

  minReplicas: 3
  maxReplicas: 12

  metrics:
    - type: Resource
      resource:
        name: cpu
        target:
          type: Utilization
          averageUtilization: 70

    - type: Resource
      resource:
        name: memory
        target:
          type: Utilization
          averageUtilization: 80

  behavior:
    scaleDown:
      stabilizationWindowSeconds: 300
      policies:
        - type: Percent
          value: 50
          periodSeconds: 15
        - type: Pods
          value: 1
          periodSeconds: 60
      selectPolicy: Min

    scaleUp:
      stabilizationWindowSeconds: 0
      policies:
        - type: Percent
          value: 100
          periodSeconds: 15
        - type: Pods
          value: 4
          periodSeconds: 15
      selectPolicy: Max
```

---

# Pod Disruption Budget (PDB)

The `PDB/` folder contains Pod Disruption Budget manifests.

## PDB Files

```text
PDB/
├── carts.yaml
├── catalog.yaml
├── checkout.yaml
├── orders.yaml
└── ui.yaml
```

## PDB Features

* Prevents excessive pod disruption
* Ensures application availability during:

  * node maintenance
  * upgrades
  * voluntary disruptions
* Improves high availability

## Example PDB Configuration

```yaml
apiVersion: policy/v1
kind: PodDisruptionBudget
metadata:
  name: carts-pdb
  namespace: default
  labels:
    app.kubernetes.io/name: carts
    app.kubernetes.io/instance: carts
    app.kubernetes.io/component: availability
    app.kubernetes.io/owner: retail-store-sample
spec:
  minAvailable: 2
  selector:
    matchLabels:
      app.kubernetes.io/name: carts
      app.kubernetes.io/instance: carts
      app.kubernetes.io/component: service
      app.kubernetes.io/owner: retail-store-sample
```

---

# Prerequisites

Before deployment, ensure the following tools are installed:

* Kubernetes Cluster
* kubectl
* Helm v3+
* Metrics Server
* AWS EKS (optional)

---

# Install Metrics Server

HPA requires Kubernetes Metrics Server.

```bash
kubectl apply -f https://github.com/kubernetes-sigs/metrics-server/releases/latest/download/components.yaml
```

Verify Metrics Server:

```bash
kubectl top nodes
kubectl top pods
```

---

# Deploy Application using Helm Charts

## Install Helm Charts Locally

```bash
cd helm_charts/values
chmod +x *.sh
./02-v1.0.0-install-local-helm-charts.sh
```

---

# Verify Deployments

## Verify Pods

```bash
kubectl get pods
```

## Verify HPA

```bash
kubectl get hpa
```

## Verify PDB

```bash
kubectl get pdb
```

---

# Test Horizontal Pod Autoscaling

Generate load against the application:

```bash
kubectl run -i --tty load-generator --rm --image=busybox -- /bin/sh
```

Inside the container:

```bash
while true; do wget -q -O- http://ui; done
```

Monitor HPA scaling:

```bash
kubectl get hpa -w
```

---

# Package Helm Charts

## Package Charts

```bash
helm package retail-store-sample-cart-chart
```

## Create Helm Repository Index

```bash
helm repo index .
```

---

# Upgrade Helm Chart

```bash
helm upgrade cart retail-store-sample-cart-chart
```

---

# Uninstall Applications

```bash
./01-uninstall-retail-apps.sh
```

---

# Key Benefits

## HPA Benefits

* Automatic scaling
* Improved performance
* Efficient resource utilization
* Reduced operational overhead

## PDB Benefits

* High availability
* Safe node draining
* Controlled disruptions
* Improved reliability

---

# Technologies Used

* Kubernetes
* Helm
* Horizontal Pod Autoscaler (HPA)
* Pod Disruption Budget (PDB)
* AWS EKS
* Docker

---

###
This file is created for HPA flow.

<img width="1920" height="1200" alt="Screenshot from 2026-05-25 16-28-58" src="https://github.com/user-attachments/assets/35ca24ee-62a6-44d9-9755-48e5fcfe6675" />

<img width="1920" height="1200" alt="Screenshot from 2026-05-25 16-29-17" src="https://github.com/user-attachments/assets/b1e5a841-7820-49cb-8389-9749c429d2af" />

<img width="1920" height="1200" alt="Screenshot from 2026-05-25 16-29-36" src="https://github.com/user-attachments/assets/dfeb86b9-dd13-4534-882b-26ae8317da37" />

<img width="1920" height="1200" alt="Screenshot from 2026-05-25 16-29-46" src="https://github.com/user-attachments/assets/b0b0fed7-21fc-4493-b281-09ecef3deb25" />

<img width="1920" height="1200" alt="Screenshot from 2026-05-25 18-41-43" src="https://github.com/user-attachments/assets/84de24be-7810-43ee-af2c-38f2b3c69f57" />

<img width="1202" height="344" alt="Screenshot from 2026-05-25 18-42-13" src="https://github.com/user-attachments/assets/c8c0254a-e623-4d9b-a13d-a5991b5f582b" />

<img width="1920" height="1200" alt="Screenshot from 2026-05-26 14-57-01" src="https://github.com/user-attachments/assets/fa71b969-fe38-4b46-8f39-e7c823630080" />

