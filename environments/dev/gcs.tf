terraform {
  backend "gcs" {
    bucket  = "barcamp2019-states"
    prefix  = "terraform/dev"
    credentials = "account.json"
  }
}
