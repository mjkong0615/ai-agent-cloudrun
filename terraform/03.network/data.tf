data "terraform_remote_state" "onboard-demo-project" {
  backend = "local"

  config = {
    path = "../01.project/terraform.tfstate"
  }
}