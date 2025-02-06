# AWSHPC: High-Performance Computing on AWS

## Overview
AWSHPC is a complete solution for deploying and managing a high-performance computing (HPC) cluster on AWS. This project leverages AWS ParallelCluster, EKS, FSx for Lustre, and GPU-accelerated workloads for AI/ML applications.

## Features
- **AWS ParallelCluster** for managing HPC compute nodes
- **Amazon EKS** for containerized ML workloads
- **FSx for Lustre** for high-performance storage
- **GPUs & AI Accelerators** for deep learning applications
- **Monitoring with Prometheus & Grafana**

## Architecture
AWSHPC consists of the following core components:
- **Compute Nodes:** Managed via AWS ParallelCluster
- **Kubernetes Cluster:** Deployed with Amazon EKS
- **High-Speed Storage:** FSx for Lustre
- **Networking:** High-speed interconnects such as InfiniBand

## Deployment
1. Clone the repository:
   ```sh
   git clone https://github.com/yourusername/AWSHPC.git
   cd AWSHPC
   ```
2. Deploy AWS ParallelCluster:
   ```sh
   pcluster create-cluster --cluster-name my-hpc-cluster --cluster-configuration infrastructure/parallelcluster.yaml
   ```
3. Deploy Kubernetes (EKS):
   ```sh
   terraform -chdir=infrastructure apply -auto-approve
   ```
4. Deploy ML Workloads:
   ```sh
   kubectl apply -f kubernetes/jupyter.yaml
   kubectl apply -f kubernetes/tensorflow_gpu.yaml
   ```

## Monitoring
Enable monitoring with Prometheus & Grafana:
```sh
kubectl apply -f kubernetes/prometheus_grafana.yaml
```

## Troubleshooting
Refer to the [Troubleshooting Guide](docs/troubleshooting.md) for common issues and solutions.

## License
This project is licensed under the MIT License.

