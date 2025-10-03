# AWS HPC Cluster Management with Kubernetes and Parallel File Systems

## Project Overview

This project demonstrates the setup, management, and support of a High-Performance Computing (HPC) cluster on AWS using AWS ParallelCluster and Kubernetes.  It integrates GPUs, parallel file systems, and machine learning workloads.

## Technologies Used

*   **AWS ParallelCluster:**  Provisions and manages the HPC cluster.
*   **EKS (Kubernetes):** Deploys and manages containerized ML workloads.
*   **NVIDIA GPUs (AWS p4d instances):** Accelerates AI/ML tasks.
*   **Amazon FSx for Lustre / Ceph / BeeGFS:**  Offers parallel file storage.
*   **Jupyter Notebook:** Enables interactive ML workload execution.
*   **Prometheus & Grafana:** Monitors cluster performance.
*   **AWS CloudWatch Logs:** Aids in troubleshooting and diagnostics..

## Project Structure

*   `cluster-deployment/`: Contains AWS ParallelCluster configuration and scripts.
*   `kubernetes/`:  Holds Kubernetes manifests for workload management.
*   `monitoring/`:  Includes Prometheus, Grafana, and CloudWatch configuration.
*   `ml-workloads/`:  Provides example machine learning workloads.
*   `docs/`: Contains documentation, including a setup guide, troubleshooting playbook, and performance benchmarks.

## Getting Started

1.  **Clone the repository:**
    ```bash
    git clone https://github.com/andrepardini/AWSHPC
    cd AWSHPC
    ```
2.  **Follow the setup guide in `docs/setup_guide.md` for detailed instructions.**

## Deliverables

*   [x] GitHub Repository: Contains AWS CloudFormation/Terraform scripts, Kubernetes manifests, and sample ML workloads.
*   [ ] Documentation: Includes setup guide, troubleshooting playbook, and performance benchmarks.
*   [ ] Customer Support Use Cases: Common issues and resolutions for an HPC environment.

## Contributing

TBD

## License

License information TBD

## File Structure

The repository will have the following structure to ensure the project stayswell-organized:

```AWSHPC/
├── cluster-deployment/           # AWS ParallelCluster configuration
│   ├── parallelcluster.yaml      # ParallelCluster configuration file
│   ├── scripts/                  # Scripts for cluster management
│   │   ├── start_cluster.sh    # Script to start the cluster
│   │   ├── stop_cluster.sh     # Script to stop the cluster
│   │   └── update_cluster.sh   # Script to update the cluster
│   └── README.md                # Instructions on deploying the cluster
├── kubernetes/                   # Kubernetes manifests
│   ├── jupyter/                 # Jupyter Notebook deployment
│   │   ├── deployment.yaml     # Jupyter deployment
│   │   ├── service.yaml        # Jupyter service
│   │   └── ingress.yaml        # Jupyter ingress (optional)
│   ├── spark/                    # Spark deployment
│   │   ├── spark-master.yaml  # Spark Master deployment
│   │   ├── spark-worker.yaml  # Spark Worker deployment
│   │   └── README.md            # instructions on how to deploy spark
│   ├── storage/                  # Ceph/BeeGFS storage configurations
│   │   ├── ceph/                # Ceph manifests (example)
│   │   │   ├── ceph-operator.yaml # Ceph operator
│   │   │   └── ceph-cluster.yaml  # Ceph cluster definition
│   │   └── beegfs/              # BeeGFS manifests (example)
│   │   │   ├── beegfs-client.yaml # BeeGFS Client
│   │   │   └── beegfs-meta.yaml # BeeGFS metadata
│   │   └── README.md            # Instructions to configure storage
│   └── README.md                # Instructions on Kubernetes setup
├── monitoring/                   # Prometheus & Grafana configuration
│   ├── prometheus/               # Prometheus configuration
│   │   ├── prometheus.yaml      # Prometheus configuration file
│   │   └── service-monitor.yaml # Prometheus service monitors (optional)
│   ├── grafana/                  # Grafana configuration
│   │   ├── dashboards/          # Grafana dashboard definitions
│   │   │   └── hpc-dashboard.json # HPC cluster dashboard
│   │   ├── datasources/          # Grafana data sources
│   │   │   └── prometheus.yaml  # Prometheus data source
│   │   └── README.md            # Instructions on monitoring setup
│   └── cloudwatch/               # CloudWatch configuration
│   │   ├── cloudwatch_agent.json  # CloudWatch agent configuration
│   │   └── README.md             # instructions on how to setup CloudWatch
│   ├── diagnostic_scripts/       # diagnostic scripts for common issues
│   │   ├── check_node_health.sh  # Diagnostic script
│   │   └── check_network.sh      # Diagnostic script
│   └── README.md                 # Instructions on cluster monitoring
├── ml-workloads/                 # Example machine learning workloads
│   ├── tensorflow/               # TensorFlow examples
│   │   ├── mnist.py             # Simple MNIST example
│   │   ├── distributed/         # Distributed training examples
│   │   │   └── train.py         # Training script
│   │   └── README.md            # instructions on how to use TensorFlow
│   ├── pytorch/                  # PyTorch examples
│   │   ├── cifar10.py           # Simple CIFAR-10 example
│   │   └── README.md            # Instructions on how to use PyTorch
│   └── spark_ml/                 # Spark ML examples
│   │   ├── linear_regression.py  # Linear Regression example
│   │   └── README.md             # Instructions on how to use Spark ML
│   └── jupyter_notebooks/        # Jupyter Notebooks
│   │   ├── mnist_example.ipynb   # Example notebook
│   │   └── README.md             # Instructions on how to use Jupyter
│   └── README.md                 # Instructions on example workloads
├── docs/                         # Documentation
│   ├── setup_guide.md           # Setup guide
│   ├── troubleshooting.md       # Troubleshooting playbook
│   ├── performance_benchmarks.md # Performance benchmark results
│   └── customer_support_use_cases.md # Common issues and resolutions
├── README.md                    # Main project README
 ```
