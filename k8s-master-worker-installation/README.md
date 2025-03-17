# Kubernetes Master and Worker Node Installation on AWS (Ubuntu t3.medium)

This repository provides a **step-by-step guide** and **automation scripts** for setting up a **Kubernetes Cluster** with a **Master Node** and **Worker Nodes** on **AWS EC2 (Ubuntu t3.medium instances)**.

---

## 📌 Prerequisites
Before you begin, ensure you have:  
✅ An AWS account with EC2 access  
✅ Ubuntu 22.04 (or compatible) running on **t3.medium** instances  
✅ Security group allowing required ports  
✅ SSH access to EC2 instances  

---

## 🔒 Security Group Configuration
Ensure the following ports are open for Kubernetes communication:

| **Component**    | **Ports**           | **Purpose**                     |
|----------------|------------------|-------------------------------|
| API Server    | 6443             | Kubernetes API access        |
| etcd         | 2379-2380        | Kubernetes etcd data storage |
| Kubelet      | 10250-10255      | Node communication           |
| Calico       | 179              | Network policy enforcement   |
| HTTPS        | 443              | Secure communication         |
| DNS         | 53               | Cluster DNS resolution       |
| NodePort Services | 30000-32767 | External service access      |

---

## 🚀 Step 1: Setting Up the Master Node

### **1. Download and Execute Master Setup Script**
```sh
wget https://raw.githubusercontent.com/DataSci-Codex/kubernetes-complete-setup/main/k8s-master-worker-installation/setup-master.sh
chmod +x setup-master.sh
./setup-master.sh
```

### **2. Get the Join Command for Worker Nodes**
After the script execution, run:
```sh
kubeadm token create --print-join-command
```
- Copy the output, as it will be required for the Worker Node setup.

---

## 🚀 Step 2: Setting Up Worker Nodes

### **1. Download and Execute Worker Setup Script**
```sh
wget https://raw.githubusercontent.com/DataSci-Codex/kubernetes-complete-setup/main/k8s-master-worker-installation/setup-worker.sh
chmod +x setup-worker.sh
./setup-worker.sh
```

### **2. Join Worker Node to Kubernetes Cluster**
Run the **join command** (from the Master Node) on each **Worker Node**:
```sh
kubeadm join <MASTER_IP>:6443 --token <TOKEN> \
    --discovery-token-ca-cert-hash sha256:<CERT_HASH>
```

---

## ✅ Step 3: Verification

### **Check Node Status**
```sh
kubectl get nodes
```
#### **Expected Output:**
```sh
NAME           STATUS   ROLES           AGE     VERSION
MasterNode    Ready    control-plane   10m     v1.29
WorkerNode    Ready    worker          2m      v1.29
```

### **Check Cluster Information**
```sh
kubectl cluster-info
```

---

## 🎯 Kubernetes Architecture  
Below is a high-level diagram of the **Kubernetes cluster setup**:

![Kubernetes Architecture](https://raw.githubusercontent.com/DataSci-Codex/kubernetes-complete-setup/main/k8s-master-worker-installation/k8s-architecture.png)

---

## 🎉 Final Steps  
✅ **Your Kubernetes Master and Worker Nodes have been successfully added to the cluster!** 🚀  
You are now ready to deploy pods, services, and workloads in your Kubernetes environment.

---

## 🤝 Contributing  
Feel free to submit **pull requests** or **issues** for improvements.

---

💡 **Happy Kubernetes Deployment!** 🚀
