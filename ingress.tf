resource "helm_release" "ingress" {
  name       = "aws-alb-ingress-controller"
  chart      = "charts/aws-alb-ingress-controller"
  repository = "aws-alb-ingress-controller"
  version    = "1.0.4"
  namespace = var.namespaces

  set {
    name  = "autoDiscoverAwsRegion"
    value = "true"
  }
  set {
    name  = "autoDiscoverAwsVpcID"
    value = "true"
  }
  set {
    name  = "clusterName"
    value = var.cluster_name
  }
}
