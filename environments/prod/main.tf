#####################################################################
# Modules
#####################################################################

module "network" {
  source = "../../modules/vpc"
  env = "prod"
  private_subnet			= "${var.private_subnet}"
  public_subnet			= "${var.public_subnet}"
  allowed-internal-tcp-ports		= "${var.allowed-internal-tcp-ports}"
  allowed-internal-udp-ports		= "${var.allowed-internal-udp-ports}"
  allowed-http-port			= "${var.allowed-http-port}"
  bastion-allowed-ssh-port		= "${var.bastion-allowed-ssh-port}"
}

module "subnets" {
  source                              = "../../modules/subnet"
  env                                 = "prod"
  region                              = "${var.region}"
  network_self_link                   = "${module.network.out_vpc_self_link}"
  public_subnet                   = "${var.public_subnet}"
  private_subnet                  = "${var.private_subnet}"
}

module "docs_bucket" {
  source = "../../modules/bucket"
  bucket_name = "prod-guestbook_app_documents"
  bucket_location = "EU"
  bucket_storage_class = "MULTI_REGIONAL"
  bucket_versioning = "true"
}

module "myslq-instance-1" {
  source = "../../modules/mysql"
  env = "prod"
  region = "${var.region}"
  project = "${var.project}"
  mysql-db-instance-name = "mysql-instance"
  mysql-db-instance-type = "MYSQL_5_7"
  mysql-db-instance-machine-type = "db-f1-micro"
  mysql-db-instance-activation-policy = "ALWAYS"
  mysql-db-instance-disk-size = "20"
  mysql-db-instance-disk-type = "PD_SSD"
  mysql_username = "${var.mysql_username}"
  mysql_user_password = "${var.mysql_user_password}"
}

module "webapp-instances-prod" {
  source                              = "../../modules/instance"
  env                                 = "prod"
  region                              = "${var.region}"
  instance-name                       = "webapp-prod-instance"
  server-count                        = "3"
  vm_type                             = "n1-standard-1"
  vms-description                     = "Description for prod instances"
  vm-boot-disk-device-name            = "prod_boot_disk"
  vm-boot-disk-image                  = "centos-7"
  vm-boot-disk-type                   = "pd-ssd"
  compute_instance_boot_disk_size                       = "30"
  can_ip_forward                                        = "true"
  compute_instance_min_cpu_platform                     = "Intel Skylake"
  compute_instance_allow_stopping_for_update            = "true"
  compute_instance_preemtible                           = "false"
  compute_instance_on_host_maintenance                  = "TERMINATE"
  compute_instance_automatic_restart                    = "false"
}
