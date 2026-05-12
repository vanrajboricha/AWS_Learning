AWS COnsole Cluster Details.

<img width="1920" height="1200" alt="Screenshot from 2026-05-10 14-32-06" src="https://github.com/user-attachments/assets/c7dbde9b-9c87-4269-b5e1-bc75d6b7678e" />

AWS Cluster Details from Terminal.

<img width="1233" height="958" alt="Screenshot from 2026-05-10 14-30-58" src="https://github.com/user-attachments/assets/f1cbd18d-028a-4128-a1eb-218fc41f3624" />


<img width="1149" height="816" alt="image" src="https://github.com/user-attachments/assets/ce6627a0-953d-4f28-b2e6-97c2ebfad5d2" />


-------------------------------
##OUTPUT of Cluster Infomation
--------------------------------

einfochips@91P2S24:~/AWS_Learning$ kubectl get all --all-namespaces
NAMESPACE     NAME                           READY   STATUS    RESTARTS   AGE
kube-system   pod/aws-node-7b5f8             2/2     Running   0          2m23s
kube-system   pod/aws-node-ckv6t             2/2     Running   0          2m23s
kube-system   pod/aws-node-rqttj             2/2     Running   0          2m24s
kube-system   pod/coredns-66cff8d9f9-c99k8   1/1     Running   0          7m58s
kube-system   pod/coredns-66cff8d9f9-sxr9t   1/1     Running   0          7m58s
kube-system   pod/kube-proxy-9llps           1/1     Running   0          2m24s
kube-system   pod/kube-proxy-bfz2c           1/1     Running   0          2m23s
kube-system   pod/kube-proxy-kj4st           1/1     Running   0          2m23s

NAMESPACE     NAME                                TYPE        CLUSTER-IP       EXTERNAL-IP   PORT(S)                  AGE
default       service/kubernetes                  ClusterIP   172.20.0.1       <none>        443/TCP                  9m1s
kube-system   service/eks-extension-metrics-api   ClusterIP   172.20.209.132   <none>        443/TCP                  8m59s
kube-system   service/kube-dns                    ClusterIP   172.20.0.10      <none>        53/UDP,53/TCP,9153/TCP   7m59s

NAMESPACE     NAME                        DESIRED   CURRENT   READY   UP-TO-DATE   AVAILABLE   NODE SELECTOR   AGE
kube-system   daemonset.apps/aws-node     3         3         3       3            3           <none>          7m58s
kube-system   daemonset.apps/kube-proxy   3         3         3       3            3           <none>          7m59s

NAMESPACE     NAME                      READY   UP-TO-DATE   AVAILABLE   AGE
kube-system   deployment.apps/coredns   2/2     2            2           7m59s

NAMESPACE     NAME                                 DESIRED   CURRENT   READY   AGE
kube-system   replicaset.apps/coredns-66cff8d9f9   2         2         2       7m58s
einfochips@91P2S24:~/AWS_Learning$ 
##=======================================================


