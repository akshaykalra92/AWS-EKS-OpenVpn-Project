You can provision a basic EKS cluster with VPC using Terraform with the following commands:

terraform init
terraform plan
terraform apply

It might take a while for the cluster to be creates (up to 15-20 minutes).

1) Setting up IAM policies for the ALB Ingress Controller in EKS with Terraform, You can provision an EKS cluster with the right policies for the ALB Ingress Controller with
2) Integrating the Helm provider with Terraform and EKS so you can provision an EKS cluster and install Helm packages at the same time. The current code automatically installs the ALB Ingress Controller with Helm.
As soon as cluster is ready, you should find a kubeconfig_teraki-eks-cluster kubeconfig file in the current directory.

Once everything is deployed, RUN: 
KUBECONFIG=./kubeconfig_teraki-eks-cluster kubectl get nodes --all-namespaces
KUBECONFIG=./kubeconfig_teraki-eks-cluster kubectl describe ingress hello-kubernetes

You will see the URL of application(Address:). hit that URL in your browser and you can see your application is running fine.

