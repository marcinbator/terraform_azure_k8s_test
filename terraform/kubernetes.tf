resource "azurerm_kubernetes_cluster" "aks" {
  name                = "demo-aks"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  dns_prefix          = "demoaks"

  default_node_pool {
    name       = "nodepool1"
    node_count = 1
    vm_size    = "Standard_B2s"
  }

  identity {
    type = "SystemAssigned"
  }
}

resource "kubernetes_namespace_v1" "app" {
  metadata {
    name = "demoapp"
  }
}

resource "kubernetes_deployment_v1" "app" {
  metadata {
    name      = "demoapp"
    namespace = kubernetes_namespace_v1.app.metadata[0].name
  }

  spec {
    replicas = 1

    selector {
      match_labels = {
        app = "demoapp"
      }
    }

    template {
      metadata {
        labels = {
          app = "demoapp"
        }
      }
      spec {
        container {
          name  = "server"
          image = "${azurerm_container_registry.acr.login_server}/demoapp:latest"
          port {
            container_port = 8000
          }
        }
      }
    }
  }
}

resource "kubernetes_service_v1" "svc" {
  metadata {
    name      = "demoapp-svc"
    namespace = kubernetes_namespace_v1.app.metadata[0].name
  }

  spec {
    selector = {
      app = "demoapp"
    }

    port {
      port        = 80
      target_port = 8000
    }

    type = "LoadBalancer"
  }
}