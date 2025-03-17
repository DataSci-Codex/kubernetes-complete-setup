#!/bin/bash

# Define the root repository name
ROOT_REPO="kubernetes-complete-setup"

# Clone the root repository
git clone https://github.com/DataSci-Codex/$ROOT_REPO.git
cd $ROOT_REPO

# Create directories for each sub-project inside the root repository
mkdir -p k8s-master-worker-installation
mkdir -p k8s-nginx-deployment
mkdir -p k8s-services
mkdir -p k8s-ingress
mkdir -p k8s-dashboard-setup

echo "✅ Directory structure created successfully!"

# Move files from existing repositories (Assumes they are cloned in the parent directory)
if [ -d "../k8s-master-worker-installation" ]; then
    mv ../k8s-master-worker-installation/* k8s-master-worker-installation/
fi

if [ -d "../k8s-nginx-deployment" ]; then
    mv ../k8s-nginx-deployment/* k8s-nginx-deployment/
fi

if [ -d "../k8s-services" ]; then
    mv ../k8s-services/* k8s-services/
fi

if [ -d "../k8s-ingress" ]; then
    mv ../k8s-ingress/* k8s-ingress/
fi

if [ -d "../k8s-dashboard-setup" ]; then
    mv ../k8s-dashboard-setup/* k8s-dashboard-setup/
fi

echo "✅ Moved files from sub-repositories into respective directories!"

# Add, commit, and push changes to GitHub
git add .
git commit -m "Structured repository with all Kubernetes setup subdirectories"
git push origin main

echo "🚀 Repository structure setup is complete and changes pushed to GitHub!"

