# Spark on Kubernetes Deployment

This directory contains the Kubernetes manifests for deploying a Spark cluster.

## Files

*   `spark-master.yaml`: Kubernetes deployment and service definition for the Spark master node.
*   `spark-worker.yaml`: Kubernetes deployment and service definition for the Spark worker nodes.

## Prerequisites

*   A working Kubernetes cluster.
*   `kubectl` configured to connect to your cluster.

## Deployment Instructions

1.  **Deploy the Spark master:**

    ```bash
    kubectl apply -f spark-master.yaml
    ```

2.  **Deploy the Spark worker nodes:**

    ```bash
    kubectl apply -f spark-worker.yaml
    ```

3.  **Verify the deployment:**

    Check the status of the deployments and services:

    ```bash
    kubectl get deployments
    kubectl get services
    ```

    You should see `spark-master` and `spark-worker` deployments with the desired number of replicas running.  You should also see the `spark-master` and `spark-worker` services.

4.  **Access the Spark Master UI:**

    The Spark master UI is accessible on port 8080. Since the service type is ClusterIP, you'll need to use port forwarding to access it from your local machine or configure an Ingress.

    **Port Forwarding (for testing):**

    ```bash
    kubectl port-forward service/spark-master 8080:8080
    ```

    Then, open your web browser and go to `http://localhost:8080`.

    **Ingress (for production):**

    Create an Ingress resource to expose the Spark master UI externally.  (This is outside the scope of this README, but refer to the Kubernetes Ingress documentation.)

5.  **Submit Spark Applications:**

    You can submit Spark applications to the cluster using `spark-submit`.  You'll need to specify the Spark master URL:

    ```bash
    spark-submit --master spark://spark-master:7077 <your_application.py>
    ```

    Replace `<your_application.py>` with the path to your Spark application.  You might need to build a Docker image with your application and dependencies and deploy that to your cluster.

## Customization

*   **Number of Worker Nodes:**  Adjust the `replicas` value in `spark-worker.yaml` to change the number of worker nodes.
*   **Resource Limits:**  Modify the `resources` section in both `spark-master.yaml` and `spark-worker.yaml` to adjust the CPU and memory limits.
*   **Spark Version:**  Change the image tag in both `spark-master.yaml` and `spark-worker.yaml` to use a different Spark version.  Make sure the versions match.
*   **Persistent Storage:** Uncomment and configure the `volumeMounts` and `volumes` sections in `spark-worker.yaml` if your Spark applications need persistent storage.
*   **Spark Configuration:**  You can pass Spark configuration options through environment variables.  See the Spark documentation for a list of available configuration options.  Add `env` entries to the `containers` section of the YAML files.

## Troubleshooting

*   **Worker Nodes Not Connecting:**  Ensure that the `SPARK_MASTER_URL` environment variable in `spark-worker.yaml` is set correctly to `spark://spark-master:7077`.  Also, verify that the `spark-master` service is running and accessible from the worker nodes.  Check the worker logs for connection errors.
*   **Resource Limits:**  If your Spark applications are running out of memory, increase the memory limits in the `resources` section of the YAML files.
*   **Image Pull Errors:** If you are experiencing image pull errors make sure that you have the correct image tag. Also, check if you need to authenticate with a private registry.