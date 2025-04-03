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
