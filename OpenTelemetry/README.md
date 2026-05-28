Here’s a professional `README.md` for your OpenTelemetry and Retail Store observability setup.

# OpenTelemetry Observability Setup on Amazon EKS

## Overview

This project demonstrates end-to-end observability implementation for a Retail Store microservices application running on Amazon EKS using OpenTelemetry and AWS Distro for OpenTelemetry (ADOT).

The setup includes:

* Distributed tracing with OpenTelemetry
* Metrics collection using Prometheus
* Log collection through ADOT DaemonSet
* Application instrumentation for traces
* Monitoring of Retail Store microservices deployed via Helm
* Cost-optimized and high-capacity deployment models

---

# Solution Components

This repository provides configurations for:

* OpenTelemetry instrumentation
* ADOT Collector deployment
* Prometheus metrics scraping
* Centralized log collection
* Retail Store application deployment using Helm
* High-cost and low-cost environment configurations

---

# High-Level Architecture

```text id="o4e0p7"
Retail Store Microservices
        |
        +-----------------------------+
        |             |               |
        v             v               v
     Traces        Metrics          Logs
        |             |               |
        +-------------+---------------+
                      |
                      v
             AWS Distro for OpenTelemetry
                      |
        +-------------+-------------+
        |                           |
        v                           v
  Amazon Managed              Monitoring &
  Prometheus (AMP)            Observability Tools
```

---

# Repository Structure

```text id="k8of7q"
OpenTelemetry/
│
├── 02_RetailStore_App_Helm_AWS_Data_Plane
│   ├── 01_HIGH_COST_retailstore_HELM
│   └── 02_LOW_COST_retailstore_HELM
│
├── OpenTelemetry_Traces
│   ├── ADOT_collector_traces.yaml
│   ├── ADOT_Instrumentation.yaml
│   ├── ADOT_logs_collector_daemonset.yaml
│   ├── ADOT_prometheus.yaml
│   ├── rollout_restart.sh
│   └── verify_amp_metrics.sh
│
└── README.md
```

---

# Retail Store Deployment Models

## 1. High-Cost Retail Store Deployment

**Directory:**

```text id="9iv32z"
02_RetailStore_App_Helm_AWS_Data_Plane/01_HIGH_COST_retailstore_HELM
```

This deployment model provisions higher resource allocations suitable for:

* Performance testing
* Load testing
* Full observability validation
* Multi-service tracing analysis

### Included Files

| File                                      | Purpose                        |
| ----------------------------------------- | ------------------------------ |
| `03-v1.0.0-install-remote-helm-charts.sh` | Install Retail Store v1.0.0    |
| `05-v2.0.0-install-remote-helm-charts.sh` | Upgrade to Retail Store v2.0.0 |
| `01-uninstall-retail-apps.sh`             | Remove deployed applications   |
| `values-*.yaml`                           | Helm customization values      |

---

## 2. Low-Cost Retail Store Deployment

**Directory:**

```text id="ay8z3g"
02_RetailStore_App_Helm_AWS_Data_Plane/02_LOW_COST_retailstore_HELM
```

This deployment is optimized for:

* Lab environments
* Development testing
* Reduced infrastructure cost
* Lightweight observability testing

---

# OpenTelemetry Configuration Files

## OpenTelemetry Tracing Components

| File                                 | Description                             |
| ------------------------------------ | --------------------------------------- |
| `ADOT_collector_traces.yaml`         | ADOT Collector for traces               |
| `ADOT_Instrumentation.yaml`          | OpenTelemetry auto-instrumentation      |
| `ADOT_logs_collector_daemonset.yaml` | Log collection DaemonSet                |
| `ADOT_prometheus.yaml`               | Prometheus metrics collection           |
| `rollout_restart.sh`                 | Restart workloads after instrumentation |
| `verify_amp_metrics.sh`              | Validate AMP metric ingestion           |

---

# Prerequisites

Ensure the following components are available before deployment:

* AWS Account
* Amazon EKS Cluster
* kubectl configured
* Helm installed
* AWS CLI configured
* Amazon Managed Prometheus (AMP)
* IAM Roles for Service Accounts (IRSA) or Pod Identity configured

---

# Step-01: Deploy Retail Store Application

## Navigate to Deployment Directory

### High-Cost Deployment

```bash id="r1a0m2"
cd 02_RetailStore_App_Helm_AWS_Data_Plane/01_HIGH_COST_retailstore_HELM
```

### Low-Cost Deployment

```bash id="9m7o4j"
cd 02_RetailStore_App_Helm_AWS_Data_Plane/02_LOW_COST_retailstore_HELM
```

---

## Install Retail Store v1.0.0

```bash id="7vw1ha"
chmod +x 03-v1.0.0-install-remote-helm-charts.sh

./03-v1.0.0-install-remote-helm-charts.sh
```

Verify deployments:

```bash id="6z3r4i"
kubectl get pods
kubectl get svc
```

---

# Step-02: Configure OpenTelemetry Instrumentation

Navigate to tracing directory:

```bash id="08djlwm"
cd ../../OpenTelemetry_Traces
```

Deploy instrumentation:

```bash id="14xjvo"
kubectl apply -f ADOT_Instrumentation.yaml
```

---

# Step-03: Deploy ADOT Collector for Traces

Apply collector configuration:

```bash id="26qeh9"
kubectl apply -f ADOT_collector_traces.yaml
```

Verify collector Pods:

```bash id="w3hsy2"
kubectl get pods
```

---

# Step-04: Configure Prometheus Metrics Collection

Deploy Prometheus collector:

```bash id="m0kt2k"
kubectl apply -f ADOT_prometheus.yaml
```

Verify Prometheus resources:

```bash id="6l4eyt"
kubectl get pods
kubectl get configmap
```

---

# Step-05: Enable Log Collection

Deploy logs collector DaemonSet:

```bash id="yhmh3n"
kubectl apply -f ADOT_logs_collector_daemonset.yaml
```

Verify DaemonSet:

```bash id="o5kzux"
kubectl get daemonset
```

---

# Step-06: Restart Application Pods

After instrumentation changes, restart workloads:

```bash id="gqj2hv"
chmod +x rollout_restart.sh

./rollout_restart.sh
```

Verify rollout status:

```bash id="rfu0gf"
kubectl rollout status deployment
```

---

# Step-07: Validate Metrics in AMP

Run verification script:

```bash id="yd2wwn"
chmod +x verify_amp_metrics.sh

./verify_amp_metrics.sh
```

Confirm metrics are visible in Amazon Managed Prometheus.

---

# Upgrade Retail Store Application

Upgrade to Retail Store v2.0.0:

```bash id="tvym0d"
chmod +x 05-v2.0.0-install-remote-helm-charts.sh

./05-v2.0.0-install-remote-helm-charts.sh
```

This helps validate distributed tracing across application versions.

---

# Verify Observability Components

## Check Pods

```bash id="gb2e7w"
kubectl get pods -A
```

## Verify Services

```bash id="9z9gr7"
kubectl get svc
```

## View Collector Logs

```bash id="0gfkj2"
kubectl logs -l app=adot-collector
```

---

# Cleanup

## Remove Retail Store Applications

```bash id="pp98sv"
chmod +x 01-uninstall-retail-apps.sh

./01-uninstall-retail-apps.sh
```

---

## Remove OpenTelemetry Components

```bash id="c1v6x5"
kubectl delete -f ADOT_collector_traces.yaml
kubectl delete -f ADOT_Instrumentation.yaml
kubectl delete -f ADOT_logs_collector_daemonset.yaml
kubectl delete -f ADOT_prometheus.yaml
```

---

# Key Learnings

* OpenTelemetry enables vendor-neutral observability
* ADOT simplifies telemetry collection on AWS
* Distributed tracing improves microservice visibility
* Prometheus metrics provide infrastructure and application insights
* Centralized logging improves troubleshooting
* Auto-instrumentation reduces manual code changes
* Observability pipelines can scale across multiple application versions

---

# Useful Commands

## View All Resources

```bash id="34b8ji"
kubectl get all -A
```

## Monitor Pods

```bash id="dlqayv"
kubectl get pods -w
```

## Check Logs

```bash id="5rfy4f"
kubectl logs <pod-name>
```

## Verify Metrics

```bash id="l8k83d"
kubectl top pods
```

---


<img width="1920" height="1200" alt="Screenshot from 2026-05-26 14-57-01" src="https://github.com/user-attachments/assets/c5e6dbe6-7413-4a2f-a111-b726f492d75c" />

<img width="1920" height="1200" alt="Screenshot from 2026-05-26 15-58-12" src="https://github.com/user-attachments/assets/59e859be-13d6-4869-8126-02be38505bd8" />

<img width="1920" height="1200" alt="Screenshot from 2026-05-26 16-02-02" src="https://github.com/user-attachments/assets/a3e6b299-7b92-45c0-a10e-5b79a2bb9b7f" />

<img width="1920" height="1200" alt="Screenshot from 2026-05-26 16-03-05" src="https://github.com/user-attachments/assets/b8dadec0-a491-49bd-a639-898a57d66015" />

<img width="1920" height="1200" alt="Screenshot from 2026-05-26 16-35-24" src="https://github.com/user-attachments/assets/34d2ea1d-893e-4b22-b2a4-f23432f8141a" />

<img width="1920" height="1200" alt="Screenshot from 2026-05-26 16-36-05" src="https://github.com/user-attachments/assets/bdf051b5-3fc5-4343-aa6b-4b774e00aec6" />

<img width="1920" height="1200" alt="Screenshot from 2026-05-26 17-03-44" src="https://github.com/user-attachments/assets/c2262d3e-8df6-458d-bfe2-4f0013e443d7" />
