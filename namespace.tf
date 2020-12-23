resource "kubernetes_namespace" "eks_namespaces" {
  metadata {
    annotations = {
      name =  var.namespaces
    }
    name =  var.namespaces
  }
}