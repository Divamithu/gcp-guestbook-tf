#####################################################################
# Variables
#####################################################################
variable "username" {
  default = "admin"
}
variable "password" {}
variable "project" {
  default = "barcamp2019"
}
variable "region" {
  default = "europe-west4"
}
variable "cluster_initial_node_count" {
  default = "3"
}
variable "cluster_name" {
  default = "barcamp2019"
}
variable "postgresql_username" {}
variable "postgresql_user_password" {}
