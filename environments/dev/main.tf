#####################################################################
# Modules
#####################################################################
module "gke" {
  source   = "../../modules/gke"
  project  = "${var.project}"
  region   = "${var.region}"
  username = "${var.username}"
  password = "${var.password}"
  cluster_name= "${var.cluster_name}"
  cluster_initial_node_count = "${var.cluster_initial_node_count}"
}

module "k8s" {
  source   = "../../modules/k8s"
  host     = "${module.gke.host}"
  username = "${var.username}"
  password = "${var.password}"

  client_certificate     = "${module.gke.client_certificate}"
  client_key             = "${module.gke.client_key}"
  cluster_ca_certificate = "${module.gke.cluster_ca_certificate}"
}

module "images_bucket" {
  source = "../../modules/bucket"
  bucket_name = "guestbook_app_images"
  bucket_location = "EU"
  bucket_storage_class = "MULTI_REGIONAL"
  bucket_versioning = "false"
}

module "documents_bucket" {
  source = "../../modules/bucket"
  bucket_name = "guestbook_app_documents"
  bucket_location = "US"
  bucket_storage_class = "MULTI_REGIONAL"
  bucket_versioning = "true"
}

module "postgres-instance-1" {
  source = "../../modules/postgres"
  env = "dev"
  region = "${var.region}"
  project = "${var.project}"
  postgresql-db-instance-name = "ha-postgres"
  postgresql-db-instance-type = "POSTGRES_9_6"
  postgresql-db-instance-machine-type = "db-f1-micro"
  postgresql-db-instance-activation-policy = "ALWAYS"
  postgresql-db-instance-availibility = "REGIONAL"
  postgresql-db-instance-disk-size = "20"
  postgresql-db-instance-disk-type = "PD_SSD"
  postgresql_username = "${var.postgresql_username}"
  postgresql_user_password = "${var.postgresql_user_password}"
}
