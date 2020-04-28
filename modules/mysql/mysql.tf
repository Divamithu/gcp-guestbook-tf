#####################################################################
# ENABLE SQLADMIN API
#####################################################################

resource "google_project_service" "sqlapi" {
  project = "${var.project}"
  service = "sqladmin.googleapis.com"
  disable_on_destroy = false
  disable_dependent_services = false
}

resource "random_string" "mysqldb" {
  length		= 6
  special		= false
  lower			= true
  upper			= false
  number		= false
}
resource "google_sql_database_instance" "mysql" {
  name			= "${var.env}-${var.mysql-db-instance-name}-${random_string.mysqldb.result}"
  depends_on            = ["google_project_service.sqlapi"]
  database_version	= "${var.mysql-db-instance-type}"
  region		= "${var.region}"

  settings {
    tier		= "${var.mysql-db-instance-machine-type}"
    activation_policy	= "${var.mysql-db-instance-activation-policy}"
    disk_size		= "${var.mysql-db-instance-disk-size}"
    disk_type           = "${var.mysql-db-instance-disk-type}"
  }
  timeouts {
    create = "60m"
  }
}
resource "google_sql_user" "mysql-user" {
  name			= "${var.mysql_username}"
  depends_on            = ["google_sql_database_instance.mysql"]
  instance		= "${google_sql_database_instance.mysql.name}"
  host			= "example.com"
  password		= "${var.mysql_user_password}"
}
