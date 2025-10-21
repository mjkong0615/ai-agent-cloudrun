resource "google_folder" "onboard-folder" {
  display_name = var.folder_name
  parent       = "organizations/${var.ORG_ID}"
}

resource "google_project" "onboard-demo" {
  name       = var.project_name
  project_id = var.project_id
  folder_id = google_folder.onboard-folder.id
  billing_account = var.BILLING_ACCOUNT
}

resource "google_folder_organization_policy" "boolean-policy" {
  count = length(local.org_boolean_policies)
  folder = google_folder.onboard-folder.name
  constraint = local.org_boolean_policies[count.index]

  boolean_policy {
    enforced = false
  }
}

resource "google_folder_organization_policy" "list_policy" {
  count = length(local.org_list_policies)
  folder = google_folder.onboard-folder.name
  constraint = local.org_list_policies[count.index]

  list_policy {
    allow {
      all = true
    }
  }
}

resource "google_project_service" "enable-services" {
  count = length(local.project_list_services)
  project = google_project.onboard-demo.id
  service = local.project_list_services[count.index]

  timeouts {
    create = "30m"
    update = "40m"
  }

  disable_on_destroy = false
}

resource "google_project_iam_member" "iam-role" {
  count = length( local.project_iam_roles)
  project = google_project.onboard-demo.id
  role = local.project_iam_roles[count.index]
  member = "user:${var.MEMBER}"
}

resource "google_storage_bucket" "remote-state-bucket" {
  project       = google_project.onboard-demo.project_id
  name          = var.remote-state-bucket-name
  location      = var.remote-state-bucket-location
  force_destroy = var.remote-state-bucket-force_destroy

  uniform_bucket_level_access = var.remote-state-bucket-uniform_bucket_level_access
  public_access_prevention = var.remote-state-bucket-public_access_prevention

}