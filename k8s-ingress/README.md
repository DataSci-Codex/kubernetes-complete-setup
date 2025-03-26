# Kubernetes Nginx Deployment with NodePort and Ingress

This repository provides an automated setup for deploying an **Nginx web server**, exposing it using a **NodePort service**, and configuring an **Ingress controller** on a **Kubernetes cluster**.

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

### 4. Deploy the Ingress Controller and Ingress Resource
```sh
wget https://raw.githubusercontent.com/DataSci-Codex/kubernetes-complete-setup/main/deploy-ingress.sh
chmod +x deploy-ingress.sh
./deploy-ingress.sh
```
### 5. Check the Ingress and Service Details
- Deploy the Ingress Controller (Cloud Environment)
```sh
kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/controller-v0.44.0/deploy/static/provider/cloud/deploy.yaml
```
- Deploy the Ingress Controller (Bare Metal Environment)
```sh
kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/controller-v0.44.0/deploy/static/provider/baremetal/deploy.yaml
```
- Verify the Ingress Controller Deployment
```sh
kubectl get pods --all-namespaces -l app.kubernetes.io/name=ingress-nginx
```
- Create nano ingress.yaml
*Opens a text editor (nano) to create the Ingress configuration file.
Paste the following YAML configuration:*
```sh
nano ingress.yaml
```
- Apply the Ingress Configuration
```sh
kubectl create -f ingress.yaml
```
- Verify the Ingress Service
```sh
kubectl get svc -n ingress-nginx
```
- Displays all Ingress resources in the default namespace.
```sh
kubectl get ingress
```

### 6. Access the Nginx Application via Ingress
- Ensure DNS is configured for `hello-world.example.com`
- Access the application using:
  ```sh
  http://hello-world.example.com
  ```

### 7. Delete Deployment, Service, and Ingress
```sh
kubectl delete deployment nginx-deployment
kubectl delete service nginx-service
kubectl delete ingress hello-world
```

## Deployment YAML Files

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

### **Ingress Resource (`ingress.yaml`)**
```yaml
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
```

## Final Steps
🎉 **Your Nginx application is successfully deployed, exposed via NodePort, and configured with Ingress!** 🚀  

---

## Contributing
Feel free to submit **pull requests** or **issues** for improvements.

