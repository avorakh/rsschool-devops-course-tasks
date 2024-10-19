# rsschool-devops-course-tasks

## Table of Contents

- [Prerequisites](#prerequisites)
- [Installation](#installation)
- [Usage](#usage)

## Prerequisites

Before you begin, ensure you have met the following requirements:
- **AWS Account**
  - You should have an account with the AWS cloud provider that you plan to use for deploying the infrastructure. a new user with the following policies attached:
    - AmazonEC2FullAccess
    - AmazonRoute53FullAccess
    - AmazonS3FullAccess
    - IAMFullAccess
    - AmazonVPCFullAccess
    - AmazonSQSFullAccess
    - AmazonEventBridgeFullAccess
    - Access Key ID and Secret Access Key for the user.
  - The user should have Access Key ID and Secret Access Key
  - S3 bucket for Terraform states 
    - Set necessary bucket permissions
    - Enable bucket versioning
    - Enable encryption
    - Useful link:
      - [Managing Terraform states Best Practices](https://spacelift.io/blog/terraform-s3-backend)
  - GitHub OIDC identity provider
    - [Github tutorial](https://docs.github.com/en/actions/security-for-github-actions/security-hardening-your-deployments/configuring-openid-connect-in-amazon-web-services)
    - [AWS documentation on OIDC providers](https://docs.aws.amazon.com/IAM/latest/UserGuide/id_roles_create_for-idp_oidc.html#idp_oidc_Create_GitHub)
- **AWS CLI 2** (https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html)
- **Terraform 1.9+** (https://developer.hashicorp.com/terraform/install?product_intent=terraform)

## Installation

To set up the Terreform project, follow these steps:

0. **Create A Bastion host keypair**: Generate the keypair with the command below:
   ```bash
   ssh-keygen -t rsa -b 4096 -f ~/.ssh/bastion_key
   ```

1. **Clone the Repository**: Clone the project repository to your local machine using the following command:

   ```bash
   git clone https://github.com/avorakh/rsschool-devops-course-tasks.git
   ```

2. **Navigate to the Project Directory**: Change your working directory to the project folder:

   ```bash
   cd rsschool-devops-course-tasks
   ```

3. **Initialize Terraform**: Initialize the Terraform working directory. This step downloads the necessary provider plugins:

   ```bash
   # backend.conf file
   bucket  = "<PUT-S3-BUCKET-NAME-FOR-TERRAFORM-STATES>"
   region  = "<PUT-AWS-REGION>"
   key     = "state/terraform.tfstate"
   encrypt = true
   ```

   ```bash
   terraform init -backend-config=./path/to/backend.conf
   ```
   
## Usage

To use the Terreform project, follow these steps:

1. **Plan the Infrastructure**: Generate and review an execution plan for the infrastructure:

   ```bash
   terraform plan
   ```

   This command will show you what actions Terraform will take to change your infrastructure.

2. **Apply the Infrastructure**: Apply the changes required to reach the desired state of the configuration:

   ```bash
   terraform apply
   ```

   Confirm the action when prompted. Terraform will provision the resources as defined in the configuration files.

3. **Destroy the Infrastructure**: If you need to remove the infrastructure, use the following command:

   ```bash
   terraform destroy
   ```

   Confirm the action when prompted. This will delete all the resources managed by Terraform.


# Bastion host usage

1. **Verify connection to the bastion**:

   ```bash
   ssh -i ~/.ssh/bastion_key ubuntu@<PUT_PUBLIC_IP_OR_HOST_OF BASTION_INSTANCE>
   ```

2. **Copy the key from the machine to the bastion to have access to private instances**:

   ```bash
   scp -i  ~/.ssh/bastion_key  ~/.ssh/bastion_key ubuntu@<PUT_PUBLIC_IP_OR_HOST_OF BASTION_INSTANCE>:/home/ubuntu/.ssh
   ```

3. **Connect from the bastion host to a private EC2 instance**:
   ```bash
   ssh -i ~/.ssh/bastion_key ubuntu@<PUT_PRIVATE_IP>
   ```


## Architecture

<details>
  <summary>Deployment Diagram</summary>
  <img src="images/Deployment_Diagram.png" />

</details>


# K8S cluster with [k3s](https://k3s.io/)

## 1. Verify the Master Node (Control plan)

1. **Connect from the bastion host to the Control plan EC2 instance**:
   ```bash
   ssh -i ~/.ssh/bastion_key ubuntu@<PRIVATE_IP>
   ```
2. **Check status of k3s on master node**
    ```bash
    systemctl status k3s
    ```
3. **Get the node token (needed to join worker nodes):**
    ```bash
    sudo cat /var/lib/rancher/k3s/server/node-token
    ```
   
## 2. Prepare Worker Node

1. **Connect from the bastion host to the Worker Node EC2 instance**:
   ```bash
   ssh -i ~/.ssh/bastion_key ubuntu@<PRIVATE_IP>
   ```
2. **Check status of Docker on Worker Node**
    ```bash
    systemctl status docker
    ```
3. **Join Worker Nodes to the Cluster (Master Node)**
    ```bash
   curl -sfL https://get.k3s.io | K3S_URL=https://<MasterNodeIP>:6443 K3S_TOKEN=<NodeToken> sh -
    ```
   
## 3. Check the nodes list from master node
1. **Connect from the bastion host to the Control plan EC2 instance**:
   ```bash
   ssh -i ~/.ssh/bastion_key ubuntu@<PRIVATE_IP>
   ```
   
2. Execute command to get the nodes list
    ```bash
    sudo kubectl get nodes
    ```
    Please see the expected output:
    ```bash
    ubuntu@ip-10-0-3-95:~$ sudo kubectl get node
    NAME            STATUS   ROLES                  AGE    VERSION
    ip-10-0-3-95    Ready    control-plane,master   159m   v1.30.5+k3s1
    ip-10-0-4-228   Ready    <none>                 138m   v1.30.5+k3s1
    ```
   
## 4. Setup remote access to the K8S cluster on bastion host

1. Install and Set Up [kubectl](https://kubernetes.io/docs/tasks/tools/install-kubectl-linux/)
2. Copy the Kubeconfig File from the Master Node EC2 Instance
    
    >The Kubernetes configuration file (`kubeconfig`) is typically located at `/etc/rancher/k3s/k3s.yaml` for K3s. 
    Copy this file to bastion host at `~/.kube/config`.

3. Open the `~/.kube/config` file and change the server address from `127.0.0.1` to the remote cluster IP-Address.
    ```yaml
    apiVersion: v1
    clusters:
    - cluster:
      certificate-authority-data: <secret>
      server: https:///<server-ip-of-master-node>:6443
      name: default
    #...
    ```
4. Verify that the pod is running:

    ```bash
    kubectl get pods
    ```

## Deploy a Simple Workload
1. Deploy a Simple Workload

   ```bash
   kubectl apply -f https://k8s.io/examples/pods/simple-pod.yaml
   ```

2. Verify that the pod is running:

   ```bash
   kubectl get pods
   ```

3. Apply the deployment:
   ```bash
   kubectl apply -f deployment.yaml
   ```
    ```yaml
    # deployment.yaml
    apiVersion: apps/v1
    kind: Deployment
    metadata:
      name: nginx-app
    spec:
      replicas: 1
      selector:
        matchLabels:
          app: nginx-app
      template:
        metadata:
          labels:
            app: nginx-app
        spec:
          containers:
            - name: nginx-app
              image: nginx
              ports:
                - containerPort: 80
    
    ```

4. Verify the deployment:

   ```bash
   kubectl get deployments
   ```

5. Apply the service:

    ```bash
    kubectl apply -f service.yaml
    ```
    ```yaml
    # service.yaml
    apiVersion: v1
    kind: Service
    metadata:
      name: nginx-app-service
    spec:
      type: NodePort
      selector:
        app: nginx-app
      ports:
        - protocol: TCP
          port: 80
          targetPort: 80
          nodePort: 30009
    
    ```
6. Verify the service:

   ```bash
   kubectl get services
   ```
