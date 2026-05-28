------
Structure of Project files are mentioned as below.
------
````bash
einfochips@91P2S24:~/AWS_Learning/ArgoCD-CI-CD$ tree -A



.
├── ArgoCD-Install
│   ├── argocd.yaml
│   ├── install-argocd.sh
│   └── README.md
├── CI
│   └── trust-policy.json
└── CICD_full_flow_test
    └── 21_04_CI_CD_Full_Flow_Test
        ├── images
        │   ├── 01_github_actions.png
        │   ├── 02_github_actions.png
        │   ├── 03_ecr_image.png
        │   └── 04_values_ui_image_tag.png
        ├── LOW_COST_retailstore_HELM_Values
        │   ├── 01-uninstall-retail-apps.sh
        │   ├── 03-v1.0.0-install-remote-helm-charts.sh
        │   ├── 05-v2.0.0-install-remote-helm-charts.sh
        │   ├── NOT-NEEDED-Installed-from-ArgoCD-values-ui.yaml
        │   ├── values-cart.yaml
        │   ├── values-catalog-v2.0.0.yaml
        │   ├── values-catalog.yaml
        │   ├── values-checkout.yaml
        │   ├── values-orders-v2.0.0.yaml
        │   └── values-orders.yaml
        └── README.md

7 directories, 19 files
````

----
WorkFlow of ArgoCD project as mentioned below.
----
STEP1: You push code changes to the UI microservice.

STEP2: GitHub Actions builds the Docker image, applies tags, and pushes it to ECR.

STEP3: The values-ui.yaml Helm file is updated with the new image tag.

STEP4: ArgoCD then syncs the changes from Git and deploys the updated version to the EKS cluster.

----
ArgoCD Integration
----
Have used different repository for ARGOCD.

Repo link : https://github.com/vanrajboricha/aws-devops-github-actions-ecr-argocd2

Here is a clean, well-structured, and comprehensive `README.md` markdown file tailored to your pipeline setup. Per your instructions, the actual source code of the files has been omitted, and it focuses entirely on commands, execution order, and a clear explanation of how the files work together.

---

```markdown
# GitOps & Helm Infrastructure Deployment Guide

This repository contains the deployment automation tools for bootstrapping a GitOps pipeline on an Amazon EKS cluster. It utilizes a hybrid deployment approach: backing microservices (Catalog, Cart, Checkout, and Orders) are deployed directly via Helm, while the consumer-facing frontend (UI) is deployed using declarative GitOps via ArgoCD.

---

## 🏗️ Architecture Overview

The automation logic is divided into three distinct phases to ensure reliable cluster bootstrapping:

1. **ArgoCD Bootstrapping Engine:** An automation shell script that sets up the GitOps controller onto the EKS cluster, tracks service readiness, and securely exposes the initial administrative credentials.
2. **ArgoCD Declarative Application Engine:** A Kubernetes Custom Resource Definition (CRD) configuration that maps Git states directly into EKS target namespaces. It leverages Automated Pruning and Drift Self-Healing.
3. **Hybrid Remote Helm Orchestrator:** A sequential automation installer that sets up remote Helm registries, installs core backend dependencies, and delegates the final layer of orchestration to the GitOps sync loop.

---

## 🛠️ Step-by-Step Deployment Instructions

To ensure zero-downtime microservice dependencies, these scripts must be executed in a specific sequential order.

### Prerequisites

Before starting, ensure your terminal is authenticated and has the required administrative access scopes:
* **AWS CLI** configured with access to your Amazon EKS cluster.
* **kubectl** configured to reference your active cluster context (`kubectl config current-context`).
* **Helm CLI** (v3+) locally installed.

---

### Step 1: Bootstrap ArgoCD on EKS

Run the installation script to provision the ArgoCD control plane.

```bash
chmod +x install-argocd.sh
./install-argocd.sh

```

**What this script does:**

* Creates an isolated `argocd` system namespace inside your Kubernetes cluster.
* Pulls and applies the official stable ArgoCD manifest resources.
* Monitors cluster rollouts, blocking execution until the `argocd-server` deployment reaches a fully running and healthy state.
* Fetches the randomly auto-generated administrative secret and decodes it from Base64 into human-readable plaintext.
* Outputs ready-to-use login details and a local port-forward execution command.

---

### Step 2: Access the ArgoCD Dashboard

Once Step 1 finishes running, open a secondary terminal window and establish a secure tunnel to your cluster’s control plane:

```bash
kubectl port-forward svc/argocd-server -n argocd 8080:443

```

**Actions to take:**

1. Open your web browser and navigate to: `https://localhost:8080` *(Accept any self-signed SSL/TLS warning bypass)*.
2. Log in using the username `admin` and the unique password printed out at the end of Step 1.

---

### Step 3: Orchestrate Core Services via Helm

Execute the multi-service Helm manager script to spin up the application backend.

```bash
chmod +x install-remote-helm-charts.sh
./install-remote-helm-charts.sh

```

**What this script does:**

* Connects your environment to the public `stacksimplify` Helm chart repository and indexes all latest versions.
* Installs/upgrades the **Catalog Service** (`version 1.0.0`) using customized overrides from `values-catalog.yaml`.
* Installs/upgrades the **Cart Service** (`version 1.0.0`) using overrides from `values-cart.yaml`.
* Installs/upgrades the **Checkout Service** (`version 1.0.0`) using overrides from `values-checkout.yaml`.
* Installs/upgrades the **Orders Service** (`version 1.0.0`) using overrides from `values-orders.yaml`.
* Intentionally skips the manual deployment of the **UI Service**, signaling that it is managed by GitOps instead.
* Prints a runtime audit map detailing every active Pod, Service, ServiceAccount, ConfigMap, and Ingress rule in the namespace.

---

### Step 4: Provision the UI Application via ArgoCD GitOps

Finally, apply the declarative ArgoCD custom resource to continuously sync the frontend service.

```bash
kubectl apply -f argocd-application.yaml -n argocd

```

**What this configuration does:**

* Instructs the ArgoCD operator engine to track a dedicated upstream GitHub repository on the `main` branch.
* Targets the local cluster runtime api loopback (`https://kubernetes.default.svc`) and deploys objects into the `default` namespace.
* Enforces **Automated Pruning (`prune: true`)**: Any infrastructure configurations or microservice definitions deleted from Git will be instantly deleted from the EKS cluster.
* Enforces **Self-Healing (`selfHeal: true`)**: If an administrator tries to manually modify or hot-patch the cluster via `kubectl edit` or `kubectl patch`, ArgoCD detects the drift and forces the infrastructure back to the exact code state defined in Git.
* Instructs the system to automatically build missing infrastructure via the `CreateNamespace=true` flag.

---

## 🔍 Post-Deployment Verification

To confirm that both the direct Helm deployments and the ArgoCD GitOps engine have successfully completed cluster operations, use the following verification workflow:

1. **Check ArgoCD App sync state:**
```bash
kubectl get applications -n argocd

```


*(Ensure status reads `Synced` and health reads `Healthy`)*
2. **Verify all cluster runtime Pod status records:**
```bash
kubectl get pods -n default -w

```


*(Ensure all microservices show a status of `Running` and are ready)*
3. **Locate your Application Ingress endpoint:**
```bash
kubectl get ingress -n default

```


Copy the public DNS address listed under the **ADDRESS** field and paste it into your web browser to test your functional Retail Store App.

```

```

<img width="1920" height="1200" alt="Screenshot from 2026-05-27 11-33-55" src="https://github.com/user-attachments/assets/44c8935d-10ab-4232-be86-b414bff7f2c8" />

<img width="1751" height="632" alt="Screenshot from 2026-05-27 11-41-41" src="https://github.com/user-attachments/assets/a35cefa9-5720-4272-8ec4-0aacc6384b36" />


<img width="1920" height="1200" alt="Screenshot from 2026-05-27 12-04-00" src="https://github.com/user-attachments/assets/11f9055c-0436-448b-8711-835aa693418b" />


<img width="1920" height="1200" alt="Screenshot from 2026-05-27 14-19-36" src="https://github.com/user-attachments/assets/27c4321c-1114-447d-a103-2f45147e8455" />


<img width="1920" height="1200" alt="Screenshot from 2026-05-27 15-05-00" src="https://github.com/user-attachments/assets/6b1460ba-4ea6-4ef1-adda-005c47a08b8b" />


<img width="1920" height="1200" alt="Screenshot from 2026-05-27 15-05-58" src="https://github.com/user-attachments/assets/025dc06c-0d13-4fd2-8684-aef26ed91e64" />


<img width="1920" height="1200" alt="Screenshot from 2026-05-27 15-12-51" src="https://github.com/user-attachments/assets/22ade9fc-c928-4da4-82fb-77e1a53c6932" />



<img width="1920" height="1200" alt="Screenshot from 2026-05-27 15-13-12" src="https://github.com/user-attachments/assets/1a8cd268-e624-4ceb-911d-536d68d0913c" />



