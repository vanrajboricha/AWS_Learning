

## **Step-01: Project Overview**

This project enhances our base EKS setup [from Section-07](../../07_Terraform_EKS_Cluster/) by integrating official AWS and Kubernetes add-ons that power modern workloads.

| AddOn                                  | Purpose                                                                      |
| -------------------------------------- | ---------------------------------------------------------------------------- |
| **Pod Identity Agent**                 | Enables Pods to assume IAM roles securely without storing credentials.       |
| **AWS Load Balancer Controller (LBC)** | Manages ALBs/NLBs for Ingress resources and Service type LoadBalancer.       |
| **EBS CSI Driver**                     | Enables dynamic provisioning of Amazon EBS volumes for Stateful workloads.   |
| **Secrets Store CSI Driver + ASCP**    | Mounts AWS Secrets Manager / SSM Parameter Store secrets directly into Pods. |

---

## **Step-02: Full Project Structure (In Order)**

```
einfochips@91P2S24:~/AWS_Learning/EKS-Addons$ tree -a
.
├── 02_EKS_terraform-manifests_with_addons
│   ├── c10_eks_outputs.tf
│   ├── c11-podidentityagent-eksaddon.tf
│   ├── c12-helm-and-kubernetes-providers.tf
│   ├── c13-podidentity-assumerole.tf
│   ├── c14-01-lbc-iam-policy-datasources.tf
│   ├── c14-02-lbc-iam-policy-and-role.tf
│   ├── c14-03-lbc-eks-pod-identity-association.tf
│   ├── c14-04-lbc-helm-install.tf
│   ├── c15-01-ebscsi-iam-policy-and-role.tf
│   ├── c15-02-ebscsi-eks-pod-identity-association.tf
│   ├── c15-03-ebscsi-eksaddon.tf
│   ├── c16-01-secretstorecsi-helm-install.tf
│   ├── c16-02-secretstorecsi-ascp-helm-install.tf
│   ├── c1_versions.tf
│   ├── c2_variables.tf
│   ├── c3_remote-state.tf
│   ├── c4_datasources_and_locals.tf
│   ├── c5_eks_tags.tf
│   ├── c6_eks_cluster_iamrole.tf
│   ├── c7_eks_cluster.tf
│   ├── c8_eks_nodegroup_iamrole.tf
│   ├── c9_eks_nodegroup_private.tf
│   ├── .terraform
│   │   ├── providers
│   │   │   └── registry.terraform.io
│   │   │       └── hashicorp
│   │   │           ├── aws
│   │   │           │   └── 6.45.0
│   │   │           │       └── linux_amd64
│   │   │           │           ├── LICENSE.txt
│   │   │           │           └── terraform-provider-aws_v6.45.0_x5
│   │   │           ├── helm
│   │   │           │   └── 3.1.1
│   │   │           │       └── linux_amd64
│   │   │           │           ├── LICENSE.txt
│   │   │           │           └── terraform-provider-helm_v3.1.1_x5
│   │   │           ├── http
│   │   │           │   └── 3.5.0
│   │   │           │       └── linux_amd64
│   │   │           │           ├── LICENSE.txt
│   │   │           │           └── terraform-provider-http_v3.5.0_x5
│   │   │           └── kubernetes
│   │   │               └── 2.38.0
│   │   │                   └── linux_amd64
│   │   │                       ├── LICENSE.txt
│   │   │                       └── terraform-provider-kubernetes_v2.38.0_x5
│   │   └── terraform.tfstate
│   ├── .terraform.lock.hcl
│   └── terraform.tfvars
├── create-cluster.sh
├── destroy-cluster.sh
└── README.md

```


### **Execution Flow (In Order)**

1. ** EKS Cluster + AddOns**

   * Uses VPC outputs from remote state
   * Builds EKS Cluster, NodeGroups, IAM roles
   * Installs:

     * `EKS Pod Identity Agent`
     * `AWS Load Balancer Controller`
     * `Amazon EBS CSI Driver`
     * `Secrets Store CSI Driver + ASCP`

2. **Post-Deploy**

   * Update kubeconfig
   * Verify add-on pods under `kube-system`
   * Confirm IAM Pod Identity associations

4. **Teardown**

   * Run `destroy-cluster.sh`
   * Destroys EKS first, then VPC



---

---




### : Create EKS Cluster
```bash
# Change Directory 
cd 02_EKS_terraform-manifests_with_addons

# Initialize Terraform
terraform init

# Validate syntax
terraform validate

# Preview the plan
terraform plan

# Apply configuration 
terraform apply -auto-approve
```

---

## **: Configure kubectl**
💡 **Tip:** It may take a few minutes for all add-on pods (especially ASCP and EBS CSI) to transition to `Running` state. Use `kubectl get pods -n kube-system -w` to watch in real time.

```bash
# Update kubeconfig
aws eks update-kubeconfig --name <cluster_name> --region <aws_region>
aws eks update-kubeconfig --name retail-dev-eksdemo1 --region us-east-1

# Verify nodes
kubectl get nodes

# Verify all AddOn pods
kubectl get pods -n kube-system
```


<img width="1907" height="1063" alt="Screenshot from 2026-05-19 15-49-55" src="https://github.com/user-attachments/assets/0ae63e13-1739-4eeb-8f64-7006495f392a" />

<img width="1920" height="1200" alt="Screenshot from 2026-05-19 18-44-33" src="https://github.com/user-attachments/assets/91fee4e7-61c5-438e-a5e8-332c2e893eaa" />

<img width="1920" height="1200" alt="Screenshot from 2026-05-19 18-45-56" src="https://github.com/user-attachments/assets/c3c648ae-b4f6-4c5b-b684-20df860043fa" />

<img width="1920" height="1200" alt="Screenshot from 2026-05-19 18-47-18" src="https://github.com/user-attachments/assets/682d0d0f-4219-4680-8f06-c43ed529bbbe" />
