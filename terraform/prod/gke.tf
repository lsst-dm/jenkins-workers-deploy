# google_container_cluster.jenkins_test:
resource "google_container_cluster" "jenkins_test" {
  cluster_ipv4_cidr                        = "10.224.0.0/14"
  datapath_provider                        = "LEGACY_DATAPATH"
  default_max_pods_per_node                = 110
  deletion_protection                      = true
  enable_cilium_clusterwide_network_policy = false
  enable_intranode_visibility              = false
  enable_kubernetes_alpha                  = false
  enable_l4_ilb_subsetting                 = false
  enable_legacy_abac                       = false
  enable_multi_networking                  = false
  enable_shielded_nodes                    = true
  enable_tpu                               = false
  initial_node_count                       = 0
  location                                 = "us-central1-c"
  logging_service                          = "logging.googleapis.com/kubernetes"
  monitoring_service                       = "monitoring.googleapis.com/kubernetes"
  name                                     = "jenkins-test"
  network                                  = "projects/prompt-proto/global/networks/prompt-proto-net"
  networking_mode                          = "VPC_NATIVE"
  node_locations                           = []
  node_version                             = "1.30.9-gke.1201000"
  project                                  = "prompt-proto"
  #resource_labels                          = {}
  subnetwork = "projects/prompt-proto/regions/us-central1/subnetworks/prompt-proto-sub-1"

  addons_config {
    dns_cache_config {
      enabled = false
    }
    gce_persistent_disk_csi_driver_config {
      enabled = true
    }
    horizontal_pod_autoscaling {
      disabled = false
    }
    http_load_balancing {
      disabled = false
    }
    network_policy_config {
      disabled = true
    }
  }

  #    authenticator_groups_config {}


  cluster_autoscaling {
    autoscaling_profile = "BALANCED"
    enabled             = false
  }

  database_encryption {
    state = "DECRYPTED"
  }

  default_snat_status {
    disabled = false
  }

  # ip_allocation_policy {
  #   cluster_ipv4_cidr_block       = "10.224.0.0/14"
  #   cluster_secondary_range_name  = "gke-jenkins-test-pods-ed1f94bc"
  #   services_ipv4_cidr_block      = "10.228.0.0/20"
  #   services_secondary_range_name = "gke-jenkins-test-services-ed1f94bc"
  #   stack_type                    = "IPV4"

  #   pod_cidr_overprovision_config {
  #     disabled = false
  #   }
  # }

  logging_config {
    enable_components = [
      "SYSTEM_COMPONENTS",
      "WORKLOADS",
    ]
  }

  maintenance_policy {
    recurring_window {
      end_time   = "2024-02-12T02:00:00Z"
      recurrence = "FREQ=WEEKLY;BYDAY=SA,SU"
      start_time = "2024-02-11T18:00:00Z"
    }
  }

  master_auth {

    client_certificate_config {
      issue_client_certificate = false
    }
  }

  monitoring_config {
    enable_components = [
      "SYSTEM_COMPONENTS",
    ]
  }

  network_policy {
    enabled  = false
    provider = "PROVIDER_UNSPECIFIED"
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

  node_pool {
    initial_node_count = 6
    #managed_instance_group_urls = [
    #  "https://www.googleapis.com/compute/v1/projects/prompt-proto/zones/us-central1-c/instanceGroups/gke-jenkins-test-jenkins-workers-big-eef38e2b-grp",
    #]
    max_pods_per_node = 110
    name              = "jenkins-workers-big"
    node_count        = 6
    node_locations = [
      "us-central1-c",
    ]
    version = "1.30.9-gke.1201000"

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
      disk_size_gb = 100
      disk_type    = "pd-standard"
      #  effective_taints            = []
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
  node_pool {
    initial_node_count = 6
    #instance_group_urls = [
    #  "https://www.googleapis.com/compute/v1/projects/prompt-proto/zones/us-central1-a/instanceGroupManagers/gke-jenkins-test-jenkins-workers-mult-d7d482d0-grp",
    #]
    #managed_instance_group_urls = [
    #  "https://www.googleapis.com/compute/v1/projects/prompt-proto/zones/us-central1-a/instanceGroups/gke-jenkins-test-jenkins-workers-mult-d7d482d0-grp",
    #]
    max_pods_per_node = 110
    name              = "jenkins-workers-multiarch-c4a"
    node_count        = 6
    node_locations = [
      "us-central1-a",
    ]
    version = "1.30.9-gke.1201000"

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
      disk_size_gb = 100
      disk_type    = "hyperdisk-balanced"
      #  effective_taints = [
      #    {
      #      effect = "NO_SCHEDULE"
      #      key    = "kubernetes.io/arch"
      #      value  = "arm64"
      #    },
      #  ]
      kubelet_config {
        cpu_manager_policy = ""
        pod_pids_limit     = 0
        cpu_cfs_quota      = false
      }
      enable_confidential_storage = false
      image_type                  = "COS_CONTAINERD"
      labels                      = {}
      local_ssd_count             = 0
      logging_variant             = "DEFAULT"
      machine_type                = "c4a-highmem-32"
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

  node_pool_auto_config {
    resource_manager_tags = {}
  }

  node_pool_defaults {
    node_config_defaults {
      logging_variant = "DEFAULT"
    }
  }

  notification_config {
    pubsub {
      enabled = false
    }
  }

  private_cluster_config {
    enable_private_endpoint = false
    enable_private_nodes    = true
    master_ipv4_cidr_block  = "172.16.0.0/28"
    #peering_name            = "gke-n1bc6bb6fdb9c3005cbb-3f9a-057e-peer"
    #private_endpoint        = "172.16.0.2"
    #public_endpoint         = "34.122.218.154"

    master_global_access_config {
      enabled = false
    }
  }

  release_channel {
    channel = "REGULAR"
  }

  security_posture_config {
    mode               = "MODE_UNSPECIFIED"
    vulnerability_mode = "VULNERABILITY_MODE_UNSPECIFIED"
  }

  service_external_ips_config {
    enabled = false
  }

  workload_identity_config {
    workload_pool = "prompt-proto.svc.id.goog"
  }
}
