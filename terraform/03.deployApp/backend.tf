terraform {
  backend "gcs" {
    bucket = "onboard-nonprod-remote-state-bucket"
    prefix = "deploy-app"
  }
}