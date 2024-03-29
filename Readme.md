# Deploy AWS EKS with open VPN 

## Getting Started

**Clone the Repository:**

  **You can provision a basic EKS cluster with VPC using Terraform with the following commands:**

   terraform init
   terraform plan
   terraform apply

   It might take a while for the cluster to be creates (up to 15-20 minutes).

   1) Setting up IAM policies for the ALB Ingress Controller in EKS with Terraform, You can provision an EKS cluster with the right policies for the ALB Ingress Controller with
   2) Integrating the Helm provider with Terraform and EKS so you can provision an EKS cluster and install Helm packages at the same time. The current code automatically installs the ALB Ingress Controller with Helm.
   As soon as cluster is ready, you should find a kubeconfig_teraki-eks-cluster kubeconfig file in the current directory.

**Once everything is deployed, RUN:** 

KUBECONFIG=./kubeconfig_teraki-eks-cluster kubectl get nodes --all-namespaces
KUBECONFIG=./kubeconfig_teraki-eks-cluster kubectl describe ingress hello-kubernetes -n web-app

If you see any error in ingress it is due to LB is starting right now when terraform is trying to deploy the ingress. Do the follow steps if you dont see the URLon ingress.
1) List the helm charts (KUBECONFIG=./kubeconfig_teraki-eks-cluster helm ls  -n web-app)
2) Delete the Helm chart ( KUBECONFIG=./kubeconfig_teraki-eks-cluster helm delete deployment  -n web-app)
3) Go inside helm chart folder and redeploy the helm chart (KUBECONFIG=../.././kubeconfig_teraki-eks-cluster helm install . --generate-name  -n web-app)
4  Now describe the ingress for URL:  (KUBECONFIG=../.././kubeconfig_teraki-eks-cluster kubectl describe ingress  -n web-app). 

Download the openvpn.ovpn client file which will be present in OpenVPN folder once terraform finishes and load that file to your openvpn client and connect it.

You will see the URL of application(Address:). hit that URL in your browser and you can see your application is running fine. Connect the VPN first before hitting the URL.

