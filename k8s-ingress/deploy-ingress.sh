#!/bin/bash

echo "Deploying Kubernetes Ingress Controller..."

# Deploy Ingress Controller for Cloud Environments
kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/controller-v0.44.0/deploy/static/provider/cloud/deploy.yaml

# Deploy Ingress Controller for Bare Metal Environments
kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/controller-v0.44.0/deploy/static/provider/baremetal/deploy.yaml

# Wait for Ingress Controller to start
echo "Waiting for Ingress Controller pods to be ready..."
kubectl wait --namespace ingress-nginx   --for=condition=ready pod   --selector=app.kubernetes.io/name=ingress-nginx   --timeout=120s

# Verify Ingress Controller deployment
kubectl get pods --all-namespaces -l app.kubernetes.io/name=ingress-nginx

echo "Creating Ingress Resource..."

# Create the Ingress YAML file
cat <<EOF > ingress.yaml
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: hello-world
spec:
  rules:
    - host: hello-world.example.com
      http:
        paths:
          - path: /
            pathType: Prefix
            backend:
              service:
                name: hello-world
                port:
                  number: 80
EOF

# Apply the Ingress resource
kubectl apply -f ingress.yaml

# Verify the Ingress resource and services
kubectl get svc -n ingress-nginx
kubectl get ingress

echo "Ingress setup is complete! Ensure DNS is configured for hello-world.example.com to point to the Ingress Controller."
