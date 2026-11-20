variable "project_id" {
  type    = string
  default = "gcp-devops-lab-514504"
}

variable "region" {
  type    = string
  default = "us-central1"
}

variable "zone" {
  type    = string
  default = "us-central1-a"
}

# image
variable "image-backend" {
  type    = string
  default = "us-docker.pkg.dev/cloudrun/container/hello"
}

variable "artifact_repository_id" {
  type    = string
  default = "repo-basic-app"
}


variable "github_repository" {
  type        = string
  description = "GitHub repository in owner/repository format"
  default     = "yourdopamine04/basic-app-node"
}