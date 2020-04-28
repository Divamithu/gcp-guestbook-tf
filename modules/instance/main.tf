resource "google_compute_instance" "compute-engine-instances" {
  count				= "${var.server-count}"
  name				= "${var.env}-${var.instance-name}-${count.index}"
  machine_type			= "${var.vm_type}"
  zone				= "${var.region}-b"
  tags = [
    "app-server",
    "${var.env}-environment"
  ]
  description			= "${var.vms-description}"
  boot_disk {
    device_name			= "${var.vm-boot-disk-device-name}"
    initialize_params {
      size			= "${var.compute_instance_boot_disk_size}"
      type			= "${var.vm-boot-disk-type}"
      image			= "${var.vm-boot-disk-image}"
    }
  }
  network_interface {
    network = "default"

    access_config {
      // Ephemeral IP
    }
  }
//  metadata			= "${var.compute_instance_metadata}"
  can_ip_forward		= "${var.can_ip_forward}"
//  create_timeout		= "${var.compute_instance_create_timeout}"
  min_cpu_platform		= "${var.compute_instance_min_cpu_platform}"
  allow_stopping_for_update	= "${var.compute_instance_allow_stopping_for_update}"
  scheduling {
    preemptible			= "${var.compute_instance_preemtible}"
    on_host_maintenance		= "${var.compute_instance_on_host_maintenance}"
    automatic_restart		= "${var.compute_instance_automatic_restart}"
  }
}
