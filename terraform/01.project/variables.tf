variable "ORG_ID" {}
variable "REGION" {}
variable "BILLING_ACCOUNT" {}
variable "MEMBER" {}

variable "project_name" {
  default = "onboard-demo1"
}

variable "project_id" {
  default = "onboard-demo1"
}

variable "folder_name" {
  default = "onboard"
}

variable "remote-state-bucket-name" {
  default = "onboard-nonprod-remote-state-bucket"
}

variable "remote-state-bucket-location" {
  default = "asia-northeast3"
}

variable "remote-state-bucket-force_destroy" {
  default = true
}

variable "remote-state-bucket-uniform_bucket_level_access" {
  default = true
}

variable "remote-state-bucket-public_access_prevention" {
  default = "enforced"
}