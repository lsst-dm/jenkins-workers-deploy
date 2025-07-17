#resource backendbucket
resource "google_compute_backend_bucket" "eups_stack_tarball" {
  name                    = "eups-stack-tarball"
  bucket_name             = "eups-gc-storage-dev"
  compression_mode        = null
  custom_response_headers = []
  description             = null
  edge_security_policy    = null
  enable_cdn              = false
}
#resource storage bucket eups
resource "google_storage_bucket" "eups" {
  name                        = "eups"
  location                    = "US"
  default_event_based_hold    = false
  enable_object_retention     = false
  force_destroy               = false
  labels                      = {}
  project                     = "prompt-proto"
  public_access_prevention    = "inherited"
  requester_pays              = false
  rpo                         = "DEFAULT"
  storage_class               = "STANDARD"
  uniform_bucket_level_access = true

  hierarchical_namespace {
    enabled = false
  }

  soft_delete_policy {
    retention_duration_seconds = 604800
  }
   lifecycle_rule {
           action {
               type          = "Delete" 
                # (1 unchanged attribute hidden)
            }
           condition {
               age                                     = 0 
               days_since_custom_time                  = 0 
               days_since_noncurrent_time              = 0 
               matches_prefix                          = [] 
               matches_storage_class                   = [] 
               matches_suffix                          = [] 
               num_newer_versions                      = 2 
               send_age_if_zero                        = false 
               send_days_since_custom_time_if_zero     = false 
               send_days_since_noncurrent_time_if_zero = false 
               send_num_newer_versions_if_zero         = false 
               with_state                              = "ARCHIVED" 
                # (3 unchanged attributes hidden)
            }
        }
       lifecycle_rule {
           action {
               type          = "Delete" 
                # (1 unchanged attribute hidden)
            }
           condition {
               age                                     = 0 
               days_since_custom_time                  = 0 
               days_since_noncurrent_time              = 30 
               matches_prefix                          = [] 
               matches_storage_class                   = [] 
               matches_suffix                          = [] 
               num_newer_versions                      = 0 
               send_age_if_zero                        = false 
               send_days_since_custom_time_if_zero     = false 
               send_days_since_noncurrent_time_if_zero = false 
               send_num_newer_versions_if_zero         = false 
               with_state                              = "ANY" 
            }
        }
      lifecycle_rule {
          action {
              storage_class = "ARCHIVE" 
              type          = "SetStorageClass" 
            }
          condition {
              age                                     = 10 
              days_since_custom_time                  = 0 
              days_since_noncurrent_time              = 0 
              matches_prefix                          = [] 
              matches_storage_class                   = [] 
              matches_suffix                          = [] 
              num_newer_versions                      = 0 
              send_age_if_zero                        = false 
              send_days_since_custom_time_if_zero     = false 
              send_days_since_noncurrent_time_if_zero = false 
              send_num_newer_versions_if_zero         = false 
              with_state                              = "ANY" 
            }
        }
}
#resource storage bucket eups-prod
resource "google_storage_bucket" "eups_prod" {
  name                        = "eups-prod"
  location                    = "US"
  default_event_based_hold    = false
  enable_object_retention     = false
  force_destroy               = false
  labels                      = {}
  project                     = "prompt-proto"
  public_access_prevention    = "inherited"
  requester_pays              = false
  rpo                         = "DEFAULT"
  storage_class               = "STANDARD"
  uniform_bucket_level_access = true

  hierarchical_namespace {
    enabled = true
  }

  soft_delete_policy {
    retention_duration_seconds = 2678400
  }
}
#resource storage bucket eups-backup
resource "google_storage_bucket" "eups_backup" {
  name                        = "eups-backup"
  location                    = "US"
  default_event_based_hold    = false
  enable_object_retention     = false
  force_destroy               = false
  labels                      = {}
  project                     = "prompt-proto"
  requester_pays              = false
  rpo                         = "DEFAULT"
  uniform_bucket_level_access = true

  hierarchical_namespace {
    enabled = false
  }
  public_access_prevention    = "enforced"
  storage_class               = "ARCHIVE"

      lifecycle_rule {
          action {
              type          = "Delete"
            }
          condition {
               age                                     = 0 
               days_since_custom_time                  = 0 
               days_since_noncurrent_time              = 0 
               matches_prefix                          = [] 
               matches_storage_class                   = [] 
               matches_suffix                          = [] 
               num_newer_versions                      = 3 
               send_age_if_zero                        = false 
               send_days_since_custom_time_if_zero     = false 
               send_days_since_noncurrent_time_if_zero = false 
               send_num_newer_versions_if_zero         = false 
               with_state                              = "ARCHIVED"
            }
        }
      lifecycle_rule {
          action {
              type          = "Delete"
            }
          condition {
              age                                     = 0 
              days_since_custom_time                  = 0 
              days_since_noncurrent_time              = 90 
              matches_prefix                          = [] 
              matches_storage_class                   = [] 
              matches_suffix                          = [] 
              num_newer_versions                      = 0 
              send_age_if_zero                        = false 
              send_days_since_custom_time_if_zero     = false 
              send_days_since_noncurrent_time_if_zero = false 
              send_num_newer_versions_if_zero         = false 
              with_state                              = "ANY" 
            }
        }

      soft_delete_policy {
          retention_duration_seconds = 5184000
        }

}

#resource storage bucket eups-gc-storage-dev
resource "google_storage_bucket" "eups_gc_storage_dev" {
  name                        = "eups-gc-storage-dev"
  location                    = "US"
  default_event_based_hold    = false
  enable_object_retention     = false
  force_destroy               = false
  labels                      = {}
  project                     = "prompt-proto"
  public_access_prevention    = "inherited"
  requester_pays              = false
  rpo                         = "DEFAULT"
  storage_class               = "STANDARD"
  uniform_bucket_level_access = true

  hierarchical_namespace {
    enabled = false
  }

  soft_delete_policy {
    retention_duration_seconds = 604800
  }

  website {
    main_page_suffix = "index.html"
    not_found_page   = "404-page.html"
  }
}

#resource compute disk rubin-pipelines
resource "google_compute_disk" "rubin_pipelines" {
  name                        = "rubin-pipelines"
  access_mode                 = null
  description                 = "A detachable disk with room for installing the LSST Science Pipelines."
  enable_confidential_compute = false
  image                       = null
  labels                      = {}
  licenses                    = []
  physical_block_size_bytes   = 4096
  project                     = "prompt-proto"
  provisioned_iops            = 0
  provisioned_throughput      = 0
  size                        = 15
  snapshot                    = null
  source_disk                 = null
  source_disk_id              = null
  source_image_id             = null
  source_snapshot_id          = null
  storage_pool                = null
  type                        = "pd-balanced"
  zone                        = "us-central1-a"
}

#resource compute snapshot pipelines-disk-w-2022-10
resource "google_compute_snapshot" "pipelines_disk_w_2022_10" {
  name        = "pipelines-disk-w-2022-10"
  source_disk = google_compute_disk.rubin_pipelines.id
  description = "A small disk with a fresh install of weekly w_2022_10 of the Science Pipelines."
  labels      = {}
  project     = "prompt-proto"
  storage_locations = [
    "us-central1",
  ]
}
resource "google_compute_global_address" "eups_bucket" {
  address      = "34.160.10.3"
  address_type = "EXTERNAL"
  name         = "eups-bucket-address"
  project      = "prompt-proto"
}

resource "google_storage_transfer_job" "eups_backup_job"{
  description = " Backup eups prod bucket"
  transfer_spec {
          transfer_options {
              delete_objects_from_source_after_transfer  = false 
              delete_objects_unique_in_sink              = false 
              overwrite_objects_already_existing_in_sink = false 
              overwrite_when                             = "DIFFERENT" 
            }
    gcs_data_source {
      bucket_name = google_storage_bucket.eups_prod.name

    }
    gcs_data_sink {
      bucket_name = google_storage_bucket.eups_backup.name
    }
}
    schedule {
          repeat_interval = "86400s"

          schedule_start_date {
              day   = 18
              month = 7
              year  = 2025
            }

          start_time_of_day {
              hours   = 16 
              minutes = 0 
              nanos   = 0 
              seconds = 0 
            }
        }


}
