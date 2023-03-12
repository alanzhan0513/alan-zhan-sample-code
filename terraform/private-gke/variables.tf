variable "gcp_project_id" {
  default = "alan-zhan-project"
}

variable "gcp_region" {
  default = "asia-east1"
}

variable "subnet_cidr" {
  default = "10.0.0.0/24"
}

variable "pod_cidr" {
  default = "10.0.8.0/21"
}

variable "service_cidr" {
  default = "10.0.1.0/24"
}

variable "master_cidr" {
  default = "10.0.2.0/28"
}
