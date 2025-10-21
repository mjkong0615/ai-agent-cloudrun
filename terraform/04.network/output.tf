output "vpc_name" {
  description = "VPC Name"
  value       = google_compute_network.onboard-demo-vpc.name
}

output "vpc_id" {
    value = google_compute_network.onboard-demo-vpc.id
}