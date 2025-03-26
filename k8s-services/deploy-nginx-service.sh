#!/bin/bash

# Create a NodePort Service for Nginx
kubectl create service nodeport nginx --tcp=80:80
# Creates a NodePort service for the nginx deployment.
#Exposes port 80 inside the cluster and assigns a NodePort (e.g., 30000-32767).

# Apply the service definition
kubectl apply -f nginx-service.yaml

# Check if the service is running
kubectl get svc nginx-service
#Verify the Service
#Displays details of the nginx service.
#Shows the assigned ClusterIP, External IP, and NodePort.

echo "Nginx Service has been successfully deployed! Use 'kubectl get svc' to check the assigned NodePort."
