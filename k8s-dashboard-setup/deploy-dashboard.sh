#!/bin/bash

# Deploy the Kubernetes Dashboard
kubectl create -f https://raw.githubusercontent.com/kubernetes/dashboard/v2.7.0/aio/deploy/recommended.yaml

# Modify the Dashboard service to use NodePort
kubectl patch svc kubernetes-dashboard -n kubernetes-dashboard --type='json' -p '[{"op":"replace","path":"/spec/type","value":"NodePort"}]'

# Get the assigned NodePort
kubectl get svc kubernetes-dashboard -n kubernetes-dashboard

# Create an admin service account
kubectl create serviceaccount cluster-admin-dashboard-sa -n kubernetes-dashboard

# Grant cluster-admin role to the service account
kubectl create clusterrolebinding cluster-admin-dashboard-sa   --clusterrole=cluster-admin   --serviceaccount=kubernetes-dashboard:cluster-admin-dashboard-sa

# Get and display the login token
kubectl -n kubernetes-dashboard create token cluster-admin-dashboard-sa

echo "Kubernetes Dashboard is deployed! Access it using: https://<NODE_IP>:<NODE_PORT>"
