resource "google_project_service" "compute" {
  project = var.gcp_project_id
  service = "compute.googleapis.com"
}

resource "google_project_service" "container" {
  project = var.gcp_project_id
  service = "container.googleapis.com"
}
