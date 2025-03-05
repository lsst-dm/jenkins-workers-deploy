#resource compute firewall allow-ssh
resource "google_compute_firewall" "allow_ssh" {
  name    = "allow-ssh"
  network = google_compute_network.net.id
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
