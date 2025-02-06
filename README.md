# AWS HPC Cluster Management Project

## Repository Overview
This repository contains all necessary scripts, configurations, and documentation for deploying a high-performance computing (HPC) cluster on AWS using ParallelCluster, Kubernetes (EKS), and parallel file systems.

### **Directory Structure**
```
AWSHPC/
│── infrastructure/            # Terraform/CloudFormation scripts for AWS resources
│   ├── parallelcluster.yaml  # ParallelCluster config
│   ├── eks_cluster.tf        # EKS cluster setup
│   ├── fsx_lustre.tf         # FSx Lustre storage config
│── kubernetes/               # K8s manifests for ML workloads
│   ├── jupyter.yaml          # JupyterHub deployment
│   ├── tensorflow_gpu.yaml   # TensorFlow GPU workload
│   ├── prometheus_grafana.yaml # Monitoring setup
│── scripts/                  # Support and troubleshooting scripts
│   ├── monitor_cluster.sh    # Prometheus metrics script
│   ├── check_slurm_status.sh # Slurm job monitoring
│── notebooks/                # Sample Jupyter notebooks for ML workloads
│   ├── tensorflow_benchmark.ipynb # ML benchmark test
│── docs/                     # Documentation and troubleshooting playbook
│   ├── setup_guide.md        # Cluster deployment steps
│   ├── troubleshooting.md    # Common HPC issues and solutions
│   ├── performance_testing.md # GPU & filesystem performance tests
```

**AWS Environment Setup**
Before deployment, set up the necessary AWS infrastructure.

Prerequisites

✅ AWS Account

✅ IAM Permissions – Administrator or a role with EC2, S3, EKS, FSx, CloudFormation, and CloudWatch access

✅ AWS CLI Installed

✅ ParallelCluster CLI Installed (pip install aws-parallelcluster)

✅ kubectl Installed (for Kubernetes management)

✅ Docker Installed (if building custom container images)

---

## **1. Deploy the HPC Cluster**
### **Step 1: Configure ParallelCluster**
```sh
pcluster create-cluster --cluster-name my-hpc-cluster --cluster-configuration infrastructure/parallelcluster.yaml
```

### **Step 2: Deploy Kubernetes (EKS)**
```sh
terraform -chdir=infrastructure apply -auto-approve
```

### **Step 3: Deploy Jupyter & ML Workloads**
```sh
kubectl apply -f kubernetes/jupyter.yaml
kubectl apply -f kubernetes/tensorflow_gpu.yaml
```

---

## **2. Monitoring & Support**
### **Enable Logging & Monitoring**
```sh
kubectl apply -f kubernetes/prometheus_grafana.yaml
```

### **Run Cluster Health Check**
```sh
./scripts/monitor_cluster.sh
```

---

## **3. Troubleshooting Guide**
### **Common Issues & Fixes**
| Issue | Symptom | Solution |
|-------|--------|----------|
| Lustre Not Mounting | `df -h` doesn’t show `/fsx` | Run `sudo mount -t lustre …` |
| GPUs Not Detected | `nvidia-smi` shows no devices | Restart `nvidia-persistenced` service |
| Slurm Not Scheduling Jobs | `squeue` shows jobs stuck | Restart `slurmctld` |

---

## **Next Steps**
✅ Deploy and test the cluster  
✅ Document any issues and improvements  
✅ Demo video for portfolio?

---
This repository serves as a **complete AWS HPC cluster management project**, demonstrating expertise in **AWS, HPC, Kubernetes, ML workloads, and system troubleshooting**. 🚀
