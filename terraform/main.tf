
# ==== artifact registry ====
resource "google_artifact_registry_repository" "repo_basic-app" {
  location      = var.region
  repository_id = var.artifact_repository_id
  description   = "Docker images for basic-app"
  format        = "DOCKER"

  # agar ketika policy dijalakan akan terhapus
  cleanup_policy_dry_run = false

  cleanup_policies {
    id     = "keep-recent-images"
    action = "KEEP"
    condition {
      tag_state             = "TAGGED"
      package_name_prefixes = ["backend", ]
    }
  }

  cleanup_policies {
    id     = "delete-old-untagged"
    action = "DELETE"
    condition {
      tag_state  = "UNTAGGED"
      older_than = "300s"
    }
  }
}


# ==== cloud run ====

resource "google_cloud_run_v2_service" "backend" {
  name                = "backend-instance"
  location            = var.region
  deletion_protection = false

  template {
    scaling {
      min_instance_count = 0
      max_instance_count = 2
    }

    containers {
      image = var.image-backend
      ports {
        container_port = 3000
      }
    }
  }

  lifecycle {
    ignore_changes = [
      template[0].containers[0].image,
    ]
  }
}

resource "google_cloud_run_v2_service_iam_member" "backend_public" {
  name     = google_cloud_run_v2_service.backend.name
  location = google_cloud_run_v2_service.backend.location
  role     = "roles/run.invoker"
  member   = "allUsers"
}

