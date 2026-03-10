Argo CD deployment for dev environment

Files in this folder:
- project.yaml: Argo CD project for dev namespaces
- applications.yaml: 3 Argo CD applications, one per service

Deploy steps:
1. Install Argo CD in cluster
   kubectl create namespace argocd
   kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml

2. Apply project and applications
   kubectl apply -f argocd/dev/project.yaml
   kubectl apply -f argocd/dev/applications.yaml

3. Verify sync
   kubectl get applications -n argocd
   kubectl describe application application-service-dev -n argocd
   kubectl describe application order-service-dev -n argocd
   kubectl describe application patient-service-dev -n argocd

Notes:
- Repo branch tracked: hcl
- Chart path used by Argo CD: k8s/dev
- Per-service values files:
  - application-service/dev-value.yml
  - order-service/dev-value.yml
  - patient-service/dev-value.yml
