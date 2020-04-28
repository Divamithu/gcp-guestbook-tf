#####################################################################
# ENABLE SQLADMIN API
#####################################################################

resource "google_project_service" "sqlapi" {
  project = "${var.project}"
  service = "sqladmin.googleapis.com"
  disable_on_destroy = false
  disable_dependent_services = false
}


resource "random_string" "postgresqldb" {
  length		= 6
  special		= false
  lower                 = true
  upper                 = false
  number                = false
}

resource "google_sql_database_instance" "postgresql" {
  name			= "${var.env}-${var.postgresql-db-instance-name}-${random_string.postgresqldb.result}"
  depends_on            = ["google_project_service.sqlapi"]
  database_version	= "${var.postgresql-db-instance-type}"
  region		= "${var.region}"

  settings {
    tier		= "${var.postgresql-db-instance-machine-type}"
    activation_policy   = "${var.postgresql-db-instance-activation-policy}"
    availability_type	= "${var.postgresql-db-instance-availibility}"
    disk_size		= "${var.postgresql-db-instance-disk-size}"
    disk_type		= "${var.postgresql-db-instance-disk-type}"
  }
  timeouts {
    create = "60m"
  }
}

resource "google_sql_user" "postgresql-user" {
  name			= "${var.postgresql_username}"
  depends_on            = ["google_sql_database_instance.postgresql"]
  instance		= "${google_sql_database_instance.postgresql.name}"
  password		= "${var.postgresql_user_password}"
}
