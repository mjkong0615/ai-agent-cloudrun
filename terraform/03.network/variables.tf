variable "REGION" {}

variable "vpc_name" {
    default = "onboard-demo-vpc"
}

variable "routing_mode" {
    default = "REGIONAL"
}

variable "auto_create_subnetworks" {
    default = false
}

variable "mtu" {
    default = 1460
}