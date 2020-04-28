output "out_public_subnet_self_link" {
  value = "${google_compute_subnetwork.public-subnet.self_link}"
}
output "out_private_subnet_self_link" {
  value = "${google_compute_subnetwork.private-subnet.self_link}"
}
