output "out_vpc_self_link" {
  value = "${google_compute_network.vpc.name}"
}
