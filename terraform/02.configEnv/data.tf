# data "terraform_remote_state" "onboard-demo-project" {
#   backend = "local"

#   config = {
#     path = "../01.project/terraform.tfstate"
#   }
# }

data "terraform_remote_state" "onboard-demo-project" {
  backend = "gcs"
  config = {
    bucket = "onboard-nonprod-remote-state-bucket"
    prefix = "project"
  }
}