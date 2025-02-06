### **AWSHPC: High-Performance Computing on AWS
**
### **Overview
**
AWSHPC is a complete solution for deploying and managing a high-performance computing (HPC) cluster on AWS. This project leverages AWS ParallelCluster, EKS, FSx for Lustre, and GPU-accelerated workloads for AI/ML applications.

### **Features
**
**AWS ParallelCluster** for managing HPC compute nodes

**Amazon EKS** for containerized ML workloads

**FSx for Lustre** for high-performance storage

**GPUs & AI Accelerators** for deep learning applications

**Monitoring with Prometheus & Grafana**

### **Architecture**

AWSHPC consists of the following core components:

**Compute Nodes:** Managed via AWS ParallelCluster

**Kubernetes Cluster**: Deployed with Amazon EKS

**High-Speed Storage:** FSx for Lustre

**Networking:** High-speed interconnects such as InfiniBand

### **Deployment**

Clone the repository:

git clone https://github.com/yourusername/AWSHPC.git
cd AWSHPC

Deploy AWS ParallelCluster:

pcluster create-cluster --cluster-name my-hpc-cluster --cluster-configuration infrastructure/parallelcluster.yaml

Deploy Kubernetes (EKS):

terraform -chdir=infrastructure apply -auto-approve

Deploy ML Workloads:

kubectl apply -f kubernetes/jupyter.yaml
kubectl apply -f kubernetes/tensorflow_gpu.yaml

Monitoring

Enable monitoring with Prometheus & Grafana:

kubectl apply -f kubernetes/prometheus_grafana.yaml

Troubleshooting

Refer to the Troubleshooting Guide for common issues and solutions.

License

This project is licensed under the MIT License.
