variable "node_count" {
  default = 3
}

variable "dns_prefix" {
  default = "aks-k8s-2024"
}

variable "cluster_name" {
  default = "aks-k8s-2024"
}

variable "kubernetes_version" {
  default = "1.27.7"
}

variable "acr_name" {
  default = "acrforaks2024"
}

variable "sql_name" {
  default = "mssql-2024"
}

variable "db_name" {
  default = "ProductsDB"
}

variable "db_admin_login" {
  default = "sadmin"
}

variable "db_admin_password" {
  default = "@Aa123456"
}

variable "storage_name" {
  default = "mssqlstorageaccount2024"
}

variable "resource_group_name" {
  default = "aks-k8s-2024"
}

variable "location" {
  default = "eastus"
}
