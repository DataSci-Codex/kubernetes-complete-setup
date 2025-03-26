# Kubernetes Nginx Deployment with NodePort, Ingress, and Dashboard

This repository provides an automated setup for deploying an **Nginx web server**, exposing it via **NodePort and Ingress**, and setting up the **Kubernetes Dashboard** for cluster management.

## Prerequisites

Before deploying, ensure you have:
- A running **Kubernetes cluster**
- `kubectl` installed and configured

## Deployment Steps

### 1. Deploy Nginx Application
```sh
wget https://raw.githubusercontent.com/DataSci-Codex/kubernetes-complete-setup/main/deploy-nginx.sh
chmod +x deploy-nginx.sh
./deploy-nginx.sh
```

### 2. Deploy NodePort Service for Nginx
```sh
wget https://raw.githubusercontent.com/DataSci-Codex/kubernetes-complete-setup/main/deploy-nginx-service.sh
chmod +x deploy-nginx-service.sh
./deploy-nginx-service.sh
```

### 3. Deploy Ingress Controller and Ingress Resource
```sh
wget https://raw.githubusercontent.com/DataSci-Codex/kubernetes-complete-setup/main/deploy-ingress.sh
chmod +x deploy-ingress.sh
./deploy-ingress.sh
```

### 4. Deploy Kubernetes Dashboard
```sh
wget https://raw.githubusercontent.com/DataSci-Codex/kubernetes-complete-setup/main/deploy-dashboard.sh
chmod +x deploy-dashboard.sh
./deploy-dashboard.sh
```

### 5. Access Kubernetes Dashboard
- Deploy Kubernetes Dashboard
*This downloads and applies the official Kubernetes Dashboard YAML file.*
  ```sh
  kubectl create -f https://raw.githubusercontent.com/kubernetes/dashboard/v2.7.0/aio/deploy/recommended.yaml
  ```
- Modify Dashboard Service from ***ClusterIP** to **NodePort**
  ```sh
  kubectl edit svc kubernetes-dashboard -n kubernetes-dashboard
  ```
- Find the assigned **NodePort** for the Dashboard:
  ```sh
  kubectl get svc kubernetes-dashboard -n kubernetes-dashboard
  ```
- Open the Dashboard in a browser:
  ```sh
  https://<NODE_IP>:<NODE_PORT>
  ```
- Get the **admin login token**:
  ```sh
  kubectl -n kubernetes-dashboard create token cluster-admin-dashboard-sa
  ```
- Copy and paste the token into the login page.

- Grant Cluster Admin Permissions:
  ```sh
  kubectl create clusterrolebinding cluster-admin-dashboard-sa \
  --clusterrole=cluster-admin \
  --serviceaccount=kubernetes-dashboard:cluster-admin-dashboard-sa
  ```
- Get the Dashboard Login Token:
  ```sh
  kubectl -n kubernetes-dashboard create token cluster-admin-dashboard-sa
  ```

### 6. Delete Deployment, Service, and Ingress
```sh
kubectl delete deployment nginx-deployment
kubectl delete service nginx-service
kubectl delete ingress hello-world
kubectl delete -f https://raw.githubusercontent.com/kubernetes/dashboard/v2.7.0/aio/deploy/recommended.yaml
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

### **Kubernetes Dashboard Service (`dashboard-service.yaml`)**
```yaml
apiVersion: v1
kind: Service
metadata:
  name: kubernetes-dashboard
  namespace: kubernetes-dashboard
spec:
  type: NodePort
  selector:
    k8s-app: kubernetes-dashboard
  ports:
    - port: 443
      targetPort: 8443
      nodePort: 30905  # Change this if necessary
```

## Final Steps
🎉 **Your Nginx application is successfully deployed, exposed via NodePort and Ingress, and the Kubernetes Dashboard is set up for cluster management!** 🚀  

---

## Contributing
Feel free to submit **pull requests** or **issues** for improvements.

