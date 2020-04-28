variable "region" {
  default = "europe-west4"
}
variable "project" {
  default = "barcamp2019"
}
variable "private_subnet" {
  default = "10.26.0.0/24"
}
variable "public_subnet" {
  default = "10.26.1.0/24"
}
variable "allowed-internal-tcp-ports" {
  default = "0-65535"
}
variable "allowed-internal-udp-ports" {
  default = "0-65535"
}
variable "allowed-http-port" {
  default = "80"
}
variable "bastion-allowed-ssh-port" {
  default = "22"
}
variable "mysql_username" {
  default = "app-user"
}
variable "mysql_user_password" {
}
