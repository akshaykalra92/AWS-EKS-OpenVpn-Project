#VPC
variable "cluster_name" {
  type        = string
  description = "EKS cluster name."
}
variable "iac_environment_tag" {
  type        = string
  description = "AWS tag to indicate environment name of each infrastructure object."
}
variable "name_prefix" {
  type        = string
  description = "Prefix to be used on each infrastructure object Name created in AWS."
}
variable "main_network_block" {
  type        = string
  description = "Base CIDR block to be used in our VPC."
}
variable "subnet_prefix_extension" {
  type        = number
  description = "CIDR block bits extension to calculate CIDR blocks of each subnetwork."
}
variable "zone_offset" {
  type        = number
  description = "CIDR block bits extension offset to calculate Public subnets, avoiding collisions with Private subnets."
}

#EKS

variable "admin_users" {
  type        = list(string)
  description = "List of Kubernetes admins."
}
variable "developer_users" {
  type        = list(string)
  description = "List of Kubernetes developers."
}
variable "asg_instance_types" {
  type        = string
  description = "EC2 instance machine types to be used in EKS."
}
variable "instance_type" {
  type        = string
  description = "EC2 instance machine types to be used in EKS."
}
variable "autoscaling_minimum_size_by_az" {
  type        = number
  description = "Minimum number of EC2 instances to autoscale our EKS cluster on each AZ."
}
variable "autoscaling_maximum_size_by_az" {
  type        = number
  description = "Maximum number of EC2 instances to autoscale our EKS cluster on each AZ."
}
variable "autoscaling_average_cpu" {
  type        = number
  description = "Average CPU threshold to autoscale EKS EC2 instances."
}
variable "namespaces" {
  type        = string
  description = "namespaces to be created in our EKS Cluster."
}

variable "ansible_user" {
  type        = string
  default = "ubuntu"
}

variable "name" {
  description = "Unique name for the key, should also be a valid filename. This will prefix the public/private key."
  default     = "vpn"
  type        = string
}

variable "path" {
  description = "Path to a directory where the public and private key will be stored."
  default     = "."
  type        = string
}

variable "instance_type_ec2" {
  description = "Instance type of ec2."
  default     = "t2.small"
  type        = string
}

variable "vpc_name" {
  description = "vpc name"
  default     = ""
  type        = string
}

variable "cidr" {
  description = "VPC cidr"
  default     = ""
  type        = string
}

#variable "dns_base_domain" {
#  type        = string
#  description = "DNS Zone name to be used from EKS Ingress."
#}
#variable "ingress_gateway_chart_name" {
#  type        = string
#  description = "Ingress Gateway Helm chart name."
#}
#variable "ingress_gateway_chart_repo" {
#  type        = string
#  description = "Ingress Gateway Helm repository name."
#}
#variable "ingress_gateway_chart_version" {
#  type        = string
#  description = "Ingress Gateway Helm chart version."
#}
#variable "ingress_gateway_annotations" {
#  type        = map(string)
#  description = "Ingress Gateway Annotations required for EKS."
#}
#variable "deployments_subdomains" {
#  type        = list(string)
#  description = "List of subdomains to be routed to Kubernetes Services."
#}

