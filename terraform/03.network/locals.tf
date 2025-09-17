locals {
  project_id = data.terraform_remote_state.onboard-demo-project.outputs.project_id
  subnet1_name = "${google_compute_network.onboard-demo-vpc.name}-${var.REGION}-subnet"
  ip_cidr_range = "10.30.0.0/24"
  subnet1_region = var.REGION
}
