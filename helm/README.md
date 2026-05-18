Structure of HELM Chart as mentioned below.
--------------
einfochips@91P2S24:~/AWS_Learning/helm/helm-chart-explore$ tree
.
└── charts
    └── ui
        ├── Chart.yaml
        ├── README.md
        ├── templates
        │   ├── configmap.yml
        │   ├── deployment.yaml
        │   ├── _helpers.tpl
        │   ├── hpa.yaml
        │   ├── ingress.yaml
        │   ├── istio-gateway.yml
        │   ├── istio-virtualservice.yml
        │   ├── NOTES.txt
        │   ├── pdb.yaml
        │   ├── serviceaccount.yaml
        │   ├── service.yaml
        │   └── tests
        │       └── test-connection.yaml
        └── values.yaml

5 directories, 15 files
einfochips@91P2S24:~/AWS_Learning/helm/helm-chart-explore$ 

-----------------------------

<img width="1920" height="1200" alt="Screenshot from 2026-05-18 14-38-36" src="https://github.com/user-attachments/assets/b8d8ec36-34a9-4c2c-b5aa-d7c9c0759435" />

<img width="1920" height="1200" alt="Screenshot from 2026-05-18 16-22-36" src="https://github.com/user-attachments/assets/6f1e6413-20ca-4b81-b901-061e7c4f4cd8" />

<img width="1920" height="1200" alt="Screenshot from 2026-05-18 16-36-08" src="https://github.com/user-attachments/assets/c1b24141-c575-4acb-a297-edc326f3ebdd" />

<img width="1920" height="1200" alt="Screenshot from 2026-05-18 16-38-39" src="https://github.com/user-attachments/assets/95868e46-3586-42a3-8265-ed75ad9ec46c" />
