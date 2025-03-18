# Kubernetes Nginx Deployment with NodePort Service

This repository provides an automated setup for deploying an **Nginx web server** and exposing it using a **NodePort service** on a **Kubernetes cluster**.

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

### 2. Verify Deployment
```sh
kubectl get pods
kubectl get deployments
kubectl get services
```

### 3. Deploy the NodePort Service for Nginx
```sh
wget https://raw.githubusercontent.com/DataSci-Codex/kubernetes-complete-setup/main/deploy-nginx-service.sh
chmod +x deploy-nginx-service.sh
./deploy-nginx-service.sh
```

### 4. Check the Service Details
```sh
kubectl get svc nginx-service
```

### 5. Access the Nginx Application
- Find the **NodePort** assigned to the service:
  ```sh
  kubectl get svc nginx-service
  ```
- Access the application in a browser using:  
  ```sh
  http://<NODE_IP>:<NODE_PORT>
  ```

### 6. Delete Deployment and Service
```sh
kubectl delete deployment nginx-deployment
kubectl delete service nginx-service
```

## Deployment YAML File

### **Nginx Deployment (`nginx-deployment.yaml`)**
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

### **NodePort Service (`nginx-service.yaml`)**
```yaml
apiVersion: v1
kind: Service
metadata:
  name: nginx-service
spec:
  type: NodePort
  selector:
    app: nginx
  ports:
    - protocol: TCP
      port: 80
      targetPort: 80
      nodePort: 30007  # Change this if necessary
```

## Final Steps
🎉 **Your Nginx application is successfully deployed and exposed in Kubernetes!** 🚀  

---

## Contributing
Feel free to submit **pull requests** or **issues** for improvements.
