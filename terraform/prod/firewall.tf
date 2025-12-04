#resource compute firewall allow-ssh
resource "google_compute_firewall" "allow_ssh" {
  name          = "allow-ssh"
  network       = google_compute_network.net.id
  source_ranges = ["0.0.0.0/0"]
  target_tags = [
    "external-ssh",
  ]
  allow {
    ports    = ["22"]
    protocol = "tcp"
  }
}

#resource compute firewall iap
resource "google_compute_firewall" "iap" {
  name          = "iap"
  network       = google_compute_network.net.id
  source_ranges = ["35.235.240.0/20"]



  allow {
    ports    = []
    protocol = "tcp"
  }
}

#resource compute firewall allow-ingress-from-iap
resource "google_compute_firewall" "allow_ingress_from_iap" {
  name          = "allow-ingress-from-iap"
  network       = google_compute_network.net.id
  description   = "Allow ingress to ssh from Identity-Aware Proxy"
  source_ranges = ["35.235.240.0/20"]
  target_tags = [
    "ssh",
  ]
  allow {
    ports    = ["22"]
    protocol = "tcp"
  }
}

#resource compute firewall prompt-proto-net-allow-http
resource "google_compute_firewall" "prompt_proto_net_allow_http" {
  name          = "prompt-proto-net-allow-http"
  network       = google_compute_network.net.id
  description   = "Allow prompt-proto http"
  source_ranges = ["0.0.0.0/0"]
  target_tags = [
    "http-server",
  ]
  allow {
    ports    = ["80"]
    protocol = "tcp"
  }
}

#resource compute firewall prompt-proto-net-allow-https
resource "google_compute_firewall" "prompt_proto_net_allow_https" {
  name          = "prompt-proto-net-allow-https"
  network       = google_compute_network.net.id
  description   = "Allow prompt-proto https"
  source_ranges = ["0.0.0.0/0"]
  target_tags = [
    "https-server",
  ]
  allow {
    ports    = ["443"]
    protocol = "tcp"
  }
}

#resource compute firewall gke-prompt-service-ingress
resource "google_compute_firewall" "gke_prompt_service_ingress" {
  name          = "gke-prompt-service-ingress"
  network       = google_compute_network.net.id
  description   = "Allow gke prompt service ingress"
  source_ranges = ["0.0.0.0/0"]
  allow {
    ports    = ["8086"]
    protocol = "tcp"
  }
}