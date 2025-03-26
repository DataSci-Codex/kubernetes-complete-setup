# Kubernetes Nginx Deployment

This repository contains an automated setup for deploying an **Nginx web server** on a **Kubernetes cluster**.

## Prerequisites

Before deploying, ensure you have:
- A running **Kubernetes cluster**
- `kubectl` installed and configured

## Deployment Steps

### 1. Download and Run the Deployment Script
```sh
wget https://raw.githubusercontent.com/DataSci-Codex/kubernetes-complete-setup/main/deploy-nginx.sh
chmod +x deploy-nginx.sh
./deploy-nginx.sh
```

### 2. Verify Deployment and Process
- Create a YAML file using nano
```sh
nano nginx.yaml
```
- Create the Resource Using kubectl create
```sh
kubectl create -f nginx.yaml
```
- Apply Changes Using kubectl apply
```sh
kubectl apply -f nginx.yaml
```
- Update System Packages
```sh
sudo apt-get update
```
- List All Running Pods
```sh
kubectl get pods
```
- List Kubernetes Deployments
```sh
kubectl get deployment
```
- List Kubernetes Services
```sh
kubectl get service
```
- List All Pods in All Namespaces
```sh
kubectl get pods --all-namespaces
```
- View Kubernetes Cluster Information
```sh
kubectl cluster-info
```
```sh
kubectl get pods
kubectl get deployments
kubectl get services
```

### 3. Access the Nginx Application
To expose the deployment, create a service:
```sh
kubectl expose deployment nginx-deployment --type=NodePort --port=80
kubectl get svc nginx-deployment
```

### 4. Delete Deployment and Service
```sh
kubectl delete deployment nginx-deployment
kubectl delete service nginx-deployment
```

## Deployment YAML File

```yaml
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
```

## Final Steps
🎉 **Your Nginx application is successfully deployed in Kubernetes!** 🚀  

---

## Contributing
Feel free to submit **pull requests** or **issues** for improvements.

