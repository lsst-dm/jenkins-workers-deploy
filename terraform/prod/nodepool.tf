# google_container_node_pool.jenkins_workers_big:
resource "google_container_node_pool" "jenkins_workers_big" {
  cluster            = "jenkins-test"
  initial_node_count = 6
  location           = "us-central1-c"
  max_pods_per_node  = 110
  name               = "jenkins-workers-big"
  node_count         = 6
  node_locations = [
    "us-central1-c",
  ]
  project = "prompt-proto"
  version = "1.30.8-gke.1261000"

  management {
    auto_repair  = true
    auto_upgrade = true
  }

  network_config {
    create_pod_range     = false
    enable_private_nodes = true
    pod_ipv4_cidr_block  = "10.224.0.0/14"
    pod_range            = "gke-jenkins-test-pods-ed1f94bc"
  }

  node_config {
    disk_size_gb                = 100
    disk_type                   = "pd-standard"
    enable_confidential_storage = false
    image_type                  = "COS_CONTAINERD"
    labels                      = {}
    local_ssd_count             = 0
    logging_variant             = "DEFAULT"
    machine_type                = "n2-highmem-32"
    metadata = {
      "disable-legacy-endpoints" = "true"
    }
    oauth_scopes = [
      "https://www.googleapis.com/auth/devstorage.read_only",
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring",
      "https://www.googleapis.com/auth/service.management.readonly",
      "https://www.googleapis.com/auth/servicecontrol",
      "https://www.googleapis.com/auth/trace.append",
    ]
    preemptible           = false
    resource_labels       = {}
    resource_manager_tags = {}
    service_account       = "default"
    spot                  = false
    tags                  = []

    shielded_instance_config {
      enable_integrity_monitoring = true
      enable_secure_boot          = true
    }

    workload_metadata_config {
      mode = "GKE_METADATA"
    }
  }

  upgrade_settings {
    max_surge       = 1
    max_unavailable = 0
    strategy        = "SURGE"
  }
}

resource "google_container_node_pool" "jenkins_workers_multiarch" {
  cluster            = "jenkins-test"
  location           = "us-central1-c"
  max_pods_per_node  = 110
  name               = "jenkins-workers-multiarch"
  node_count         = 6
  initial_node_count = 6
  node_locations = [
    "us-central1-a",
  ]
  project = "prompt-proto"
  version = "1.30.8-gke.1261000"

  management {
    auto_repair  = true
    auto_upgrade = true
  }

  network_config {
    create_pod_range     = false
    enable_private_nodes = true
    #pod_ipv4_cidr_block  = "10.224.0.0/14"
    pod_range = "gke-jenkins-test-pods-ed1f94bc"
  }

  node_config {
    disk_size_gb                = 100
    disk_type                   = "pd-standard"
    enable_confidential_storage = false
    image_type                  = "COS_CONTAINERD"
    labels                      = {}
    local_ssd_count             = 0
    logging_variant             = "DEFAULT"
    machine_type                = "t2a-standard-32"
    metadata = {
      "disable-legacy-endpoints" = "true"
    }
    oauth_scopes = [
      "https://www.googleapis.com/auth/devstorage.read_only",
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring",
      "https://www.googleapis.com/auth/service.management.readonly",
      "https://www.googleapis.com/auth/servicecontrol",
      "https://www.googleapis.com/auth/trace.append",
    ]
    preemptible           = false
    resource_labels       = {}
    resource_manager_tags = {}
    service_account       = "default"
    spot                  = false
    tags                  = []

    shielded_instance_config {
      enable_integrity_monitoring = true
      enable_secure_boot          = true
    }

    workload_metadata_config {
      mode = "GKE_METADATA"
    }
  }

  upgrade_settings {
    max_surge       = 1
    max_unavailable = 0
    strategy        = "SURGE"
  }
}
