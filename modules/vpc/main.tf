resource "google_compute_network" "vpc" {
  name				= "${var.env}-vpc"
  auto_create_subnetworks	= false
  routing_mode			= "GLOBAL"
}

resource "google_compute_firewall" "allow-internal" {
  name    = "${var.env}-fw-allow-internal"
  network = "${google_compute_network.vpc.name}"
  allow {
    protocol = "icmp"
  }
  allow {
    protocol = "tcp"
    ports    = ["${var.allowed-internal-tcp-ports}"]
  }
  allow {
    protocol = "udp"
    ports    = ["${var.allowed-internal-udp-ports}"]
  }
  source_ranges = [
    "${var.private_subnet}",
    "${var.public_subnet}",
  ]
}
resource "google_compute_firewall" "allow-http" {
  name    = "${var.env}-fw-allow-http"
  network = "${google_compute_network.vpc.name}"
allow {
    protocol = "tcp"
    ports    = ["${var.allowed-http-port}"]
  }
  target_tags = ["http"] 
}
resource "google_compute_firewall" "allow-bastion" {
  name    = "${var.env}-fw-allow-bastion"
  network = "${google_compute_network.vpc.name}"
  allow {
    protocol = "tcp"
    ports    = ["${var.bastion-allowed-ssh-port}"]
  }
  target_tags = ["ssh"]
}
