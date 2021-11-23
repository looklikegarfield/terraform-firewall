resource "google_compute_firewall" "default" {
  name    = "te-dev-fire-syst-firewall"
  network = google_compute_network.default.name

  allow {
    protocol = "icmp"
  }

  allow {
    protocol = "tcp"
    ports    = ["443", "4433", "1000-2000"]
  }

  source_tags = ["web"]
}

resource "google_compute_network" "default" {
  name = "te-dev-vpce-syst-testvpc"
  project                 = "my-project-name"
  auto_create_subnetworks = true
  mtu                     = 1500
}
