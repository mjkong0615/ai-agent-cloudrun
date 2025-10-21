resource "google_service_account" "service_account" {
  project = local.project_id
  account_id   = "onboard-sa"
  display_name = "Onboard Service Account"
}

resource "google_service_account" "onboard-client-sa" {
  project = local.project_id
  account_id   = "onboard-client-sa"
  display_name = "Onboard Client Service Account"
}

resource "google_project_iam_member" "sa-iam" {
  count = length( local.project_iam_roles)
  project = local.project_id
  role = local.project_iam_roles[count.index]
  member = "serviceAccount:${google_service_account.service_account.email}"
}

resource "google_project_iam_member" "client-sa-iam" {
  count = length( local.project_iam_roles)
  project = local.project_id
  role = local.project_iam_roles[count.index]
  member = "serviceAccount:${google_service_account.onboard-client-sa.email}"
}

resource "google_artifact_registry_repository" "onboard-repo" {
  project       = local.project_id
  location      = var.REGION
  repository_id = var.repo_id
  description   = var.repo_id
  format        = "docker"
  cleanup_policy_dry_run = false
}

resource "google_model_armor_template" "onboard-modelarmor-template" {
  project     = local.project_id
  location    = "us-central1"
  template_id = "onboard-modelarmor"

  filter_config {
    rai_settings {
      rai_filters {
        filter_type      = "SEXUALLY_EXPLICIT"
        confidence_level = "HIGH"
      }
      rai_filters {
        filter_type      = "HATE_SPEECH"
        confidence_level = "HIGH"
      }
      rai_filters {
        filter_type      = "HARASSMENT"
        confidence_level = "HIGH"
      }
      rai_filters {
        filter_type      = "DANGEROUS"
        confidence_level = "HIGH"
      }
    }
    sdp_settings {
      advanced_config {
        inspect_template     = local.sdp_inspect_template
        deidentify_template  = local.sdp_deidentify_template
      }
    }
    pi_and_jailbreak_filter_settings {
      filter_enforcement = "ENABLED"
      confidence_level   = "MEDIUM_AND_ABOVE"
    }
    malicious_uri_filter_settings {
      filter_enforcement = "ENABLED"
    }
  }

  template_metadata {
    multi_language_detection {
      enable_multi_language_detection        = true
    }
  }
}