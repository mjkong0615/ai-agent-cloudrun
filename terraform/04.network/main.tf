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

resource "google_compute_global_address" "ip_address_lb" {
  project = local.project_id
  name = "ext-ip-lb"
}

module "lb-http" {
  source  = "./serverless_negs"

  name    = var.lb_name
  project = local.project_id

  ssl                             = var.ssl
  managed_ssl_certificate_domains = [var.domain]
  https_redirect                  = false
  labels                          = { "example-label" = "cloud-run-example" }

  backends = {
    default = {
      description = null
      groups = [
        {
          group = google_compute_region_network_endpoint_group.serverless_neg.id
        }
      ]
      enable_cdn = false

      iap_config = {
        enable = false
      }
      log_config = {
        enable = false
      }
    }
  }
}

resource "google_compute_region_network_endpoint_group" "serverless_neg" {
  project               = local.project_id
  name                  = "serverless-neg"
  network_endpoint_type = "SERVERLESS"
  region                = var.REGION
  cloud_run {
    service = data.terraform_remote_state.deploy-app.outputs.zooagent_name
  }
}