# UI Helm Chart

This Helm chart deploys the UI application on Kubernetes with support for:

* Kubernetes Deployment
* Service
* ConfigMap
* Horizontal Pod Autoscaler (HPA)
* Pod Disruption Budget (PDB)
* Ingress
* Service Account
* Helm test hooks

---

# Directory Structure

```text
charts/ui
├── Chart.yaml
├── README.md
├── templates
│   ├── configmap.yml
│   ├── deployment.yaml
│   ├── _helpers.tpl
│   ├── hpa.yaml
│   ├── ingress.yaml
│   ├── istio-gateway.yml
│   ├── istio-virtualservice.yml
│   ├── NOTES.txt
│   ├── pdb.yaml
│   ├── serviceaccount.yaml
│   ├── service.yaml
│   └── tests
│       └── test-connection.yaml
└── values.yaml
```

---

# Prerequisites

* Kubernetes Cluster
* Helm v3+
* kubectl configured
* Optional:

  * Istio Service Mesh
  * Ingress Controller

---

# Install Chart

```bash
helm install ui-release ./charts/ui
```

Install into specific namespace:

```bash
helm install ui-release ./charts/ui -n ui --create-namespace
```

---

# Validate Installation

Check Helm release:

```bash
helm list -n ui
```

Check Pods:

```bash
kubectl get pods -n ui
```

Check Services:

```bash
kubectl get svc -n ui
```

---

# Upgrade Chart

```bash
helm upgrade ui-release ./charts/ui -n ui
```

---

# Uninstall Chart

```bash
helm uninstall ui-release -n ui
```

---

# Helm Template Validation

Render templates locally:

```bash
helm template ui-release ./charts/ui
```

Lint chart:

```bash
helm lint ./charts/ui
```

---

# Configuration

Modify deployment configuration using:

```bash
charts/ui/values.yaml
```

Example:

```yaml
replicaCount: 2

image:
  repository: nginx
  tag: latest

service:
  type: ClusterIP
  port: 80
```

Override values during installation:

```bash
helm install ui-release ./charts/ui \
  --set replicaCount=3
```

```

---

# Ingress Support

Ingress resources are available via:

```text
templates/ingress.yaml
```

Ensure:

* NGINX Ingress Controller or equivalent is installed
* DNS records are configured properly

---

# Horizontal Pod Autoscaler

HPA template:

```text
templates/hpa.yaml
```

Requires:

* Kubernetes Metrics Server

Verify:

```bash
kubectl get hpa
```

---

# Helm Tests

Run chart tests:

```bash
helm test ui-release -n ui
```

---

# Useful Commands

Package chart:

```bash
helm package charts/ui
```

Push chart to OCI registry:

```bash
helm push ui-<version>.tgz oci://<registry>
```

Pull chart:

```bash
helm pull oci://<registry>/ui --version <version>
``


----------------------------


<img width="1920" height="1200" alt="Screenshot from 2026-05-18 14-38-36" src="https://github.com/user-attachments/assets/c0b93549-aa52-4523-91c0-34a4ff544579" />

<img width="1920" height="1200" alt="Screenshot from 2026-05-18 16-22-36" src="https://github.com/user-attachments/assets/29242c56-58fb-4404-b873-7f1839e4a1e9" />

<img width="1920" height="1200" alt="Screenshot from 2026-05-18 16-36-08" src="https://github.com/user-attachments/assets/d0082d82-1b48-4916-a46a-ebe01a88e360" />

<img width="1920" height="1200" alt="Screenshot from 2026-05-18 16-38-39" src="https://github.com/user-attachments/assets/dfa54d2e-ccbe-4917-807b-e46549a3a86f" />



