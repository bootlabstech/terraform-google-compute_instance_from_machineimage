resource "google_compute_instance_from_machine_image" "mivm" {
  provider = google-beta
  count    = var.no_of_instances
  name     = var.name_of_instances[count.index]
  zone     = var.zone
  project  = var.project

  source_machine_image = var.mi_self_link

  // Override fields from machine image
    allow_stopping_for_update = var.allow_stopping_for_update
   min_cpu_platform              = var.min_cpu_platform
  advanced_machine_features {
  enable_nested_virtualization  = var.enable_nested_virtualization
  threads_per_core              = var.threads_per_core
  }
 metadata = {
  enable-oslogin = var.enable_oslogin
  windows-startup-script-ps1 = var.is_os_linux ? null : templatefile("${path.module}/windows_startup_script.tpl", {})

  # Exclude startup_script key when using the Windows startup script
  startup-script = var.is_os_linux ? templatefile("${path.module}/linux_startup_script.tpl", {}) : null
}
network_interface {
    subnetwork = var.subnetwork
  }
}
resource "google_service_account" "default" {
  count        = var.create_service_account ? 1 : 0
  account_id   = "service-account-id"
  project      = var.project
}

resource "google_compute_address" "static" {
  count        = var.address_type == "INTERNAL" ? (var.address == "" ? 0 : 1) : 1
  name         = "compute-address"
  project      = var.compute_address_project
  region       = var.compute_address_region
  address_type = var.address_type
  subnetwork   = var.subnetwork
  address      = var.address_type == "INTERNAL" ? (var.address == "" ? null : var.address) : null
}
resource "google_compute_resource_policy" "daily" {
  project      = var.project
  name   = "gcp-vm-backup-policy"
  region = "asia-south1"
  snapshot_schedule_policy {

    schedule {
      daily_schedule {
        days_in_cycle = 1
        start_time    = "01:00"
      }
    }
    retention_policy {
      max_retention_days    = 7
      on_source_disk_delete = "KEEP_AUTO_SNAPSHOTS"
    }
    snapshot_properties {
      storage_locations = ["asia"]
      guest_flush       = true
      chain_name = "vm-schedule-chain"
    }
  }
}