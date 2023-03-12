resource "google_compute_network" "gke" {
  name = "gke"
  auto_create_subnetworks = false
  delete_default_routes_on_create = false
  mtu = 1460
  routing_mode = "REGIONAL"
}

resource "google_compute_subnetwork" "gke" {
  name          = "gke-subnet"
  ip_cidr_range = var.subnet_cidr
  region        = var.gcp_region
  network       = google_compute_network.gke.id
  private_ip_google_access = true

  secondary_ip_range {
    range_name    = "k8s-pod-range"
    ip_cidr_range = var.pod_cidr
  }
  secondary_ip_range {
    range_name    = "k8s-service-range"
    ip_cidr_range = var.service_cidr
  }
}

resource "google_compute_router" "gke" {
  name    = "gke"
  region  = var.gcp_region
  network = google_compute_network.gke.id
}

resource "google_compute_router_nat" "gke" {
  name   = "nat"
  router = google_compute_router.gke.name
  region = var.gcp_region

  source_subnetwork_ip_ranges_to_nat = "LIST_OF_SUBNETWORKS"
  nat_ip_allocate_option             = "MANUAL_ONLY"

  subnetwork {
    name                    = google_compute_subnetwork.gke.id
    source_ip_ranges_to_nat = ["ALL_IP_RANGES"]
  }

  nat_ips = [google_compute_address.gke.self_link]
}

resource "google_compute_address" "gke" {
  name         = "nat"
  address_type = "EXTERNAL"
  network_tier = "PREMIUM"
  region = var.gcp_region

  depends_on = [google_project_service.compute]
}
