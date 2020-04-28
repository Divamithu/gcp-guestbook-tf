#####################################################################
# Modules
#####################################################################
//module "gke" {
//  source   = "../../modules/gke"
//  project  = "${var.project}"
//  region   = "${var.region}"
//  username = "${var.username}"
//  password = "${var.password}"
//  cluster_name= "${var.cluster_name}"
//  cluster_initial_node_count = "${var.cluster_initial_node_count}"
//}

//module "k8s" {
//  source   = "../../modules/k8s"
//  host     = "${module.gke.host}"
//  username = "${var.username}"
//  password = "${var.password}"

//  client_certificate     = "${module.gke.client_certificate}"
//  client_key             = "${module.gke.client_key}"
//  cluster_ca_certificate = "${module.gke.cluster_ca_certificate}"
//}

module "docs_bucket" {
  source = "../../modules/bucket"
  bucket_name = "uat_documents_for_guestbook_app"
  bucket_location = "EU"
  bucket_storage_class = "MULTI_REGIONAL"
  bucket_versioning = "true"
}

module "webapp-instances" {
  source                              = "../../modules/instance"
  env                                 = "uat"
  region                              = "${var.region}"
  instance-name                       = "webapp-uat-instance"
  server-count                        = "2"
  vm_type                             = "n1-standard-1"
  vms-description                     = "Description for uat instances"
  vm-boot-disk-device-name            = "uat_boot_disk"
  vm-boot-disk-image                  = "centos-7"
  vm-boot-disk-type                   = "pd-ssd"
  compute_instance_boot_disk_size			= "20"
  can_ip_forward					= "true"
  compute_instance_min_cpu_platform			= "Intel Skylake"
  compute_instance_allow_stopping_for_update		= "true"
  compute_instance_preemtible				= "false"
  compute_instance_on_host_maintenance			= "TERMINATE"
  compute_instance_automatic_restart			= "false"
}

module "postgres-instance-1" {
  source = "../../modules/postgres"
  env = "uat"
  region = "${var.region}"
  project = "${var.project}"
  postgresql-db-instance-name = "ha-postgres"
  postgresql-db-instance-type = "POSTGRES_9_6"
  postgresql-db-instance-machine-type = "db-f1-micro"
  postgresql-db-instance-activation-policy = "ALWAYS"
  postgresql-db-instance-availibility = "REGIONAL"
  postgresql-db-instance-disk-size = "30"
  postgresql-db-instance-disk-type = "PD_SSD"
  postgresql_username = "${var.uat_postgresql_username}"
  postgresql_user_password = "${var.uat_postgresql_user_password}"
}
