variable "ORG_ID" {}
variable "REGION" {}
variable "BILLING_ACCOUNT" {}
variable "MEMBER" {}

variable "repo_id" {
  default = "onboard-repo"
}

variable "sdp_region" {
  default = "us-central1"
}

variable "sdp_inspect_name" {
  default = "onboard-dlp"
}

variable "sdp_deidentify_name" {
  default = "onboard-dlp-de"
}