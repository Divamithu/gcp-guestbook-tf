resource "google_compute_subnetwork" "public-subnet" {
  name          = "${var.env}-public-subnet"
  ip_cidr_range = "${var.public_subnet}"
  network       = "${var.network_self_link}"
  region        = "${var.region}"
}

resource "google_compute_subnetwork" "private-subnet" {
  name          = "${var.env}-private-subnet"
  ip_cidr_range = "${var.private_subnet}"
  network       = "${var.network_self_link}"
  region        = "${var.region}"
}

