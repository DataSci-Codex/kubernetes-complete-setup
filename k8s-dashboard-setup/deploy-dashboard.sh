#!/bin/bash

echo "Deploying Kubernetes Dashboard..."

# Deploy the official Kubernetes Dashboard
kubectl create -f https://raw.githubusercontent.com/kubernetes/dashboard/v2.7.0/aio/deploy/recommended.yaml

echo "Modifying Kubernetes Dashboard service to use NodePort..."

# Change the service type from ClusterIP to NodePort
kubectl patch svc kubernetes-dashboard -n kubernetes-dashboard --type='json' -p '[{"op":"replace","path":"/spec/type","value":"NodePort"}]'

# Get the assigned NodePort
NODE_PORT=$(kubectl get svc kubernetes-dashboard -n kubernetes-dashboard -o jsonpath="{.spec.ports[0].nodePort}")
echo "Dashboard is accessible at https://<NODE_IP>:${NODE_PORT}"

# Create an admin service account
echo "Creating admin service account for the Dashboard..."
kubectl create serviceaccount cluster-admin-dashboard-sa -n kubernetes-dashboard

# Grant cluster-admin role to the service account
echo "Assigning cluster-admin privileges..."
kubectl create clusterrolebinding cluster-admin-dashboard-sa   --clusterrole=cluster-admin   --serviceaccount=kubernetes-dashboard:cluster-admin-dashboard-sa

# Generate and display the login token
echo "Fetching authentication token for Kubernetes Dashboard login..."
kubectl -n kubernetes-dashboard create token cluster-admin-dashboard-sa

echo "Kubernetes Dashboard has been successfully deployed! Use the token above to log in."
