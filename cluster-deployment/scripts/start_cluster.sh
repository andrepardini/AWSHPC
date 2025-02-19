#!/bin/bash

# start_cluster.sh

set -e  # Exit immediately if a command exits with a non-zero status

# --- Configuration ---
CLUSTER_NAME="your-cluster-name" # Replace with your cluster name
REGION="your-aws-region"        # Replace with your AWS region (e.g., us-east-1)
INSTANCE_IDS="instance-id-1 instance-id-2 instance-id-3" # Replace with the instance IDs of your cluster nodes (space-separated)
KUBE_CONFIG_PATH="$HOME/.kube/config" # Path to your kubeconfig file
# --- End Configuration ---

echo "Starting the cluster: $CLUSTER_NAME in region: $REGION"

# 1. Start EC2 Instances
echo "Starting EC2 instances..."
aws ec2 start-instances --instance-ids $INSTANCE_IDS --region $REGION

# Wait for instances to be running
echo "Waiting for instances to be running..."
aws ec2 wait instance-running --instance-ids $INSTANCE_IDS --region $REGION

echo "EC2 instances started."

# 2. Configure kubectl (if necessary)
# This assumes that your kubeconfig is already set up. If not, you might need to add steps to retrieve it from AWS EKS, etc.
# Example for EKS:
# aws eks update-kubeconfig --name $CLUSTER_NAME --region $REGION

# 3. Verify Kubernetes connectivity
echo "Verifying Kubernetes connectivity..."
kubectl get nodes --kubeconfig="$KUBE_CONFIG_PATH"

if [ $? -eq 0 ]; then
  echo "Kubernetes connectivity verified."
else
  echo "Error: Kubernetes connectivity failed. Check your kubeconfig."
  exit 1
fi

# 4. Apply Kubernetes configurations (e.g., deployments, services)
echo "Applying Kubernetes configurations..."

# Replace with the path to your Kubernetes manifest directory
KUBE_MANIFEST_DIR="./kubernetes-manifests"

if [ -d "$KUBE_MANIFEST_DIR" ]; then
  find "$KUBE_MANIFEST_DIR" -name "*.yaml" -o -name "*.yml" | while read manifest; do
    echo "Applying: $manifest"
    kubectl apply -f "$manifest" --kubeconfig="$KUBE_CONFIG_PATH"
  done
else
  echo "Warning: Kubernetes manifest directory not found: $KUBE_MANIFEST_DIR. Skipping application of configurations."
fi

# 5. Start Parallel File System (if applicable)
# Add commands to start your parallel file system (e.g., Lustre, BeeGFS) here.
# This will heavily depend on how your file system is set up.  Example:

# echo "Starting Lustre file system..."
# ssh user@lustre-mds-node "sudo systemctl start lustre-mds"
# ssh user@lustre-oss-node "sudo systemctl start lustre-oss"

echo "Cluster startup complete."