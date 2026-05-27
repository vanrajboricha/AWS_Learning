------
Structure of Project files are mentioned as below.
------
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
einfochips@91P2S24:~/AWS_Learning/ArgoCD-CI-CD$ 

--------

WorkFlow of ArgoCD project as mentioned below.

STEP1: You push code changes to the UI microservice.

STEP2: GitHub Actions builds the Docker image, applies tags, and pushes it to ECR.

STEP3: The values-ui.yaml Helm file is updated with the new image tag.

STEP4: ArgoCD then syncs the changes from Git and deploys the updated version to the EKS cluster.



<img width="1920" height="1200" alt="Screenshot from 2026-05-27 11-33-55" src="https://github.com/user-attachments/assets/44c8935d-10ab-4232-be86-b414bff7f2c8" />

<img width="1751" height="632" alt="Screenshot from 2026-05-27 11-41-41" src="https://github.com/user-attachments/assets/a35cefa9-5720-4272-8ec4-0aacc6384b36" />


<img width="1920" height="1200" alt="Screenshot from 2026-05-27 12-04-00" src="https://github.com/user-attachments/assets/11f9055c-0436-448b-8711-835aa693418b" />


<img width="1920" height="1200" alt="Screenshot from 2026-05-27 14-19-36" src="https://github.com/user-attachments/assets/27c4321c-1114-447d-a103-2f45147e8455" />


<img width="1920" height="1200" alt="Screenshot from 2026-05-27 15-05-00" src="https://github.com/user-attachments/assets/6b1460ba-4ea6-4ef1-adda-005c47a08b8b" />


<img width="1920" height="1200" alt="Screenshot from 2026-05-27 15-05-58" src="https://github.com/user-attachments/assets/025dc06c-0d13-4fd2-8684-aef26ed91e64" />


<img width="1920" height="1200" alt="Screenshot from 2026-05-27 15-12-51" src="https://github.com/user-attachments/assets/22ade9fc-c928-4da4-82fb-77e1a53c6932" />



<img width="1920" height="1200" alt="Screenshot from 2026-05-27 15-13-12" src="https://github.com/user-attachments/assets/1a8cd268-e624-4ceb-911d-536d68d0913c" />



