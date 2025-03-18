#!/bin/bash

# Apply the service definition
kubectl apply -f nginx-service.yaml

# Check if the service is running
kubectl get svc nginx-service

echo "Nginx Service has been successfully deployed! Use 'kubectl get svc' to check the assigned NodePort."
