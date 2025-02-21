# Storage on Kubernetes (Ceph and BeeGFS)

This directory contains Kubernetes manifests for deploying Ceph and BeeGFS storage solutions.

## Ceph

Ceph is a distributed storage system that provides object, block, and file storage.  These manifests deploy Ceph on Kubernetes using the Rook Ceph Operator.

### Files

*   `ceph-operator.yaml`: Kubernetes deployment for the Rook Ceph Operator.
*   `ceph-cluster.yaml`: Kubernetes definition for the Ceph cluster.

### Prerequisites

*   A working Kubernetes cluster.
*   `kubectl` configured to connect to your cluster.
*   Creation of namespace, service accounts, and RBAC rules as outlined in the Rook documentation.

### Deployment Instructions

1.  **Create the Rook Ceph namespace:**

    ```bash
    kubectl create namespace rook-ceph
    ```

2. **If not already done create Service Accounts and RBAC rules:**

    Follow Rook Documentation

3.  **Deploy the Rook Ceph Operator:**

    ```bash
    kubectl apply -f ceph-operator.yaml
    ```

4.  **Deploy the Ceph cluster:**

    ```bash
    kubectl apply -f ceph-cluster.yaml
    ```

5.  **Verify the deployment:**

    Check the status of the Ceph cluster using `kubectl` and the `ceph` command-line tool (you may need to install the `ceph` command-line tool in a pod within your cluster):

    ```bash
    kubectl -n rook-ceph get pods
    kubectl -n rook-ceph get cephcluster
    ```
    The `kubectl` command should show all Ceph pods running.  The `ceph` command can be used to check the health of the Ceph cluster.

### Customization

*   **Ceph Version:**  Change the `image` field in `ceph-operator.yaml` and `cephVersion.image` in `ceph-cluster.yaml` to use a different Ceph version.
*   **Resource Limits:** Modify the `resources` section in `ceph-operator.yaml` and the Ceph OSD/MON deployments to adjust CPU and memory limits.
*   **Storage Devices:**  In `ceph-cluster.yaml`, use the `storage.nodes` section to specify the nodes and devices that will be used for Ceph OSDs. Be extremely cautious when specifying devices, as data loss can occur if you choose the wrong devices.
*   **Networking:**  Set `network.hostNetwork` to `true` in `ceph-cluster.yaml` for better performance.  However, this might require careful network planning.
*   **Number of monitors:** Use the `mon.count` variable to adjust the number of mons.

### Troubleshooting

*   Consult the Rook Ceph documentation for detailed troubleshooting information: [https://rook.io/docs/ceph/latest/](https://rook.io/docs/ceph/latest/)

## BeeGFS

BeeGFS is a parallel file system designed for high-performance computing.

### Files

*   `beegfs-client.yaml`: Kubernetes DaemonSet for the BeeGFS client.
*   `beegfs-meta.yaml`: Kubernetes Deployment for the BeeGFS metadata servers.

### Prerequisites

*   A working Kubernetes cluster.
*   `kubectl` configured to connect to your cluster.
*   BeeGFS metadata and storage servers already set up and running outside of Kubernetes, or using a separate set of Kubernetes manifests.
*   BeeGFS client packages and kernel modules installed on the Kubernetes nodes.

### Deployment Instructions

1.  **Create the BeeGFS ConfigMaps:**

    ```bash
    kubectl create configmap beegfs-client-config --from-file=beegfs-client.conf=/path/to/your/beegfs-client.conf
    kubectl create configmap beegfs-storage-config --from-file=beegfs-storage.conf=/path/to/your/beegfs-storage.conf
    ```

2.  **Create the PersistentVolume (PV) and PersistentVolumeClaim (PVC) `beegfs-meta-pvc`.**
3.  **Apply the BeeGFS manifests:**

    ```bash
    kubectl apply -f beegfs/beegfs-meta.yaml
    kubectl apply -f beegfs/beegfs-client.yaml
    ```

4.  **Verify the deployment:**

    Check the status of the BeeGFS client and metadata servers using `kubectl`:

    ```bash
    kubectl get daemonsets
    kubectl get statefulsets
    ```

### Customization

*   Refer to the comments and instructions within `beegfs-client.yaml` and `beegfs-meta.yaml` for customization options.

### Troubleshooting

*   Consult the BeeGFS documentation for detailed troubleshooting information.

## General Storage Considerations

*   **Persistent Volumes:** Use PersistentVolumes and PersistentVolumeClaims to provide persistent storage for your applications.
*   **Storage Classes:** Define StorageClasses to dynamically provision storage based on your requirements.
*   **Monitoring:** Monitor the performance and health of your storage systems using Prometheus, Grafana, and other monitoring tools.