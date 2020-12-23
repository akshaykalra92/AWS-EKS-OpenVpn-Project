# render Admin & Developer users list with the structure required by EKS module
locals {
  admin_user_map_users = [
  for admin_user in var.admin_users :
  {
    userarn  = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:user/${admin_user}"
    username = admin_user
    groups   = ["system:masters"]
  }
  ]
  developer_user_map_users = [
  for developer_user in var.developer_users :
  {
    userarn  = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:user/${developer_user}"
    username = developer_user
    groups   = ["${var.name_prefix}-developers"]
  }
  ]
}

# create EKS cluster
module "eks-cluster" {
  source           = "terraform-aws-modules/eks/aws"
  cluster_name     = "${var.cluster_name}"
  cluster_version  = "1.17"
  write_kubeconfig = true
  version = "12.2.0"
  config_output_path = "./"
  workers_additional_policies = [aws_iam_policy.worker_policy.arn]
  subnets = module.vpc.private_subnets
  vpc_id  = module.vpc.vpc_id
  wait_for_cluster_cmd          = "until curl -k -s $ENDPOINT/healthz >/dev/null; do sleep 4; done"  # Remove this line if you are running terraform from linux or mac.
  wait_for_cluster_interpreter = ["C:/Program Files/Git/bin/sh.exe", "-c"]  # Remove this line if you are running terraform from linux or mac.

  node_groups = {
    first = {
      desired_capacity = var.autoscaling_minimum_size_by_az * length(data.aws_availability_zones.available.zone_ids)
      max_capacity = var.autoscaling_maximum_size_by_az * length(data.aws_availability_zones.available.zone_ids)
      min_capacity = var.autoscaling_minimum_size_by_az * length(data.aws_availability_zones.available.zone_ids)

      instance_type = var.asg_instance_types
    }

    second = {
      desired_capacity = var.autoscaling_minimum_size_by_az * length(data.aws_availability_zones.available.zone_ids)
      max_capacity = var.autoscaling_maximum_size_by_az * length(data.aws_availability_zones.available.zone_ids)
      min_capacity = var.autoscaling_minimum_size_by_az * length(data.aws_availability_zones.available.zone_ids)

      instance_type = var.asg_instance_types
    }
  }
  # map developer & admin ARNs as kubernetes Users
  map_users = concat(local.admin_user_map_users, local.developer_user_map_users)
}

# get EKS cluster info to configure Kubernetes and Helm providers
data "aws_eks_cluster" "cluster" {
  name = module.eks-cluster.cluster_id
}
data "aws_eks_cluster_auth" "cluster" {
  name = module.eks-cluster.cluster_id
}

resource "aws_iam_policy" "worker_policy" {
  name        = "worker-policy"
  description = "Worker policy for the ALB Ingress"

  policy = file("iam-policy.json")
}
