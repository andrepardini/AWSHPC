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
   git clone https://github.com/andrepardini/AWSHPC.git
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

## File Structure

The repository will have the following structure to ensure a well-organized AWS HPC (AWSHPC) project:

```AWSHPC/
│── infrastructure/            # Infrastructure as Code (Terraform & ParallelCluster)
│   ├── parallelcluster.yaml  # AWS ParallelCluster configuration
│   ├── eks_cluster.tf        # Terraform script to create an EKS cluster
│   ├── fsx_lustre.tf         # Terraform script for FSx for Lustre
│   ├── vpc.tf                # Terraform script for networking setup
│── kubernetes/               # Kubernetes manifests for ML workloads
│   ├── jupyter.yaml          # JupyterHub deployment on EKS
│   ├── tensorflow_gpu.yaml   # TensorFlow workload with GPU support
│   ├── prometheus_grafana.yaml # Monitoring setup using Prometheus & Grafana
│── scripts/                  # Helper scripts for automation & monitoring
│   ├── monitor_cluster.sh    # Script to check cluster health
│   ├── check_slurm_status.sh # Slurm job monitoring script
│── notebooks/                # Jupyter notebooks for benchmarking & ML experiments
│   ├── tensorflow_benchmark.ipynb # Benchmarking TensorFlow performance
│── docs/                     # Documentation for setup, troubleshooting, and performance tuning
│   ├── setup_guide.md        # Step-by-step deployment guide
│   ├── troubleshooting.md    # Common issues & solutions
│   ├── performance_testing.md # Performance optimization tips
│── .github/                   # GitHub-specific configurations (e.g., workflows)
│   ├── workflows/ci-cd.yaml  # CI/CD pipeline for infrastructure automation
│── README.md                 # Project overview and setup instructions
│── LICENSE                   # Open-source license file
│── .gitignore                # Git ignore file for unnecessary files
 ```
