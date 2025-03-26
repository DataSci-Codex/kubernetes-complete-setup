#!/bin/bash

# Update the system packages
sudo apt-get update

# Create the deployment YAML file
cat <<EOF > nginx.yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: nginx-deployment
spec:
  selector:
    matchLabels:
      app: nginx
  replicas: 2
  template:
    metadata:
      labels:
        app: nginx
    spec:
      containers:
      - name: nginx
        image: nginx:1.14.2
        ports:
        - containerPort: 80
EOF

# Deploy the Nginx application
kubectl create -f nginx.yaml
kubectl apply -f nginx.yaml


# Check deployment status
kubectl get deployments
kubectl get pods

echo "Nginx deployment is successfully applied! Run 'kubectl get services' to check service details."
