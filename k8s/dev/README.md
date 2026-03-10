# Dev Kubernetes Templates

This folder is organized as requested:

- `templates/namespace.yaml`
- `templates/secret.yaml`
- `templates/service.yaml`
- `templates/probe.yaml`
- `templates/config.yaml`
- `templates/deployment.yaml` (single template containing full pod/deployment spec)
- `application-service/dev-value.yml`
- `order-service/dev-value.yml`
- `patient-service/dev-value.yml`

## Create local dev cluster

Run:
kind create cluster --config k8s/dev/kind-cluster.yaml

## Render and apply each service

Run:
helm template app-dev k8s/dev -f k8s/dev/application-service/dev-value.yml | kubectl apply -f -
helm template order-dev k8s/dev -f k8s/dev/order-service/dev-value.yml | kubectl apply -f -
helm template patient-dev k8s/dev -f k8s/dev/patient-service/dev-value.yml | kubectl apply -f -

## Verify

Run:
kubectl get ns
kubectl get deploy -n application-dev
kubectl get deploy -n order-dev
kubectl get deploy -n patient-dev
kubectl get pods -n application-dev
kubectl get pods -n order-dev
kubectl get pods -n patient-dev
