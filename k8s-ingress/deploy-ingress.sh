#!/bin/bash

# Deploy the Ingress Controller (Cloud Environment)
kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/controller-v0.44.0/deploy/static/provider/cloud/deploy.yaml

# Deploy the Ingress Controller (Bare Metal)
kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/controller-v0.44.0/deploy/static/provider/baremetal/deploy.yaml

# Verify Ingress Controller Deployment
kubectl get pods --all-namespaces -l app.kubernetes.io/name=ingress-nginx

# Apply the Ingress Resource
kubectl apply -f ingress.yaml

# Check the Ingress and Service details
kubectl get svc -n ingress-nginx
kubectl get ingress

echo "Ingress has been successfully deployed! Ensure DNS is configured for hello-world.example.com."
