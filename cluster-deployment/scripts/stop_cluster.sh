#!/bin/bash

# stop_cluster.sh

set -e

# --- Configuration ---
CLUSTER_NAME="your-cluster-name" # Replace with your cluster name
REGION="your-aws-region"        # Replace with your AWS region (e.g., us-east-1)
INSTANCE_IDS="instance-id-1 instance-id-2 instance-id-3" # Replace with the instance IDs of your cluster nodes (space-separated)
KUBE_CONFIG_PATH="$HOME/.kube/config" # Path to your kubeconfig file
# --- End Configuration ---

echo "Stopping the cluster: $CLUSTER_NAME in region: $REGION"

# 1. Stop Kubernetes Deployments/Services (Optional, but recommended for a clean shutdown)
echo "Scaling down Kubernetes deployments..."

# Example:  Scale all deployments to 0 replicas.  Adapt this to your specific needs.
kubectl get deployments --all-namespaces -o name --kubeconfig="$KUBE_CONFIG_PATH" | while read deployment; do
  kubectl scale --replicas=0 "$deployment" --kubeconfig="$KUBE_CONFIG_PATH" --namespace=$(echo $deployment | awk -F'/' '{print $1}')
done

# 2. Stop EC2 Instances
echo "Stopping EC2 instances..."
aws ec2 stop-instances --instance-ids $INSTANCE_IDS --region $REGION

# Wait for instances to be stopped
echo "Waiting for instances to be stopped..."
aws ec2 wait instance-stopped --instance-ids $INSTANCE_IDS --region $REGION

echo "EC2 instances stopped."

# 3. Stop Parallel File System (if applicable)
# Add commands to stop your parallel file system (e.g., Lustre, BeeGFS) here.
# Example:
# echo "Stopping Lustre file system..."
# ssh user@lustre-mds-node "sudo systemctl stop lustre-mds"
# ssh user@lustre-oss-node "sudo systemctl stop lustre-oss"

echo "Cluster shutdown complete."