data "terraform_remote_state" "network" {
    backend = "gcs"
    config = {
        bucket = "onboard-nonprod-remote-state-bucket"
        prefix = "network"
    }
}

data "terraform_remote_state" "config_env" {
    backend = "gcs"
    config = {
        bucket = "onboard-nonprod-remote-state-bucket"
        prefix = "config"
    }
}

data "terraform_remote_state" "onboard-demo-project" {
    backend = "gcs"
    config = {
        bucket = "onboard-nonprod-remote-state-bucket"
        prefix = "project"
    }
}