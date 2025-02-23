resource "google_cloud_run_v2_job" "job" {
  name     = var.job_name
  location = var.location
  deletion_protection = var.deletion_protection

  template {
    parallelism = var.parallelism
    task_count  = var.task_count
    labels      = var.labels

    template {
      timeout = var.task_timeout
      service_account = var.task_service_account
      max_retries = var.task_max_retries
      containers {
        image = var.image
        name  = var.container_name        
        resources {
          limits = {
            cpu    = var.container_cpu
            memory = var.container_memory
          }
        }
        dynamic "env" {
          for_each = var.env_vars
          content {
            name  = env.key
            value = env.value
          }
        }
      }
    }
  }
}
