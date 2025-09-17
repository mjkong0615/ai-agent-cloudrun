resource "google_compute_network" "onboard-demo-vpc" {
  project                 = local.project_id
  name                    = var.vpc_name
  routing_mode            = var.routing_mode
  auto_create_subnetworks = var.auto_create_subnetworks
  mtu                     = var.mtu
}

resource "google_compute_subnetwork" "onboard-demo-vpc-subnet1" {
  project       = local.project_id
  name          = local.subnet1_name
  ip_cidr_range = local.ip_cidr_range
  region        = local.subnet1_region
  network       = google_compute_network.onboard-demo-vpc.id
}

# resource "google_compute_subnetwork" "network-with-private-secondary-ip-ranges" {
#   name          = "test-subnetwork"
#   ip_cidr_range = "10.2.0.0/16"
#   region        = "us-central1"
#   network       = google_compute_network.custom-test.id
#   secondary_ip_range {
#     range_name    = "tf-test-secondary-range-update1"
#     ip_cidr_range = "192.168.10.0/24"
#   }
# }
