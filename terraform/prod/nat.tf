resource "google_compute_network" "net" {
  name                                      = "prompt-proto-net"
  auto_create_subnetworks                   = false
  bgp_always_compare_med                    = false
  bgp_best_path_selection_mode              = "LEGACY"
  bgp_inter_region_cost                     = null
  delete_default_routes_on_create           = false
  description                               = null
  enable_ula_internal_ipv6                  = false
  gateway_ipv4                              = null
  internal_ipv6_range                       = null
  mtu                                       = 1460
  network_firewall_policy_enforcement_order = "AFTER_CLASSIC_FIREWALL"
  project                                   = "prompt-proto"
  routing_mode                              = "REGIONAL"
}
resource "google_compute_subnetwork" "subnet" {
  name                       = "prompt-proto-sub-1"
  description                = null
  external_ipv6_prefix       = null
  internal_ipv6_prefix       = null
  ip_cidr_range              = "10.0.0.0/9"
  ipv6_access_type           = null
  ipv6_cidr_range            = null
  network                    = google_compute_network.net.id
  private_ip_google_access   = true
  private_ipv6_google_access = "DISABLE_GOOGLE_ACCESS"
  project                    = "prompt-proto"
  purpose                    = "PRIVATE"
  region                     = "us-central1"
  reserved_internal_range    = null
  role                       = null
  stack_type                 = "IPV4_ONLY"

  secondary_ip_range {
    ip_cidr_range           = "10.228.0.0/20"
    range_name              = "gke-jenkins-test-services-ed1f94bc"
    reserved_internal_range = null
  }
  secondary_ip_range {
    ip_cidr_range           = "10.224.0.0/14"
    range_name              = "gke-jenkins-test-pods-ed1f94bc"
    reserved_internal_range = null
  }
}

resource "google_compute_router" "router" {
  name = "prompt-router"
  #  region  = google_compute_subnetwork.subnet.region
  network                       = google_compute_network.net.id
  description                   = null
  encrypted_interconnect_router = false
  project                       = "prompt-proto"
  region                        = "us-central1"
}

resource "google_compute_router_nat" "nat" {
  name                                = "prompt-external"
  router                              = google_compute_router.router.name
  region                              = google_compute_router.router.region
  source_subnetwork_ip_ranges_to_nat  = "ALL_SUBNETWORKS_ALL_IP_RANGES"
  auto_network_tier                   = null
  drain_nat_ips                       = []
  enable_dynamic_port_allocation      = false
  enable_endpoint_independent_mapping = false
  endpoint_types = [
    "ENDPOINT_TYPE_VM",
  ]
  icmp_idle_timeout_sec  = 30
  max_ports_per_vm       = 0
  min_ports_per_vm       = 64
  nat_ip_allocate_option = "MANUAL_ONLY"
  nat_ips = [
    "https://www.googleapis.com/compute/v1/projects/prompt-proto/regions/us-central1/addresses/nat-exit-1",
  ]
  project                          = "prompt-proto"
  tcp_established_idle_timeout_sec = 1200
  tcp_time_wait_timeout_sec        = 120
  tcp_transitory_idle_timeout_sec  = 30
  udp_idle_timeout_sec             = 30

  log_config {
    enable = false
    filter = "ALL"
  }
}

resource "google_compute_address" "address" {
  name          = "nat-exit-1"
  address       = "35.222.133.45"
  address_type  = "EXTERNAL"
  labels        = {}
  network_tier  = "PREMIUM"
  prefix_length = 0
  project       = "prompt-proto"
  purpose       = null
  region        = "us-central1"
  subnetwork    = null
}

resource "google_compute_router_nat_address" "nat_address" {
  nat_ips    = google_compute_address.address.*.self_link
  router     = google_compute_router.router.name
  router_nat = google_compute_router_nat.nat.name
  region     = google_compute_router_nat.nat.region
}
#resource targetHttpProxies

#resource forwardingrule
resource "google_compute_global_forwarding_rule" "eups_lsst_codes_forwarding_rule" {
  name                  = "eups-lsst-codes-forwarding-rule"
  base_forwarding_rule  = null
  description           = null
  ip_address            = "34.160.10.3"
  ip_protocol           = "TCP"
  ip_version            = "IPV4"
  labels                = {}
  load_balancing_scheme = "EXTERNAL_MANAGED"
  network               = null
  network_tier          = "PREMIUM"
  port_range            = "80-80"
  project               = "prompt-proto"
  psc_connection_id     = null
  psc_connection_status = null
  source_ip_ranges      = []
  subnetwork            = null
  target                = google_compute_target_http_proxy.eups_target_proxy.id
}

resource "google_compute_target_http_proxy" "eups_target_proxy" {
  name       = "eups-lsst-codes-target-proxy"
  project    = "prompt-proto"
  proxy_bind = false
  url_map    = google_compute_url_map.default.id
}

resource "google_compute_url_map" "default" {
  name            = "eups-lsst-codes"
  default_service = google_compute_backend_bucket.eups_stack_tarball.id
  description     = null
  project         = "prompt-proto"
}
