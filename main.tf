#resource "google_compute_firewall" "default" {
#  name    = "te-dev-fire-syst-firewall"
#  network = google_compute_network.default.name
#
#  allow {
#    protocol = "icmp"
#  }
#
#  allow {
#    protocol = "tcp"
#    ports    = ["443", "4433", "1000-2000"]
#  }
#
#  source_tags = ["web"]
#}

resource "google_compute_network" "default" {
  name = "te-dev-vpce-syst-testvpc"
  project                 = "my-project-name"
  auto_create_subnetworks = true
  mtu                     = 1500
}

module "firewall_rules" {
  source       = "terraform-google-modules/network/google//modules/firewall-rules"
  project_id   = var.project_id
  network_name = google_compute_network.default.name

  rules = [{
    name                    = "allow-ssh-ingress"
    description             = null
    direction               = "INGRESS"
    priority                = null
    ranges                  = ["10.0.0.0/8"]
    source_tags             = null
    source_service_accounts = null
    target_tags             = null
    target_service_accounts = null
    allow = [{
      protocol = "tcp"
      ports    = ["443", "4433", "1000"]
    }]
    deny = []
    log_config = {
      metadata = "INCLUDE_ALL_METADATA"
    }
  }]
}