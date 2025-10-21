terraform {
  backend "gcs" {
    bucket = "onboard-nonprod-remote-state-bucket"
    prefix = "nonprod/edviser/global/network/vpc"
  }
}