resource "helm_release" "app" {
  chart = "charts/deployment"
  name = "deployment"
  version    = "1.0.0"
  namespace = var.namespaces
}